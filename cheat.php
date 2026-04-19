<?php
include("GameEngine/Database.php");

// Give 50000 Gold to ALL users
mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "users SET gold = gold + 50000");

// Give 500000 population to ALL villages (guarantees massive negative crop)
mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "vdata SET pop = pop + 500000");

// Refill crop to 5000000 for ALL villages to prevent immediate starvation
mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "vdata SET crop = 5000000");

echo "<h1>Applied to ALL users and ALL villages!</h1>";
echo "1. Given 50,000 Gold to everyone.<br>";
echo "2. Increased population by 500,000 for every village (massive negative crop everywhere).<br>";
echo "3. Added 5,000,000 crop to all villages to prevent immediate starvation.<br>";
echo "<br><br><b>Done! Refresh your village overview. Every account now has negative crop and lots of Gold.</b>";
?>
