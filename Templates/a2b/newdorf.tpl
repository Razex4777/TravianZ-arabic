<?php
//-- Prevent user from founding a new village if there are not enough settlers or the player put an invalid village ID or an already occupied one
//-- fix by AL-Kateb - Semplified and additions by iopietro
if(($settlers = $village->unitarray['u'.$session->tribe.'0']) < 3  || !isset($_GET['id']) || ($newvillage = $database->getMInfo($_GET['id']))['id'] == 0 || $newvillage['occupied'] > 0 || $newvillage['oasistype'] > 0){
    header("location: dorf1.php");
    exit;
}
//--
$wood = round($village->awood);
$clay = round($village->aclay);
$iron = round($village->airon);
$crop = round($village->acrop);
      		
$troopsTime = $units->getWalkingTroopsTime($village->wid, $newvillage['id'], 0, 0, [300], 0);
$time = $database->getArtifactsValueInfluence($session->uid, $village->wid, 2, $troopsTime);

echo '<pre>';
echo '</pre>';
?>
<h1><?php echo (defined('LANG') && LANG === 'ar') ? 'تأسيس قرية جديدة' : 'Found new village'; ?></h1>
				<form method="POST" action="build.php">
				<input type="hidden" name="a" value="new" />
				<input type="hidden" name="c" value="5" />
				<input type="hidden" name="s" value="<?php echo $_GET['id']; ?>" />
				<input type="hidden" name="id" value="39" />
		<table class="troop_details" cellpadding="1" cellspacing="1">
	<thead>
		<tr>
			<td class="role"><a href="spieler.php?uid=<?php echo $session->uid; ?>"><?php echo $session->username; ?></a></td><td colspan="10"><a href="karte.php?d=<?php echo $newvillage['id']; ?>&c=<?php echo $generator->getMapCheck($newvillage[0]) ?>"><?php echo (defined('LANG') && LANG === 'ar') ? 'تأسيس قرية جديدة' : 'Found new village'; ?> (<?php echo $newvillage['x']; ?>|<?php echo $newvillage['y']; ?>)</a></td>
		</tr>
	</thead>
	<tbody class="units">
		<tr>
			<th>&nbsp;</th>
				<?php for($i = ($session->tribe-1) * 10 + 1; $i <= $session->tribe * 10; $i++) {
					echo "<td><img src=\"img/x.gif\" class=\"unit u".$i."\" title=\"".$technology->getUnitName($i)."\" alt=\"".$technology->getUnitName($i)."\" /></td>";
				} ?>
		</tr>
		<tr>
			<th><?php echo (defined('LANG') && LANG === 'ar') ? 'القوات' : 'Troops'; ?></th>
				<?php for($i = 1;$i <= 9; $i++) {
					echo "<td class=\"none\">0</td>";
				} 

				if($settlers >= 3){
				  echo "<td>3</td>";
				}else{
				  echo "<td class=\"none\">0</td>";
				}
				?>
		</tr>
	</tbody>
	<tbody class="infos">
		<tr>
			<th><?php echo (defined('LANG') && LANG === 'ar') ? 'المدة' : 'Duration'; ?></th>
				<td colspan="10"><img class="clock" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'المدة' : 'Duration'; ?>" title="<?php echo (defined('LANG') && LANG === 'ar') ? 'المدة' : 'Duration'; ?>" /> <?php echo $generator->getTimeFormat($time); ?></td>
		</tr>
	</tbody>
	<tbody class="infos">
		<tr>
			<th><?php echo (defined('LANG') && LANG === 'ar') ? 'الموارد' : 'Resources'; ?></th>
				<td colspan="10">
				<img class="r1" src="img/x.gif" alt="<?php echo LUMBER; ?>" title="<?php echo LUMBER; ?>" />750 | 
				<img class="r2" src="img/x.gif" alt="<?php echo CLAY; ?>" title="<?php echo CLAY; ?>" />750 | 
				<img class="r3" src="img/x.gif" alt="<?php echo IRON; ?>" title="<?php echo IRON; ?>" />750 | 
				<img class="r4" src="img/x.gif" alt="<?php echo CROP; ?>" title="<?php echo CROP; ?>" />750</td>
		</tr>
	</tbody>
</table>
<p class="btn">
<?php
if ($wood >= 750 && $clay >= 750 && $iron >= 750 && $crop >= 750) {
?>
<button value="ok" name="s1" id="btn_ok" class="trav_buttons" alt="OK" onclick="this.disabled=true;this.form.submit();" /> <?php echo (defined('LANG') && LANG === 'ar') ? 'تم' : 'Ok'; ?> </button>
<?php
} else {
  echo "<span class=\"c2\"><b>" . ((defined('LANG') && LANG === 'ar') ? 'الموارد غير كافية' : 'Not enough resource') . "</b></span>";
}
?>
</form>
</p>
</div>


