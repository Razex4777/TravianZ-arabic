<?php if($session->alliance == $aid && $session->alliance > 0) {
?>
<div id="textmenu">
   <a href="allianz.php" <?php if(!isset($_GET['s']) && !isset($_POST['s'])) { echo "class=\"selected\""; } ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'نظرة عامة' : 'Overview'; ?></a>
 | <a href="allianz.php?s=2" <?php if(isset($_GET['s']) && $_GET['s'] == 2) { echo "class=\"selected\""; } ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'المنتدى' : 'Forum'; ?></a>
 | <a href="allianz.php?s=6" <?php if(isset($_GET['s']) && $_GET['s'] == 6) { echo "class=\"selected\""; } ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'الدردشة' : 'Chat'; ?></a>
 | <a href="allianz.php?s=3" <?php if(isset($_GET['s']) && $_GET['s'] == 3) { echo "class=\"selected\""; } ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'الهجمات' : 'Attacks'; ?></a>
 | <a href="allianz.php?s=4" <?php if(isset($_GET['s']) && $_GET['s'] == 4) { echo "class=\"selected\""; } ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'الأخبار' : 'News'; ?></a>
<?php
if($session->sit == 0){
?>
 | <a href="allianz.php?s=5" <?php if(isset($_GET['s']) && $_GET['s'] == 5 || isset($_POST['s']) && $_POST['s']) { echo "class=\"selected\""; } ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'الخيارات' : 'Options'; ?></a>
<?php
}else{
?>
 | <span class=none><b><?php echo (defined('LANG') && LANG === 'ar') ? 'الخيارات' : 'Options'; ?></b></span>
<?php 
}
?>
</div>
<?php 
}
?>