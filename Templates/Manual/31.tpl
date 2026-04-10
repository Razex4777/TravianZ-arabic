<h1><img class="unit ugeb" src="img/x.gif" alt="" title="" /> <?php echo (defined('LANG') && LANG === 'ar') ? 'المباني (الموارد)' : 'Buildings (Resources)'; ?></h1>
<ul>
    <li><a href="manual.php?typ=4&amp;gid=1"><?php echo (defined('LANG') && LANG === 'ar') ? 'حطاب' : 'Woodcutter'; ?></a></li>
    <li><a href="manual.php?typ=4&amp;gid=2"><?php echo (defined('LANG') && LANG === 'ar') ? 'حفرة الطين' : 'Clay Pit'; ?></a></li>
    <li><a href="manual.php?typ=4&amp;gid=3"><?php echo (defined('LANG') && LANG === 'ar') ? 'منجم الحديد' : 'Iron Mine'; ?></a></li>
    <li><a href="manual.php?typ=4&amp;gid=4"><?php echo (defined('LANG') && LANG === 'ar') ? 'حقل القمح' : 'Cropland'; ?></a></li>
    <li><a href="manual.php?typ=4&amp;gid=5"><?php echo (defined('LANG') && LANG === 'ar') ? 'معمل النجار' : 'Sawmill'; ?></a></li>
    <li><a href="manual.php?typ=4&amp;gid=6"><?php echo (defined('LANG') && LANG === 'ar') ? 'مصنع الطوب' : 'Brickyard'; ?></a></li>
    <li><a href="manual.php?typ=4&amp;gid=7"><?php echo (defined('LANG') && LANG === 'ar') ? 'مسبك الحديد' : 'Iron Foundry'; ?></a></li>
    <li><a href="manual.php?typ=4&amp;gid=8"><?php echo (defined('LANG') && LANG === 'ar') ? 'المطحنة' : 'Grain Mill'; ?></a></li>
    <li><a href="manual.php?typ=4&amp;gid=9"><?php echo (defined('LANG') && LANG === 'ar') ? 'المخبز' : 'Bakery'; ?></a></li>
    <li><a href="manual.php?typ=4&amp;gid=10"><?php echo (defined('LANG') && LANG === 'ar') ? 'المخزن' : 'Warehouse'; ?></a></li>
    <li><a href="manual.php?typ=4&amp;gid=11"><?php echo (defined('LANG') && LANG === 'ar') ? 'صومعة الغلال' : 'Granary'; ?></a></li>
</ul>
<map id="nav" name="nav">
    <area href="<?php echo NEW_FUNCTIONS_MANUAL_NATURENATARS ? "manual.php?typ=2&amp;s=5" : "manual.php?typ=2&amp;s=3"; ?>" title="back" coords="0,0,45,18" shape="rect" alt="" />
    <area href="manual.php?s=1" title="Overview" coords="46,0,70,18" shape="rect" alt="" />
    <area href="manual.php?typ=3&amp;s=2" title="forward" coords="71,0,116,18" shape="rect" alt="" />
</map>
<img usemap="#nav" src="img/x.gif" class="navi" alt="" />