<?php
include "GameEngine/Database.php";
include "GameEngine/Session.php";

if(!$session->logged_in) {
    die("Not logged in");
}

if(isset($_POST['order']) && is_array($_POST['order'])) {
    foreach($_POST['order'] as $index => $id) {
        $id = (int)$id;
        $index = (int)$index;
        $getData = $database->getRaidList($id);
        if($getData) {
            $FLData = $database->getFLData($getData['lid']);
            if($FLData['owner'] == $session->uid) {
                mysqli_query($database->dblink, "UPDATE ".TB_PREFIX."raidlist SET sort_order = $index WHERE id = $id");
            }
        }
    }
    echo "Success";
}
?>
