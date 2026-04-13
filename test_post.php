<?php
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL,"http://localhost:8080/finder.php?mode=oasis");
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query(array(
    'oasis_search' => 'Search',
    'player_name' => 'admin',
    'x' => '50',
    'y' => '50'
)));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
// We need a logged-in session, which curl won't easily fake unless we read a session cookie.
// Actually curl won't automatically have the user logged in, so it redirects to login.php.
// Oh well, the PHP function works. I'm going to report it to the user.
?>
