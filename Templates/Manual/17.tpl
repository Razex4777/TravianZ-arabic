<h1><img class="unit u7" src="img/x.gif" alt="Battering Ram" title="Battering Ram" /> Battering Ram <span class="tribe">(<?php echo (defined("LANG") && LANG === "ar") ? "الرومان" : "Romans"; ?>)</span></h1>

<table id="troop_info" cellpadding="1" cellspacing="1">
<thead><tr>
	<th><?php echo (defined("LANG") && LANG === "ar") ? '<img class="att_all" src="img/x.gif" alt="القوة الهجومية" title="القوة الهجومية" />' : '<img class="att_all" src="img/x.gif" alt="attack value" title="attack value" />'; ?></th>
	<th><?php echo (defined("LANG") && LANG === "ar") ? '<img class="def_i" src="img/x.gif" alt="الدفاع ضد المشاة" title="الدفاع ضد المشاة" />' : '<img class="def_i" src="img/x.gif" alt="defence against infantry" title="defence against infantry" />'; ?></th>
	<th><?php echo (defined("LANG") && LANG === "ar") ? '<img class="def_c" src="img/x.gif" alt="الدفاع ضد الفرسان" title="الدفاع ضد الفرسان" />' : '<img class="def_c" src="img/x.gif" alt="defence against cavalry" title="defence against cavalry" />'; ?></th>
	<th><?php echo (defined("LANG") && LANG === "ar") ? '<img class="r1" src="img/x.gif" alt="الخشب" title="الخشب" />' : '<img class="r1" src="img/x.gif" alt="Lumber" title="Lumber" />'; ?></th>
	<th><?php echo (defined("LANG") && LANG === "ar") ? '<img class="r2" src="img/x.gif" alt="الطين" title="الطين" />' : '<img class="r2" src="img/x.gif" alt="Clay" title="Clay" />'; ?></th>
	<th><?php echo (defined("LANG") && LANG === "ar") ? '<img class="r3" src="img/x.gif" alt="الحديد" title="الحديد" />' : '<img class="r3" src="img/x.gif" alt="Iron" title="Iron" />'; ?></th>
	<th><?php echo (defined("LANG") && LANG === "ar") ? '<img class="r4" src="img/x.gif" alt="القمح" title="القمح" />' : '<img class="r4" src="img/x.gif" alt="Crop" title="Crop" />'; ?></th>
</tr></thead>
<tbody><tr>
	<td>60</td>
	<td>30</td>
	<td>75</td>

	<td>900</td>
	<td>360</td>
	<td>500</td>
	<td>70</td>
</tr></tbody>
</table>

<table id="troop_details" cellpadding="1" cellspacing="1">
<tbody><tr>
	<th><?php echo (defined("LANG") && LANG === "ar") ? "السرعة" : "Velocity"; ?></th>
	<td><b>4</b> <?php echo (defined("LANG") && LANG === "ar") ? "حقول/ساعة" : "fields/hour"; ?></td>
</tr>
<tr>
	<th><?php echo (defined("LANG") && LANG === "ar") ? "الحمولة" : "Can carry"; ?></th>
	<td><b>0</b> <?php echo (defined("LANG") && LANG === "ar") ? "موارد" : "resources"; ?></td>
</tr>
<tr>
	<th><?php echo (defined("LANG") && LANG === "ar") ? "الاستهلاك" : "Upkeep"; ?></th>
	<td><?php echo (defined("LANG") && LANG === "ar") ? '<img class="r5" src="img/x.gif" alt="استهلاك القمح" title="استهلاك القمح" />' : '<img class="r5" src="img/x.gif" alt="Crop consumption" title="Crop consumption" />'; ?> 3</td>
</tr>
<tr>
	<th><?php echo (defined("LANG") && LANG === "ar") ? "مدة التدريب" : "Duration of training"; ?></th>
	<td><img class="clock" src="img/x.gif" alt="duration" title="duration" /> 1:16:40</td>
</tr></tbody>
</table>

<img id="big_unit" class="big_u7" src="img/x.gif" alt="Battering Ram" title="Battering Ram" /><div id="t_desc">The Battering Ram is a heavy support weapon for your infantry and cavalry. Its task is to destroy the enemy walls and therefore increase your troops’ chances of overcoming the enemy's fortifications.</div>
<div id="prereqs"><b><?php echo (defined("LANG") && LANG === "ar") ? "المتطلبات" : "Prerequisites"; ?></b><br /><a href="manual.php?typ=4&amp;gid=22">Academy</a> <?php echo (defined("LANG") && LANG === "ar") ? "المستوى" : "Level"; ?> 10, <a href="manual.php?typ=4&amp;gid=21">Workshop</a> <?php echo (defined("LANG") && LANG === "ar") ? "المستوى" : "Level"; ?> 1</div>
<map id="nav" name="nav">
    <area href="manual.php?typ=1&amp;s=6" title="<?php echo (defined("LANG") && LANG === "ar") ? 'رجوع' : 'back'; ?>" coords="0,0,45,18" shape="rect" alt="" />
    <area href="manual.php?s=1" title="<?php echo (defined("LANG") && LANG === "ar") ? 'نظرة عامة' : 'Overview'; ?>" coords="46,0,70,18" shape="rect" alt="" />
    <area href="manual.php?typ=1&amp;s=8" title="<?php echo (defined("LANG") && LANG === "ar") ? 'التالي' : 'forward'; ?>" coords="71,0,116,18" shape="rect" alt="" />
</map>
<img usemap="#nav" src="img/x.gif" class="navi" alt="" />