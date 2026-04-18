<h1><img class="unit u22" src="img/x.gif" alt="Swordsman" title="Swordsman" /> Swordsman <span class="tribe">(<?php echo (defined("LANG") && LANG === "ar") ? "الغال" : "Gauls"; ?>)</span></h1>

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
	<td>65</td>
	<td>35</td>
	<td>20</td>

	<td>140</td>
	<td>150</td>
	<td>185</td>
	<td>60</td>
</tr></tbody>
</table>

<table id="troop_details" cellpadding="1" cellspacing="1">
<tbody><tr>
	<th><?php echo (defined("LANG") && LANG === "ar") ? "السرعة" : "Velocity"; ?></th>
	<td><b>6</b> <?php echo (defined("LANG") && LANG === "ar") ? "حقول/ساعة" : "fields/hour"; ?></td>
</tr>
<tr>
	<th><?php echo (defined("LANG") && LANG === "ar") ? "الحمولة" : "Can carry"; ?></th>
	<td><b>45</b> <?php echo (defined("LANG") && LANG === "ar") ? "موارد" : "resources"; ?></td>
</tr>
<tr>
	<th><?php echo (defined("LANG") && LANG === "ar") ? "الاستهلاك" : "Upkeep"; ?></th>
	<td><?php echo (defined("LANG") && LANG === "ar") ? '<img class="r5" src="img/x.gif" alt="استهلاك القمح" title="استهلاك القمح" />' : '<img class="r5" src="img/x.gif" alt="Crop consumption" title="Crop consumption" />'; ?> 1</td>
</tr>
<tr>
	<th><?php echo (defined("LANG") && LANG === "ar") ? "مدة التدريب" : "Duration of training"; ?></th>
	<td><img class="clock" src="img/x.gif" alt="duration" title="duration" /> 0:24:00</td>
</tr></tbody>
</table>

<img id="big_unit" class="big_u22" src="img/x.gif" alt="Swordsman" title="Swordsman" /><div id="t_desc">The Swordsmen are more expensive than the Phalanx, but they are an attacking unit.
<br /><br />
Defensively they are quite weak, especially against cavalry.</div>
<div id="prereqs"><b><?php echo (defined("LANG") && LANG === "ar") ? "المتطلبات" : "Prerequisites"; ?></b><br /><a href="manual.php?typ=4&amp;gid=22">Academy</a> <?php echo (defined("LANG") && LANG === "ar") ? "المستوى" : "Level"; ?> 3, <a href="manual.php?typ=4&amp;gid=12">Blacksmith</a> <?php echo (defined("LANG") && LANG === "ar") ? "المستوى" : "Level"; ?> 1</div>
<map id="nav" name="nav">
    <area href="manual.php?typ=1&amp;s=21" title="<?php echo (defined("LANG") && LANG === "ar") ? 'رجوع' : 'back'; ?>" coords="0,0,45,18" shape="rect" alt="" />
    <area href="manual.php?s=1" title="<?php echo (defined("LANG") && LANG === "ar") ? 'نظرة عامة' : 'Overview'; ?>" coords="46,0,70,18" shape="rect" alt="" />
    <area href="manual.php?typ=1&amp;s=23" title="<?php echo (defined("LANG") && LANG === "ar") ? 'التالي' : 'forward'; ?>" coords="71,0,116,18" shape="rect" alt="" />
</map>
<img usemap="#nav" src="img/x.gif" class="navi" alt="" />