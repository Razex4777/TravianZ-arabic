<div id="textmenu">
   <a href="spieler.php?uid=<?php if(isset($_GET['uid'])) { echo $_GET['uid']; } else { echo $session->uid; } ?>" <?php if(isset($_GET['uid'])) { echo "class=\"selected\""; } ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'نظرة عامة' : 'Overview'; ?></a>
 | <span class=none><b><?php echo (defined('LANG') && LANG === 'ar') ? 'الملف الشخصي' : 'Profile'; ?></b></span>
 | <span class=none><b><?php echo (defined('LANG') && LANG === 'ar') ? 'التفضيلات' : 'Preferences'; ?></b></span>
 | <span class=none><b><?php echo (defined('LANG') && LANG === 'ar') ? 'الحساب' : 'Account'; ?></b></span>
 <?php
  if(NEW_FUNCTIONS_VACATION){
 ?>
 | <span class=none><b><?php echo (defined('LANG') && LANG === 'ar') ? 'إجازة' : 'Vacation'; ?></b></span>
 <?php
  }
  if(GP_ENABLE) {
 ?>
 | <span class=none><b><?php echo (defined('LANG') && LANG === 'ar') ? 'حزمة الرسومات' : 'Graphic pack'; ?></b></span>
 <?php
  }
 ?>

</div>
