<?php
include("GameEngine/Database.php");
// Find user admin
$res = mysqli_query($database->dblink, "SELECT id FROM ".TB_PREFIX."users WHERE username='admin'");
if ($r = mysqli_fetch_assoc($res)) {
    $uid = $r['id'];
    echo "Found admin UID: $uid<br>";
    // Find one of his villages
    $vres = mysqli_query($database->dblink, "SELECT wref, name FROM ".TB_PREFIX."vdata WHERE owner=$uid LIMIT 1");
    if ($vr = mysqli_fetch_assoc($vres)) {
        $vid = $vr['wref'];
        $vname = $vr['name'];
        echo "Found village: $vid ($vname)<br>";
        
        // Find an unoccupied oasis
        $ores = mysqli_query($database->dblink, "SELECT wref FROM ".TB_PREFIX."odata WHERE conqured=0 LIMIT 1");
        if ($or = mysqli_fetch_assoc($ores)) {
            $oid = $or['wref'];
            echo "Found unoccupied oasis: $oid<br>";
            
            // Assign oasis to village
            mysqli_query($database->dblink, "UPDATE ".TB_PREFIX."odata SET conqured=$vid WHERE wref=$oid");
            echo "Assigned oasis $oid to village $vid ($vname) of user admin ($uid).<br>";
            // Give 5000 gold
            mysqli_query($database->dblink, "UPDATE ".TB_PREFIX."users SET gold=5000 WHERE id=$uid");
        } else {
            // Unoccupied not found, maybe he already has one?
            echo "No unoccupied oasis found. He might already have one.<br>";
            // Give 5000 gold
            mysqli_query($database->dblink, "UPDATE ".TB_PREFIX."users SET gold=5000 WHERE id=$uid");
        }
    } else {
        echo "Admin has no villages.";
    }
} else {
    echo "User admin not found.";
}
?>
