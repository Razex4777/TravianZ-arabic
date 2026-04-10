<h1><img class="unit uunits" src="img/x.gif" alt="" title="" /> <?php echo (defined('LANG') && LANG === 'ar') ? 'القوات (الغال)' : 'Troops (Gauls)'; ?></h1>
<ul>
    <li><a href="manual.php?typ=1&amp;s=21"><?php echo (defined('LANG') && LANG === 'ar') ? 'الكتيبة' : 'Phalanx'; ?></a></li>
    <li><a href="manual.php?typ=1&amp;s=22"><?php echo (defined('LANG') && LANG === 'ar') ? 'مبارز' : 'Swordsman'; ?></a></li>
    <li><a href="manual.php?typ=1&amp;s=23"><?php echo (defined('LANG') && LANG === 'ar') ? 'مستكشف' : 'Pathfinder'; ?></a></li>
    <li><a href="manual.php?typ=1&amp;s=24"><?php echo (defined('LANG') && LANG === 'ar') ? 'رعد تيوتاتيس' : 'Theutates Thunder'; ?></a></li>
    <li><a href="manual.php?typ=1&amp;s=25"><?php echo (defined('LANG') && LANG === 'ar') ? 'فرسان الكاهن' : 'Druidrider'; ?></a></li>
    <li><a href="manual.php?typ=1&amp;s=26"><?php echo (defined('LANG') && LANG === 'ar') ? 'فرسان الهيدوان' : 'Haeduan'; ?></a></li>
    <li><a href="manual.php?typ=1&amp;s=27"><?php echo (defined('LANG') && LANG === 'ar') ? 'محطمة الأبواب' : 'Ram'; ?></a></li>
    <li><a href="manual.php?typ=1&amp;s=28"><?php echo (defined('LANG') && LANG === 'ar') ? 'المنجنيق' : 'Trebuchet'; ?></a></li>
    <li><a href="manual.php?typ=1&amp;s=29"><?php echo (defined('LANG') && LANG === 'ar') ? 'رئيس' : 'Chieftain'; ?></a></li>
    <li><a href="manual.php?typ=1&amp;s=30"><?php echo (defined('LANG') && LANG === 'ar') ? 'مستوطن' : 'Settler'; ?></a></li>
</ul>
<map id="nav" name="nav">
    <area href="manual.php?typ=2&amp;s=2" title="back" coords="0,0,45,18" shape="rect" alt="" />
    <area href="manual.php?s=1" title="Overview" coords="46,0,70,18" shape="rect" alt="" />
    <area href="<?php echo NEW_FUNCTIONS_MANUAL_NATURENATARS ? "manual.php?typ=2&amp;s=4" : "manual.php?typ=3&amp;s=1"; ?>" title="forward" coords="71,0,116,18" shape="rect" alt="" />
</map>
<img usemap="#nav" src="img/x.gif" class="navi" alt="" />