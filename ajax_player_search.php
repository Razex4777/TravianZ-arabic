<?php
include_once("GameEngine/Generator.php");
include_once("GameEngine/config.php");
include_once("GameEngine/Village.php");

header('Content-Type: application/json');

$q = isset($_GET['q']) ? trim($_GET['q']) : '';

if (strlen($q) < 3) {
    echo json_encode([]);
    exit;
}

$TBP = defined('TB_PREFIX') ? TB_PREFIX : 's1_';
$USERS = $TBP . 'users';

$q_esc = mysqli_real_escape_string($database->dblink, $q);
// Search for usernames starting with the query string
$sql = "SELECT username FROM `$USERS` WHERE username LIKE '$q_esc%' LIMIT 10";
$res = mysqli_query($database->dblink, $sql);

$results = [];
if ($res) {
    while ($row = mysqli_fetch_assoc($res)) {
        $results[] = $row['username'];
    }
}

echo json_encode($results);
?>
