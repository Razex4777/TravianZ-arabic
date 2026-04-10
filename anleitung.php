<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       anleitung.php                                               ##
##  Developed by:  Dzoki                                                       ##
##  License:       TravianX Project                                            ##
##  Copyright:     TravianX (c) 2010-2011. All rights reserved.                ##
##                                                                             ##
#################################################################################

use App\Utils\AccessLogger;

include_once("GameEngine/config.php");
include_once("GameEngine/Database.php");
include_once("GameEngine/Lang/".LANG.".php");
AccessLogger::logRequest();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"<?php echo (defined('LANG') && LANG === 'ar') ? ' dir="rtl"' : ''; ?>>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title><?php echo SERVER_NAME; ?></title>
	<link rel="stylesheet" type="text/css" href="img/tutorial/main.css"/>
	<link rel="stylesheet" type="text/css" href="img/tutorial/flaggs.css"/>
	<meta name="content-language" content="en"/>
	<meta http-equiv="imagetoolbar" content="no"/>
	<script src="mt-core.js" type="text/javascript"></script>
	<script src="new.js" type="text/javascript"></script>
	<style type="text/css" media="screen">

	</style>

	<?php if(defined('LANG') && LANG === 'ar'): ?>
	<style type="text/css">
	/* === RTL Overrides for Arabic === */
	body {
		direction: rtl;
		text-align: right;
	}
	.wrapper #content { text-align: right; }

	/* Navigation — keep structure LTR (ribbon bg is left-anchored) */
	#navigation { direction: ltr; }
	#navigation table.menu { direction: rtl; width: auto; white-space: nowrap; }
	#navigation .menu a, #navigation .menu a span { padding-left: 4px; padding-right: 4px; }

	/* Content text & images */
	body.contentPage #content p img[align="left"] { float: right; margin: 0 0 10px 15px; }
	body.contentPage #content p img[align="right"] { float: left; margin: 0 15px 10px 0; }

	/* Table cells */
	td.text, th.text { padding-left: 0; padding-right: 7px; text-align: right; }

	/* Submenu */
	p.submenu { text-align: right; }

	/* Tutorial navigation */
	#tutorial_nav td.nav_prev { text-align: right; }
	#tutorial_nav td.nav_next { text-align: left; }

	/* Footer — keep structure LTR */
	#footer { direction: ltr; }
	#footer .copyright { direction: rtl; }

	/* FAQ */
	#content .question { text-align: right; }
	#content .answer { text-align: right; }

	/* Culture points table */
	body.contentPage table.culture_points { margin: 15px 110px; }

	/* Rules */
	body.contentPage .rules { margin-left: 160px; margin-right: 120px; }
	</style>
	<?php endif; ?>
</head>
<body class="webkit contentPage">
<div class="wrapper">
<div id="country_select">

</div>
<div id="header">
	<h1>Welcome to <?php echo SERVER_NAME; ?></h1>
</div>

<div id="navigation">

<a href="index.php" class="home"><img src="img/x.gif" alt="Travian"/></a>

	<table class="menu">

	<tr>

		<td><a href="tutorial.php"><span><?php echo TUTORIAL; ?></span></a></td>

		<td><a href="anleitung.php"><span><?php echo $lang['index'][0][2]; ?></span></a></td>

		<td><a href="http://forum.travian.com/" target="_blank"><span><?php echo $lang['forum']; ?></span></a></td>

		<td><a href="index.php?signup"><span><?php echo $lang['register']; ?></span></a></td>

		<td><a href="index.php?login"><span><?php echo LOGIN; ?></span></a></td>

</tr>

	</table>

</div>






<div id="content">

	<div class="grit">


<h1><?php echo $lang['index'][0][2]; ?></h1>



<p class="submenu">

<a href="anleitung.php"><?php echo TRIBES; ?></a> |

<a href="anleitung.php?s=1"><?php echo BUILDINGS; ?></a> |

<a href="anleitung.php?s=3"><?php echo FAQ; ?></a>

</p>



<?php
if(!isset($_GET['s'])) {
$_GET['s'] = ""; }
$anleitungLangDir = (defined('LANG') && LANG === 'ar') ? "Templates/Anleitung/ar/" : "Templates/Anleitung/";
if ($_GET['s'] == "") {
include($anleitungLangDir . "0.tpl"); }
if ($_GET['s'] == "1") {
include($anleitungLangDir . "1.tpl"); }
if ($_GET['s'] == "3") {
include($anleitungLangDir . "3.tpl"); }
if ($_GET['s'] == "4") {
include($anleitungLangDir . "4.tpl"); }
?>



</ul>

<div class="footer"></div>

</div>

</div>

<div id="footer">
	<div class="container">
		<div class="copyright">&copy; <?php echo date('Y') . ' ' . SERVER_NAME; ?></div>
	</div>
</div>

<div id="iframe_layer" class="overlay">



<div class="mask closer"></div>







<div class="overlay_content">

<a href="index.php" class="closer"><img class="dynamic_img" alt="Close" src="img/un/x.gif" /></a>

<h2><?php echo $lang['index'][0][2]; ?></h2>



<div id="frame_box" >

</div>

<div class="footer"></div>

</div>



</div>




</body>
</html>