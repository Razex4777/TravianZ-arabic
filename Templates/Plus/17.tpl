<?php
// Instant reinforcement arrival - 35 gold
// Works on ALL returning troops to the current village
// Condition: returning army must NOT contain rams (u7), catapults (u8), or chiefs (u9)

$MyGold = mysqli_query($database->dblink, "SELECT * FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
$golds = mysqli_fetch_array($MyGold);

if ($golds['gold'] >= 35) {
    $now = time();
    $wid = (int) $village->wid;

    // Get all returning troop movements to this village (sort_type=4, to=$wid, proc=0)
    // Joined with attacks table to check unit composition
    $q = "SELECT m.moveid, m.ref, a.u7, a.u8, a.u9
          FROM " . TB_PREFIX . "movement m
          LEFT JOIN " . TB_PREFIX . "attacks a ON m.ref = a.id
          WHERE m.`to` = " . $wid . "
          AND m.proc = 0
          AND m.sort_type = 4
          AND m.endtime > " . $now;

    $result = mysqli_query($database->dblink, $q) or die(mysqli_error($database->dblink));
    $movements = [];

    while ($row = mysqli_fetch_assoc($result)) {
        // Check if returning army contains siege units or chiefs
        // u7 = rams, u8 = catapults, u9 = chiefs/leaders
        $hasSiege = ($row['u7'] > 0 || $row['u8'] > 0 || $row['u9'] > 0);

        if (!$hasSiege) {
            $movements[] = (int) $row['moveid'];
        }
    }

    // Also check movements with ref=0 (reinforcements without attacks record, sort_type=4)
    // These are simple return movements without siege units
    $q2 = "SELECT m.moveid FROM " . TB_PREFIX . "movement m
           WHERE m.`to` = " . $wid . "
           AND m.proc = 0
           AND m.sort_type = 4
           AND m.ref = 0
           AND m.endtime > " . $now;

    $result2 = mysqli_query($database->dblink, $q2) or die(mysqli_error($database->dblink));
    while ($row2 = mysqli_fetch_assoc($result2)) {
        $moveId = (int) $row2['moveid'];
        if (!in_array($moveId, $movements)) {
            $movements[] = $moveId;
        }
    }

    if (count($movements) > 0) {
        // Set endtime to now for all qualifying movements
        $moveIds = implode(',', $movements);
        mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "movement SET endtime = " . $now . " WHERE moveid IN (" . $moveIds . ")") or die(mysqli_error($database->dblink));

        // Deduct 35 gold
        $newgold = $golds['gold'] - 35;
        mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "users SET gold = " . $newgold . " WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));

        // Log the gold transaction
        $logging->goldFinLog($village->wid);
    }
}

header("Location: plus.php?id=3");
exit;
?>
