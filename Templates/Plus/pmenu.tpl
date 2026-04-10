	<div id="content"  class="plus">
<h1>Travian <font color="#71D000">P</font><font color="#FF6F0F">l</font><font  color="#71D000">u</font><font color="#FF6F0F">s</font></h1>
<div id="textmenu">
   <a href="plus.php" <?php

        if(!isset($_GET['id']) && @(basename($_SERVER['REQUEST_URI']) !== 'a2b2.php')) {
        	echo "class=\"selected\"";
        }
        if(isset($_GET['id']) && (($_GET['id'] == 1) || strlen((string)$_GET['id']) === 3)) {
        	echo "class=\"selected\"";
        }

?>><?php echo (defined('LANG') && LANG === 'ar') ? 'التعرفة' : 'Tariffs'; ?></a>

 | <a href="plus.php?id=2" <?php

        if(isset($_GET['id']) && $_GET['id'] == 2) {
        	echo "class=\"selected\"";
        }
        if(isset($_GET['id']) && $_GET['id'] >= 6 && strlen($_GET['id']) < 3) {
        	echo "class=\"selected\"";
        }

?>><?php echo (defined('LANG') && LANG === 'ar') ? 'المميزات' : 'Advantages'; ?></a>

 | <a href="plus.php?id=3" <?php

        if(isset($_GET['id']) && $_GET['id'] == 3) {
        	echo "class=\"selected\"";
        }
        if(isset($_GET['id']) && $_GET['id'] >= 6 && strlen($_GET['id']) < 3) {
        	echo "class=\"selected\"";
        }

?>><?php echo (defined('LANG') && LANG === 'ar') ? 'الذهب' : 'Gold'; ?></a>

 | <a href="plus.php?id=4" <?php

        if(isset($_GET['id']) && $_GET['id'] == 4) {
        	echo "class=\"selected\"";
        }

?>><?php echo (defined('LANG') && LANG === 'ar') ? 'الأسئلة الشائعة' : 'FAQ'; ?></a>

 | <a href="plus.php?id=5" <?php

        if(isset($_GET['id']) && $_GET['id'] == 5) {
        	echo "class=\"selected\"";
        }
        if(isset($_GET['id']) && $_GET['id'] >= 6 && strlen($_GET['id']) < 3) {
        	echo "class=\"selected\"";
        }

?>><?php echo (defined('LANG') && LANG === 'ar') ? 'اكسب الذهب' : 'Earn gold'; ?></a>
| <a href="a2b2.php" <?php

        if(@(basename($_SERVER['REQUEST_URI']) === 'a2b2.php')) {
            echo "class=\"selected\"";
        }
?>><?php echo (defined('LANG') && LANG === 'ar') ? 'كشف الحساب' : 'Account Statement'; ?></a>

</div>