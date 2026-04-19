	<div id="content"  class="plus">
<h1><?php echo (defined('LANG') && LANG === 'ar') ? '<font color="#71D000">بلاس</font>' : 'Travian <font color="#71D000">P</font><font color="#FF6F0F">l</font><font color="#71D000">u</font><font color="#FF6F0F">s</font>'; ?></h1>
<div id="textmenu">
   <a href="plus.php?id=3" <?php

        if(isset($_GET['id']) && $_GET['id'] == 3) {
        	echo "class=\"selected\"";
        }
		if(isset($_GET['id']) && (($_GET['id'] >= 7 && $_GET['id'] <= 17) || $_GET['id'] == 1)) {
        	echo "class=\"selected\"";
        }
		if(!isset($_GET['id']) && basename($_SERVER['PHP_SELF']) === 'plus.php') {
        	echo "class=\"selected\"";
        }

?>><?php echo (defined('LANG') && LANG === 'ar') ? 'الذهب' : 'Gold'; ?></a>

 | <a href="plus1.php" <?php

        if(basename($_SERVER['PHP_SELF']) === 'plus1.php') {
        	echo "class=\"selected\"";
        }

?>><?php echo (defined('LANG') && LANG === 'ar') ? 'شراء الذهب' : 'Buy Gold'; ?></a>

 | <a href="plus.php?id=2" <?php

        if(isset($_GET['id']) && $_GET['id'] == 2) {
        	echo "class=\"selected\"";
        }

?>><?php echo (defined('LANG') && LANG === 'ar') ? 'المميزات' : 'Advantages'; ?></a>

 | <a href="plus.php?id=4" <?php

        if(isset($_GET['id']) && $_GET['id'] == 4) {
        	echo "class=\"selected\"";
        }

?>><?php echo (defined('LANG') && LANG === 'ar') ? 'الأسئلة الشائعة' : 'FAQ'; ?></a>

 | <a href="a2b2.php" <?php

        if(@(basename($_SERVER['REQUEST_URI']) === 'a2b2.php')) {
            echo "class=\"selected\"";
        }
?>><?php echo (defined('LANG') && LANG === 'ar') ? 'كشف الحساب' : 'Account Statement'; ?></a>

</div>