<?php
/**
 * Plus Feature: Buy Resources with Gold
 * Rate: 20,000 of each resource per 1 gold
 * Only works with purchased gold (non-free)
 * Fills warehouses up to max capacity
 */
$RESOURCE_PER_GOLD = 20000;

if (isset($_POST['buy_resources']) && isset($_POST['gold_amount'])) {

    // --- CSRF Validation ---
    if (
        !isset($_POST['csrf_token']) ||
        !isset($_SESSION['csrf_token']) ||
        !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])
    ) {
        header("Location: plus.php?id=3&error=csrf");
        exit;
    }
    // Rotate token after use
    unset($_SESSION['csrf_token']);

    $goldAmount = (int)$_POST['gold_amount'];
    
    if ($goldAmount <= 0) {
        header("Location: plus.php?id=3");
        exit;
    }
    
    if ($session->sit == 0 && $session->gold >= $goldAmount) {
        $MyGold = mysqli_query($database->dblink, "SELECT gold, paid_gold FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
        $golds = mysqli_fetch_array($MyGold);
        
        // Check paid_gold specifically
        $paidGold = isset($golds['paid_gold']) ? (int)$golds['paid_gold'] : 0;
        
        if ($paidGold >= $goldAmount) {
            $totalResources = $goldAmount * $RESOURCE_PER_GOLD;
            
            // Get current village resources and max storage
            $villageData = $database->getVillage($village->wid);
            $currentWood = $villageData['wood'];
            $currentClay = $villageData['clay'];
            $currentIron = $villageData['iron'];
            $currentCrop = $villageData['crop'];
            $maxStore = $villageData['maxstore'];
            $maxCrop = $villageData['maxcrop'];
            
            // Calculate how much to add (don't exceed max)
            $addWood = min($totalResources, $maxStore - $currentWood);
            $addClay = min($totalResources, $maxStore - $currentClay);
            $addIron = min($totalResources, $maxStore - $currentIron);
            $addCrop = min($totalResources, $maxCrop - $currentCrop);
            
            // Ensure no negative values
            $addWood = max(0, $addWood);
            $addClay = max(0, $addClay);
            $addIron = max(0, $addIron);
            $addCrop = max(0, $addCrop);
            
            // Add resources
            $database->modifyResource($village->wid, $addWood, $addClay, $addIron, $addCrop, 1);
            
            // Deduct from BOTH paid_gold and gold
            mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "users SET paid_gold = paid_gold - $goldAmount, gold = gold - $goldAmount WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
            mysqli_query($database->dblink, "INSERT INTO " . TB_PREFIX . "gold_fin_log (wid, log) VALUES ('" . $village->wid . "', 'Buy Resources ($goldAmount paid gold)')") or die(mysqli_error($database->dblink));
        } else {
            header("Location: plus.php?id=3&nopaid=1");
            exit;
        }
    }
}

header("Location: plus.php?id=3");
exit;
?>
