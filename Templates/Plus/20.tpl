<?php
/**
 * Plus Feature: 24-Hour Gold Protection
 * Base Cost: 1000 gold, doubles each activation (1000 → 2000 → 4000 → 8000...)
 * Requires password verification
 * Does NOT apply to villages with artifacts
 * Duration: 24 hours (86400 seconds)
 */
$PROTECTION_BASE_COST = 1000;
$PROTECTION_DURATION = 86400; // 24 hours

if (isset($_POST['activate_protection']) && isset($_POST['password'])) {
    $password = $_POST['password'];
    
    // Verify password
    $userRow = mysqli_query($database->dblink, "SELECT password, gold, gold_protect, gold_protect_count, is_bcrypt FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
    $userData = mysqli_fetch_array($userRow);
    
    // Password verification
    $passwordValid = false;
    if ($userData['is_bcrypt'] == 1) {
        $passwordValid = password_verify($password, $userData['password']);
    } else {
        $passwordValid = (md5($password) === $userData['password']);
    }
    
    if (!$passwordValid) {
        header("Location: plus.php?id=3&error=password");
        exit;
    }
    
    // Check if already under protection
    if ($userData['gold_protect'] > time()) {
        header("Location: plus.php?id=3&error=already_protected");
        exit;
    }
    
    // Calculate cost: base_cost * 2^count
    $activationCount = (int)$userData['gold_protect_count'];
    $currentCost = $PROTECTION_BASE_COST * pow(2, $activationCount);
    
    // Check gold
    if ($userData['gold'] < $currentCost) {
        header("Location: plus.php?id=3&error=gold");
        exit;
    }
    
    // Check if any village has an artifact - if so, that village is excluded from protection
    // But the protection itself can still be activated for non-artifact villages
    // We store the protection at user level, enforcement checks artifact at village level
    
    if ($session->sit == 0) {
        // Activate protection
        $protectUntil = time() + $PROTECTION_DURATION;
        $newCount = $activationCount + 1;
        $newGold = $userData['gold'] - $currentCost;
        
        mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "users SET gold_protect = '$protectUntil', gold_protect_count = '$newCount', gold = '$newGold' WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
        mysqli_query($database->dblink, "INSERT INTO " . TB_PREFIX . "gold_fin_log (wid, log) VALUES ('" . $village->wid . "', '24h Protection ($currentCost gold, activation #$newCount)')") or die(mysqli_error($database->dblink));
    }
    
    header("Location: plus.php?id=3&success=protection");
    exit;
} else {
    header("Location: plus.php?id=3");
    exit;
}
?>
