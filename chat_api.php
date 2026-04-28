<?php
/**
 * Chat API — AJAX endpoint for the Public Chat system
 * 
 * Handles:
 *   GET  ?action=fetch&after=<id>  → Returns messages newer than <id>
 *   POST ?action=send              → Sends a new chat message
 *   POST ?action=delete&id=<id>    → Admin-only: delete a message
 */

// Preserve referrer before Session overwrites it with this API script path
$savedSessionUrl = isset($_SESSION['url']) ? $_SESSION['url'] : null;

include_once("GameEngine/Session.php");
include_once("GameEngine/Village.php");
include_once("GameEngine/Generator.php");

// Restore so API calls don't clobber the user's actual page referrer
if ($savedSessionUrl !== null) $_SESSION['url'] = $savedSessionUrl;

header('Content-Type: application/json; charset=utf-8');

// Must be logged in
if (!$session->logged_in) {
    http_response_code(401);
    echo json_encode(['error' => 'Not authenticated']);
    exit;
}

// Ensure the chat table exists (auto-create on first use)
ensureChatTable($database);

$action = isset($_GET['action']) ? $_GET['action'] : (isset($_POST['action']) ? $_POST['action'] : '');

switch ($action) {
    case 'fetch':
        handleFetch($database, $session);
        break;
    case 'send':
        handleSend($database, $session);
        break;
    case 'delete':
        handleDelete($database, $session);
        break;
    case 'unread':
        handleUnread($database, $session);
        break;
    default:
        http_response_code(400);
        echo json_encode(['error' => 'Invalid action']);
}

// ─────────────────────────────────────────────────────────────
// Handlers
// ─────────────────────────────────────────────────────────────

function handleFetch($database, $session) {
    $afterId = isset($_GET['after']) ? (int)$_GET['after'] : 0;
    $limit   = isset($_GET['limit']) ? min((int)$_GET['limit'], 100) : 50;

    $messages = getChatMessages($database, $afterId, $limit);
    
    // Get valid ids for sync (last 100)
    $tableName = TB_PREFIX . 'public_chat';
    $validIds = [];
    $sql = "SELECT id FROM `{$tableName}` ORDER BY id DESC LIMIT 100";
    $res = mysqli_query($database->dblink, $sql);
    if ($res) {
        while ($row = mysqli_fetch_assoc($res)) {
            $validIds[] = (int)$row['id'];
        }
    }
    
    echo json_encode([
        'ok'       => true,
        'messages' => $messages,
        'valid_ids'=> $validIds,
        'uid'      => $session->uid
    ]);
}

function handleSend($database, $session) {
    // Rate limit: max 10 messages per minute
    $recentCount = getChatRateCount($database, $session->uid);
    if ($recentCount >= 10) {
        http_response_code(429);
        echo json_encode(['error' => 'Too many messages. Wait a moment.']);
        return;
    }

    $text = isset($_POST['message']) ? trim($_POST['message']) : '';
    if (empty($text)) {
        http_response_code(400);
        echo json_encode(['error' => 'Empty message']);
        return;
    }

    // Limit message length
    $text = mb_substr($text, 0, 500);

    // Word censor
    if (defined('WORD_CENSOR') && !empty(CENSORED)) {
        $censorArray = explode(",", CENSORED);
        foreach ($censorArray as $key => $value) {
            $censorArray[$key] = "/" . trim($value) . "/i";
        }
        $text = preg_replace($censorArray, "****", $text);
    }

    // Sanitize
    $text = htmlspecialchars($text, ENT_QUOTES, 'UTF-8');

    // Apply BBCode to parse [report] tags and smiles
    $input = $text;
    include_once("GameEngine/Message.php");
    global $message;
    if (!isset($message) || !is_object($message)) {
        $message = new Message();
    }
    include("GameEngine/BBCode.php");
    $text = $bbcoded;

    insertChatMessage($database, $session->uid, $session->username, $text);
    echo json_encode(['ok' => true]);
}

function handleDelete($database, $session) {
    $id = isset($_POST['id']) ? (int)$_POST['id'] : (isset($_GET['id']) ? (int)$_GET['id'] : 0);
    if ($id <= 0) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid ID']);
        return;
    }
    
    $tableName = TB_PREFIX . 'public_chat';
    $sql = "SELECT uid FROM `{$tableName}` WHERE id = {$id}";
    $res = mysqli_query($database->dblink, $sql);
    if ($res && $row = mysqli_fetch_assoc($res)) {
        // Only the message author can delete their own message
        if ($row['uid'] == $session->uid) {
            deleteChatMessage($database, $id);
            echo json_encode(['ok' => true]);
            return;
        }
    }

    http_response_code(403);
    echo json_encode(['error' => 'Permission denied']);
}

