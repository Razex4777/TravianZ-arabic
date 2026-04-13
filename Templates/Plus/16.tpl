<?php
// Instant training completion - 35 gold
$MyGold = mysqli_query($database->dblink, "SELECT * FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
$golds = mysqli_fetch_array($MyGold);

if ($golds['gold'] >= 35) {
    $finishedCount = $technology->finishTraining();

    if ($finishedCount > 0) {
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
