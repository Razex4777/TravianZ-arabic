<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       editCrops.php                                               ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2011-2025. All rights reserved.                ##
#################################################################################

if(!isset($_SESSION)) session_start();
if($_SESSION['access'] < 9) die("<h1><font color=\"red\">Access Denied: You are not Admin!</font></h1>");

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

foreach ($_POST as $key => $value) {
    $_POST[$key] = $database->escape($value);
}

$id = (int) $_POST['id'];
$type = (int) $_POST['type']; // 1 or 6
$v_wood = (int) $_POST['wood'];
$v_clay = (int) $_POST['clay'];
$v_iron = (int) $_POST['iron'];
$v_crop = (int) $_POST['crop'];

if($type == 1) { // 9 Cropper
    $types = array(4,4,1,4,4,2,3,4,4,3,3,4,4,1,4,2,1,2);
} elseif ($type == 6) { // 15 Cropper
    $types = array(4,4,1,3,4,4,4,4,4,4,4,4,4,4,4,2,4,4);
} else {
    // Default to 15 Cropper if unknown somehow
    $types = array(4,4,1,3,4,4,4,4,4,4,4,4,4,4,4,2,4,4);
    $type = 6;
}

$update_parts = array();
for($i = 0; $i < 18; $i++) {
    $f = $i + 1;
    $t = $types[$i];
    $lvl = 0;
    if($t == 1) $lvl = $v_wood;
    elseif($t == 2) $lvl = $v_clay;
    elseif($t == 3) $lvl = $v_iron;
    elseif($t == 4) $lvl = $v_crop;
    
    $update_parts[] = "f{$f} = {$lvl}";
    $update_parts[] = "f{$f}t = {$t}";
}

$update_str = implode(", ", $update_parts);

mysqli_query($GLOBALS["link"], "UPDATE ".TB_PREFIX."wdata SET type = {$type} WHERE id = $id") or die(mysqli_error($GLOBALS["link"]));
mysqli_query($GLOBALS["link"], "UPDATE ".TB_PREFIX."fdata SET {$update_str} WHERE vref = $id") or die(mysqli_error($GLOBALS["link"]));

header("Location: ../../../Admin/admin.php?p=village&did=".$id);
?>