function handleUnread($database, $session) {
    $since = isset($_GET['since']) ? (int)$_GET['since'] : 0;
    $uid = (int)$session->uid;
    $tableName = TB_PREFIX . 'public_chat';
    
    // Count messages newer than $since, excluding the user's own messages
    $sql = "SELECT COUNT(*) as cnt FROM `{$tableName}` WHERE created_at > {$since} AND uid != {$uid}";
    $result = mysqli_query($database->dblink, $sql);
    $count = 0;
    if ($result) {
        $row = mysqli_fetch_assoc($result);
        $count = (int)$row['cnt'];
    }
    echo json_encode(['ok' => true, 'count' => $count]);
}

// ─────────────────────────────────────────────────────────────
// Database helpers
// ─────────────────────────────────────────────────────────────

function ensureChatTable($database) {
    $tableName = TB_PREFIX . 'public_chat';
    $check = mysqli_query($database->dblink, "SHOW TABLES LIKE '{$tableName}'");
    if (mysqli_num_rows($check) == 0) {
        $sql = "CREATE TABLE `{$tableName}` (
            `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
            `uid` INT(11) UNSIGNED NOT NULL,
            `username` VARCHAR(100) NOT NULL,
            `message` TEXT NOT NULL,
            `created_at` INT(11) UNSIGNED NOT NULL,
            PRIMARY KEY (`id`),
            KEY `idx_created` (`created_at`),
            KEY `idx_uid` (`uid`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";
        mysqli_query($database->dblink, $sql);
    } else {
        $chkCol = mysqli_query($database->dblink,
            "SELECT CHARACTER_SET_NAME FROM information_schema.COLUMNS
             WHERE TABLE_SCHEMA = DATABASE()
               AND TABLE_NAME = '{$tableName}'
               AND COLUMN_NAME = 'message' LIMIT 1");
        if ($chkCol && ($chkRow = mysqli_fetch_assoc($chkCol)) && strtolower($chkRow['CHARACTER_SET_NAME']) !== 'utf8mb4') {
            mysqli_query($database->dblink, "ALTER TABLE {$tableName} CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
        }
    }
}

function getChatMessages($database, $afterId = 0, $limit = 50) {
    $tableName = TB_PREFIX . 'public_chat';
    $afterId = (int)$afterId;
    $limit   = (int)$limit;

    if ($afterId > 0) {
        $sql = "SELECT id, uid, username, message, created_at 
                FROM `{$tableName}` 
                WHERE id > {$afterId} 
                ORDER BY id ASC 
                LIMIT {$limit}";
    } else {
        // Initial load: get the last N messages
        $sql = "SELECT id, uid, username, message, created_at 
                FROM `{$tableName}` 
                ORDER BY id DESC 
                LIMIT {$limit}";
    }

    $result = mysqli_query($database->dblink, $sql);
    $messages = [];
    if ($result) {
        while ($row = mysqli_fetch_assoc($result)) {
            $row['id'] = (int)$row['id'];
            $row['uid'] = (int)$row['uid'];
            $row['created_at'] = (int)$row['created_at'];
            $messages[] = $row;
        }
    }

    // If initial load (no afterId), reverse so oldest is first
    if ($afterId == 0) {
        $messages = array_reverse($messages);
    }

    return $messages;
}

function getChatRateCount($database, $uid) {
    $tableName = TB_PREFIX . 'public_chat';
    $uid = (int)$uid;
    $oneMinuteAgo = time() - 60;
    $sql = "SELECT COUNT(*) as cnt FROM `{$tableName}` WHERE uid = {$uid} AND created_at > {$oneMinuteAgo}";
    $result = mysqli_query($database->dblink, $sql);
    if ($result) {
        $row = mysqli_fetch_assoc($result);
        return (int)$row['cnt'];
    }
    return 0;
}

function insertChatMessage($database, $uid, $username, $message) {
    $tableName = TB_PREFIX . 'public_chat';
    $uid = (int)$uid;
    $username = mysqli_real_escape_string($database->dblink, $username);
    $message  = mysqli_real_escape_string($database->dblink, $message);
    $now = time();
    $sql = "INSERT INTO `{$tableName}` (uid, username, message, created_at) VALUES ({$uid}, '{$username}', '{$message}', {$now})";
    mysqli_query($database->dblink, $sql);
}

function deleteChatMessage($database, $id) {
    $tableName = TB_PREFIX . 'public_chat';
    $id = (int)$id;
    $sql = "DELETE FROM `{$tableName}` WHERE id = {$id}";
    mysqli_query($database->dblink, $sql);
}
?>
