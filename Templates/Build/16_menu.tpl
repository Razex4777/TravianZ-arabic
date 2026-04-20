<div id="textmenu">
	<a href="build.php?id=<?php echo $id; ?>" <?php if(!isset($_GET['t'])) echo "class=\"selected\""; ?> ><?php echo (defined('LANG') && LANG === 'ar') ? 'نظرة عامة' : OVERVIEW; ?></a> |
    <a href="a2b.php" <?php if(basename($_SERVER['PHP_SELF']) == 'a2b.php') echo "class=\"selected\""; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'إرسال القوات' : SEND_TROOPS; ?></a> |
    <a href="build.php?id=<?php echo $id; ?>&t=1" <?php if(isset($_GET['t']) && $_GET['t'] == 1) echo "class=\"selected\""; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'القوات القادمة' : 'Incoming troops'; ?></a> |
    <a href="build.php?id=<?php echo $id; ?>&t=2" <?php if(isset($_GET['t']) && $_GET['t'] == 2) echo "class=\"selected\""; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'القوات الذاهبة' : 'Outgoing troops'; ?></a> |
    <a href="warsim.php"><?php echo (defined('LANG') && LANG === 'ar') ? 'محاكي المعارك' : Q20_RESP1; ?></a> |
    <a href="build.php?id=<?php echo $id; ?>&t=99" <?php if(isset($_GET['t']) && $_GET['t'] == 99) echo "class=\"selected\""; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'قائمة المزارع' : 'Farm list'; ?></a>
</div>
