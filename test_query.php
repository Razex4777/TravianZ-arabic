<?php
include("GameEngine/Database.php");
$res = mysqli_query($database->dblink, "SELECT o.wref AS oasis_id, o.type, w.x, w.y, v.name AS village_name, v.wref AS village_id
FROM ".TB_PREFIX."odata o
JOIN ".TB_PREFIX."wdata w ON w.id = o.wref
JOIN ".TB_PREFIX."vdata v ON v.wref = o.conqured
WHERE v.owner = 6 AND o.conqured != 0");
while($r = mysqli_fetch_assoc($res)) {
    print_r($r);
    echo "\n";
}
?>
