<?php
/**
 * Plus Feature: 75% Crop Consumption Reduction
 * Cost: 350 gold
 * Duration: 5 hours (18000 seconds)
 * Adds 75% of base crop field production as a flat bonus to net crop,
 * regardless of whether net crop is positive or negative.
 */
$CROP_REDUCTION_COST = 350;
$CROP_REDUCTION_DURATION = 18000; // 5 hours

if ($session->gold >= $CROP_REDUCTION_COST) {
    $MyGold = mysqli_query($database->dblink, "SELECT gold, crop_reduction FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
    $golds = mysqli_fetch_array($MyGold);

    if ($session->sit == 0) {
        if (mysqli_num_rows($MyGold) == 1) {
            if ($golds['gold'] >= $CROP_REDUCTION_COST) {
                if ($golds['crop_reduction'] == 0 || $golds['crop_reduction'] <= time()) {
                    // Activate fresh
                    $newTime = time() + $CROP_REDUCTION_DURATION;
                    mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "users SET crop_reduction = '$newTime' WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
                } else {
                    // Extend existing
                    $newTime = $golds['crop_reduction'] + $CROP_REDUCTION_DURATION;
                    mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "users SET crop_reduction = '$newTime' WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
                }
                // Deduct gold
                mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "users SET gold = " . ($session->gold - $CROP_REDUCTION_COST) . " WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
                mysqli_query($database->dblink, "INSERT INTO " . TB_PREFIX . "gold_fin_log (wid, log) VALUES ('" . $village->wid . "', '75% Crop Reduction')") or die(mysqli_error($database->dblink));
            }
        }
    }
}
header("Location: plus.php?id=3");
exit;
?>
