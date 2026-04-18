<h1><img class="point" src="img/x.gif" alt="" title="" /> <?php echo (defined('LANG') && LANG === 'ar') ? 'نظرة عامة' : 'Overview'; ?></h1>
<p><?php echo (defined('LANG') && LANG === 'ar') ? 'تتيح لك مساعدة اللعبة هذه فرصة البحث عن معلومات مهمة في أي وقت.' : 'This ingame help offers you the chance to look up important information at any time.'; ?></p>
<img class="troops" src="img/x.gif" alt="Troops" title="Troops" />
<img class="buildings" src="img/x.gif" alt="Buildings" title="Buildings" />
<ul>
<li><a href="manual.php?s=1&amp;typ=2"><?php echo (defined('LANG') && LANG === 'ar') ? 'القوات' : 'The troops'; ?></a></li>

<ul>
	<li><a href="manual.php?typ=2&amp;s=1"><?php echo (defined('LANG') && LANG === 'ar') ? 'الرومان' : '<?php echo (defined("LANG") && LANG === "ar") ? "الرومان" : "Romans"; ?>'; ?></a></li>
	<li><a href="manual.php?typ=2&amp;s=2"><?php echo (defined('LANG') && LANG === 'ar') ? 'الجرمان' : '<?php echo (defined("LANG") && LANG === "ar") ? "التيوتون" : "Teutons"; ?>'; ?></a></li>
	<li><a href="manual.php?typ=2&amp;s=3"><?php echo (defined('LANG') && LANG === 'ar') ? 'الغال' : '<?php echo (defined("LANG") && LANG === "ar") ? "الغال" : "Gauls"; ?>'; ?></a></li>
	<?php if(NEW_FUNCTIONS_MANUAL_NATURENATARS){ ?>
	<li><a href="manual.php?typ=2&amp;s=4"><?php echo (defined('LANG') && LANG === 'ar') ? 'الطبيعة' : '<?php echo (defined("LANG") && LANG === "ar") ? "الطبيعة" : "Nature"; ?>'; ?></a></li>
	<li><a href="manual.php?typ=2&amp;s=5"><?php echo (defined('LANG') && LANG === 'ar') ? 'الناتار' : '<?php echo (defined("LANG") && LANG === "ar") ? "الناتار" : "Natars"; ?>'; ?></a></li>
	<?php } ?>
</ul>

<br>

<li><a href="manual.php?typ=3&amp;s=1"><?php echo (defined('LANG') && LANG === 'ar') ? 'المباني' : 'The buildings'; ?></a></li>

<ul>
    <li><a href="manual.php?typ=3&amp;s=1"><?php echo (defined('LANG') && LANG === 'ar') ? 'الموارد' : 'Resources'; ?></a></li>
    <li><a href="manual.php?typ=3&amp;s=2"><?php echo (defined('LANG') && LANG === 'ar') ? 'العسكرية' : 'Military'; ?></a></li>
    <li><a href="manual.php?typ=3&amp;s=3"><?php echo (defined('LANG') && LANG === 'ar') ? 'البنية التحتية' : 'Infrastructure'; ?></a></li>
</ul>

<br>
<?php if(NEW_FUNCTIONS_OASIS || NEW_FUNCTIONS_ALLIANCE_INVITATION || NEW_FUNCTIONS_EMBASSY_MECHANICS || NEW_FUNCTIONS_FORUM_POST_MESSAGE || NEW_FUNCTIONS_TRIBE_IMAGES || NEW_FUNCTIONS_MHS_IMAGES || NEW_FUNCTIONS_DISPLAY_ARTIFACT || NEW_FUNCTIONS_DISPLAY_WONDER || NEW_FUNCTIONS_VACATION || NEW_FUNCTIONS_DISPLAY_CATAPULT_TARGET || NEW_FUNCTIONS_MANUAL_NATURENATARS || NEW_FUNCTIONS_DISPLAY_LINKS || NEW_FUNCTIONS_MEDAL_3YEAR || NEW_FUNCTIONS_MEDAL_5YEAR || NEW_FUNCTIONS_MEDAL_10YEAR) { ?>
<li><a href="manual.php?typ=13&amp;s=31"><?php echo (defined('LANG') && LANG === 'ar') ? 'ميزات جديدة' : 'New features'; ?></a><br><?php echo (defined('LANG') && LANG === 'ar') ? 'هذه ميزات جديدة لن تجدها في النسخة الأصلية من لعبة ترافيان T3.6. هنا يمكنك التعرف على جميع الميزات الجديدة بالتفصيل.' : 'These are new features that you will not find in the real version of the game Travian T3.6. Here you can get acquainted with all new features in more detail.'; ?></li><br>
<?php } ?>

<li><a href="anleitung.php?s=3" target="_blank"><?php echo (defined('LANG') && LANG === 'ar') ? 'الأسئلة الشائعة' : 'Travian FAQ'; ?> <img class="external" src="img/x.gif" alt="new window" title="new window" /></a><br><?php echo (defined('LANG') && LANG === 'ar') ? 'تقدم لك مساعدة اللعبة هذه معلومات موجزة فقط. مزيد من المعلومات متاحة في' : 'This ingame help just gives you brief information. More information is available at the'; ?> <a href="http://travian.wikia.com/wiki/Travian_Wiki" target=blank><?php echo (defined('LANG') && LANG === 'ar') ? 'ويكي ترافيان' : 'Fandom Travian Wiki'; ?></a>.</li>
</ul>
<map id="nav" name="nav">
    <area href="manual.php?typ=3&amp;s=3" title="<?php echo (defined("LANG") && LANG === "ar") ? 'رجوع' : 'back'; ?>" coords="0,0,45,18" shape="rect" alt="" />
    <area href="manual.php?s=1" title="<?php echo (defined("LANG") && LANG === "ar") ? 'نظرة عامة' : 'Overview'; ?>" coords="46,0,70,18" shape="rect" alt="" />
    <area href="manual.php?typ=2&amp;s=1" title="<?php echo (defined("LANG") && LANG === "ar") ? 'التالي' : 'forward'; ?>" coords="71,0,116,18" shape="rect" alt="" />
</map>
<img usemap="#nav" src="img/x.gif" class="navi" alt="" />