<div id="textmenu">
   <a href="nachrichten.php?t=5" <?php if(isset($_GET['t']) && $_GET['t'] == 5) { echo "class=\"selected\""; } ?>><?php echo (defined('LANG') && LANG === 'ar' ? 'الدردشة العامة' : 'Public Chat'); ?></a>
 | <a href="nachrichten.php" <?php if(!isset($_GET['t'])) { echo "class=\"selected\""; } ?>><?php echo (defined('LANG') && LANG === 'ar' ? 'صندوق الوارد' : 'Inbox'); ?></a>
 | <a href="nachrichten.php?t=1" <?php if(isset($_GET['t']) && $_GET['t'] == 1) { echo "class=\"selected\""; } ?> ><?php echo (defined('LANG') && LANG === 'ar' ? 'كتابة' : 'Write'); ?></a>
 | <a href="nachrichten.php?t=2" <?php if(isset($_GET['t']) && $_GET['t'] == 2) { echo "class=\"selected\""; } ?> ><?php echo (defined('LANG') && LANG === 'ar' ? 'المرسلة' : 'Sent'); ?></a>
 <?php if($session->plus) {
 echo " | <a href=\"nachrichten.php?t=3\"";
 if(isset($_GET['t']) && $_GET['t'] == 3) { echo "class=\"selected\""; }
 echo ">".(defined('LANG') && LANG === 'ar' ? 'الأرشيف' : 'Archive')."</a> | <a href=\"nachrichten.php?t=4\"";
 if(isset($_GET['t']) && $_GET['t'] == 4) { echo "class=\"selected\""; }
 echo ">".(defined('LANG') && LANG === 'ar' ? 'ملاحظات' : 'Notes')."</a>";
 }
 ?>
</div>