<h1><img class="point" src="img/x.gif" alt="" title="" /> <?php echo (defined("LANG") && LANG === "ar") ? "أفضل 10 إحصائيات" : "Top 10 statistics"; ?></h1>

		<p><?php echo (defined("LANG") && LANG === "ar") ? "يتم إعادة إنشاء أفضل 10 إحصائيات كل أسبوع وهي صالحة من الإثنين 00:00 إلى الأحد 24:00 (جرينتش +1)." : "The Top 10 statistics are recreated each week and are valid from Monday 00:00 until Sunday 24:00 GMT+1."; ?></p>
		<table id="examples" cellpadding="1" cellspacing="1">
			<thead><tr>
				<th colspan="2"><?php echo (defined("LANG") && LANG === "ar") ? "الفئات" : "categories"; ?></th>
			</tr></thead>
			<tbody><tr>
				<th><?php echo (defined("LANG") && LANG === "ar") ? "المتقدم" : "climber"; ?></th>
				<td><?php echo (defined("LANG") && LANG === "ar") ? "المراتب في إحصائيات اللاعبين" : "ranks in player statistics"; ?></td>
			</tr>
			<tr>
				<th><?php echo (defined("LANG") && LANG === "ar") ? "المهاجم" : "attacker"; ?></th>
				<td><?php echo (defined("LANG") && LANG === "ar") ? "النقاط الهجومية" : "off points"; ?></td>
			</tr>
			<tr>
				<th><?php echo (defined("LANG") && LANG === "ar") ? "المدافع" : "defender"; ?></th>
				<td><?php echo (defined("LANG") && LANG === "ar") ? "النقاط الدفاعية" : "def points"; ?></td>
			</tr>
			<tr>
				<th><?php echo (defined("LANG") && LANG === "ar") ? "السارق" : "robber"; ?></th>
				<td><?php echo (defined("LANG") && LANG === "ar") ? "الموارد المسروقة" : "stolen resources"; ?></td>
			</tr></tbody>
		</table>
		<p><?php echo (defined("LANG") && LANG === "ar") ? "في نهاية كل أسبوع يحصل أفضل عشرة لاعبين على وسام. عند تعديل ملفك الشخصي يتم عرض كود (مثل [#123]) في \"الأوسمة\" يمكن إدراجه حيث ترغب. أمثلة:" : "At the end of each week the top ten players are awarded a decoration. When you edit your profile a code (e.g. [#123]) is displayed at \"medals\" which can be inserted where desired. Examples:"; ?></p>
		<p class="medals"><img src="img/x.gif" class="medal t1_1" alt="" title="" /><img src="img/x.gif" class="medal t1_2" alt="" title="" /><img src="img/x.gif" class="medal t1_3" alt="" title="" /><img src="img/x.gif" class="medal t1_4" alt="" title="" /></p>
<map id="nav" name="nav">
	<area href="manual.php?s=1" title="<?php echo (defined("LANG") && LANG === "ar") ? 'السابق' : 'Back'; ?>" coords="0,0,45,18" shape="rect" alt="" />
	<area href="manual.php?s=1" title="<?php echo (defined("LANG") && LANG === "ar") ? 'نظرة عامة' : 'Overview'; ?>" coords="46,0,70,18" shape="rect" alt="" />
	<area href="manual.php?s=1" title="<?php echo (defined("LANG") && LANG === "ar") ? 'التالي' : 'Forward'; ?>" coords="71,0,116,18" shape="rect" alt="" />
</map>
<img usemap="#nav" src="img/x.gif" class="navi" alt="" />