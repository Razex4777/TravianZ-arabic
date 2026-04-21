<?php
include_once("GameEngine/Session.php");
include_once("GameEngine/Village.php");

header('Content-Type: application/json; charset=utf-8');

if (!$session->logged_in) {
    http_response_code(401);
    echo json_encode(['ok' => false, 'error' => 'Not authenticated']);
    exit;
}

$action = isset($_GET['action']) ? $_GET['action'] : (isset($_POST['action']) ? $_POST['action'] : '');

switch ($action) {
    case 'threads':
        handleThreads($database, $session);
        break;
    case 'messages':
        handleMessages($database, $session);
        break;
    case 'send':
        handleSend($database, $session);
        break;
    case 'mark_read':
        handleMarkRead($database, $session);
        break;
    case 'search':
        handleSearch($database, $session);
        break;
    case 'summary':
        handleSummary($database, $session);
        break;
    default:
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Invalid action']);
        break;
}

function handleThreads($database, $session) {
    $uid = (int) $session->uid;
    $limit = isset($_GET['limit']) ? max(10, min((int) $_GET['limit'], 1000)) : 500;

    $sql = "SELECT id, owner, target, message, time, viewed FROM " . TB_PREFIX . "mdata
            WHERE send = 0
              AND topic = 'Direct chat'
              AND ((owner = $uid AND delowner = 0) OR (target = $uid AND deltarget = 0))
            ORDER BY time DESC, id DESC
            LIMIT $limit";

    $res = mysqli_query($database->dblink, $sql);
    if (!$res) {
        http_response_code(500);
        echo json_encode(['ok' => false, 'error' => 'Failed to load threads']);
        return;
    }

    $threadsByPeer = [];
    $peerIds = [];

    while ($row = mysqli_fetch_assoc($res)) {
        $owner = (int) $row['owner'];
        $target = (int) $row['target'];
        $peerId = ($owner === $uid) ? $target : $owner;
        if ($peerId <= 0) {
            continue;
        }

        if (!isset($threadsByPeer[$peerId])) {
            $threadsByPeer[$peerId] = [
                'peer_id' => $peerId,
                'last_message' => $row['message'],
                'last_time' => (int) $row['time'],
                'last_id' => (int) $row['id'],
                'unread_count' => 0
            ];
            $peerIds[$peerId] = true;
        }

        if ($target === $uid && (int) $row['viewed'] === 0) {
            $threadsByPeer[$peerId]['unread_count']++;
        }
    }

    $usernames = [];
    if (!empty($peerIds)) {
        $idList = implode(',', array_map('intval', array_keys($peerIds)));
        $resUsers = mysqli_query($database->dblink, "SELECT id, username FROM " . TB_PREFIX . "users WHERE id IN ($idList)");
        if ($resUsers) {
            while ($u = mysqli_fetch_assoc($resUsers)) {
                $usernames[(int) $u['id']] = $u['username'];
            }
        }
    }

    $threads = [];
    foreach ($threadsByPeer as $peerId => $thread) {
        $thread['peer_name'] = isset($usernames[$peerId]) ? $usernames[$peerId] : ('User #' . $peerId);
        $threads[] = $thread;
    }

    usort($threads, function ($a, $b) {
        if ($a['last_time'] === $b['last_time']) {
            return $b['last_id'] - $a['last_id'];
        }
        return $b['last_time'] - $a['last_time'];
    });

    echo json_encode(['ok' => true, 'threads' => $threads, 'uid' => $uid]);
}

function handleMessages($database, $session) {
    $uid = (int) $session->uid;
    $peerId = isset($_GET['peer_id']) ? (int) $_GET['peer_id'] : 0;
    $afterId = isset($_GET['after_id']) ? (int) $_GET['after_id'] : 0;
    $limit = isset($_GET['limit']) ? max(10, min((int) $_GET['limit'], 200)) : 100;

    if ($peerId <= 0 || $peerId === $uid) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Invalid peer']);
        return;
    }

    $idClause = $afterId > 0 ? "AND id > $afterId" : '';
    $sql = "SELECT id, owner, target, message, time, viewed FROM " . TB_PREFIX . "mdata
            WHERE send = 0
              AND topic = 'Direct chat'
              AND (
                    (owner = $uid AND target = $peerId AND delowner = 0)
                 OR (owner = $peerId AND target = $uid AND deltarget = 0)
              )
              $idClause
            ORDER BY id ASC
            LIMIT $limit";

    $res = mysqli_query($database->dblink, $sql);
    if (!$res) {
        http_response_code(500);
        echo json_encode(['ok' => false, 'error' => 'Failed to load messages']);
        return;
    }

    $messages = [];
    while ($row = mysqli_fetch_assoc($res)) {
        $messages[] = [
            'id' => (int) $row['id'],
            'owner' => (int) $row['owner'],
            'target' => (int) $row['target'],
            'message' => $row['message'],
            'time' => (int) $row['time'],
            'viewed' => (int) $row['viewed']
        ];
    }

    echo json_encode(['ok' => true, 'messages' => $messages, 'uid' => $uid]);
}

