<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       gold_1.php                                                   ##
##  Developed by:  aggenkeech                                                  ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
##                                                                             ##
#################################################################################
if (!isset($_SESSION)) session_start();
if($_SESSION['access'] < 9) die("Access Denied: You are not Admin!");
include_once("../../config.php");

// go max 5 levels up - we don't have folders that go deeper than that
$autoprefix = '';
for ($i = 0; $i < 5; $i++) {
    $autoprefix = str_repeat('../', $i);
    if (file_exists($autoprefix.'autoloader.php')) {
        // we have our path, let's leave
        break;
    }
}

include_once($autoprefix."GameEngine/Database.php");

$session = (int) $_POST['admid'];
$id = (int) $_POST['id'];

$sql = mysqli_query($GLOBALS["link"], "SELECT * FROM ".TB_PREFIX."users WHERE id = ".$session."");
$access = mysqli_fetch_array($sql);
$sessionaccess = $access['access'];

if($sessionaccess != 9) die("<h1><font color=\"red\">Access Denied: You are not Admin!</font></h1>");

$isPaid = isset($_POST['is_paid']) && $_POST['is_paid'] == '1';
$goldAmt = (int) $_POST['gold'];

if ($isPaid) {
    // Real money purchase — credit both gold and paid_gold
    mysqli_query($GLOBALS["link"], "UPDATE ".TB_PREFIX."users SET gold = gold + $goldAmt, paid_gold = paid_gold + $goldAmt WHERE id = ".$id."");
} else {
    // Free/gift gold — only credit the main gold column
    mysqli_query($GLOBALS["link"], "UPDATE ".TB_PREFIX."users SET gold = gold + $goldAmt WHERE id = ".$id."");
}

header("Location: ../../../Admin/admin.php?p=usergold&g");
?>