function handleSend($database, $session) {
    $uid = (int) $session->uid;
    $peerId = isset($_POST['peer_id']) ? (int) $_POST['peer_id'] : 0;
    $rawMessage = isset($_POST['message']) ? trim($_POST['message']) : '';

    if ($peerId <= 0 || $peerId === $uid) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Invalid peer']);
        return;
    }

    if ($rawMessage === '') {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Empty message']);
        return;
    }

    $messageText = mb_substr($rawMessage, 0, 1000);
    $censoredWords = defined('CENSORED') ? constant('CENSORED') : '';
    if (defined('WORD_CENSOR') && $censoredWords !== '') {
        $censorArray = explode(',', $censoredWords);
        foreach ($censorArray as $key => $value) {
            $censorArray[$key] = '/' . trim($value) . '/i';
        }
        $messageText = preg_replace($censorArray, '****', $messageText);
    }

    $messageSafe = htmlspecialchars($messageText, ENT_QUOTES, 'UTF-8');

    $topic = mysqli_real_escape_string($database->dblink, 'Direct chat');
    $body = mysqli_real_escape_string($database->dblink, $messageSafe);
    $time = time();

    $sql = "INSERT INTO " . TB_PREFIX . "mdata
            (id, target, owner, topic, message, viewed, archived, send, time, deltarget, delowner, alliance, player, coor, report)
            VALUES
            (0, $peerId, $uid, '$topic', '$body', 0, 0, 0, $time, 0, 0, 0, 0, 0, 0)";

    if (!mysqli_query($database->dblink, $sql)) {
        http_response_code(500);
        echo json_encode(['ok' => false, 'error' => 'Failed to send']);
        return;
    }

    echo json_encode([
        'ok' => true,
        'message' => [
            'id' => (int) mysqli_insert_id($database->dblink),
            'owner' => $uid,
            'target' => $peerId,
            'message' => $messageSafe,
            'time' => $time,
            'viewed' => 0
        ]
    ]);
}

function handleMarkRead($database, $session) {
    $uid = (int) $session->uid;
    $peerId = isset($_POST['peer_id']) ? (int) $_POST['peer_id'] : (isset($_GET['peer_id']) ? (int) $_GET['peer_id'] : 0);

    if ($peerId <= 0) {
        http_response_code(400);
        echo json_encode(['ok' => false, 'error' => 'Invalid peer']);
        return;
    }

    $sql = "UPDATE " . TB_PREFIX . "mdata
            SET viewed = 1
            WHERE send = 0
              AND topic = 'Direct chat'
              AND owner = $peerId
              AND target = $uid
              AND viewed = 0
              AND deltarget = 0";

    mysqli_query($database->dblink, $sql);
    echo json_encode(['ok' => true]);
}

function handleSummary($database, $session) {
    $uid = (int) $session->uid;

    $qMessages = "SELECT COUNT(*) AS cnt FROM " . TB_PREFIX . "mdata
                 WHERE send = 0 AND target = $uid AND viewed = 0 AND deltarget = 0 AND topic = 'Direct chat'";
    $rMessages = mysqli_query($database->dblink, $qMessages);
    $messagesUnread = $rMessages ? (int) mysqli_fetch_assoc($rMessages)['cnt'] : 0;

    $qNotices = "SELECT COUNT(*) AS cnt FROM " . TB_PREFIX . "ndata WHERE uid = $uid AND viewed = 0";
    $rNotices = mysqli_query($database->dblink, $qNotices);
    $noticesUnread = $rNotices ? (int) mysqli_fetch_assoc($rNotices)['cnt'] : 0;

    echo json_encode([
        'ok' => true,
        'messages_unread' => $messagesUnread,
        'notices_unread' => $noticesUnread
    ]);
}

function handleSearch($database, $session) {
    $uid = (int) $session->uid;
    $q = isset($_GET['q']) ? trim($_GET['q']) : '';
    
    if (mb_strlen($q) < 2) {
        echo json_encode(['ok' => true, 'users' => []]);
        return;
    }
    
    $qSafe = mysqli_real_escape_string($database->dblink, $q);
    $sql = "SELECT id, username FROM " . TB_PREFIX . "users 
            WHERE username LIKE '%$qSafe%' 
              AND id != $uid 
              AND access >= 0 
            LIMIT 10";
            
    $res = mysqli_query($database->dblink, $sql);
    $users = [];
    if ($res) {
        while ($row = mysqli_fetch_assoc($res)) {
            $users[] = [
                'id' => (int) $row['id'],
                'username' => $row['username']
            ];
        }
    }
    
    echo json_encode(['ok' => true, 'users' => $users]);
}
