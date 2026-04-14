<?php
if(isset($_GET['refresh'])){
	$village->unitarray = $database->getUnit($village->wid, false);
}
?><div id="build" class="gid16">
	<a href="#" onClick="return Popup(16,4);" class="build_logo"> <img
		class="g16" src="img/x.gif" alt="Rally point"
		title="<?php echo RALLYPOINT;?>" />
	</a>
	<h1><?php echo RALLYPOINT;?> <span class="level"><?php echo LEVEL;?> <?php echo $village->resarray['f'.$id]; ?></span>
	</h1>
	<p class="build_desc"><?php echo RALLYPOINT_DESC;?></p>

<?php
if($village->resarray['f39'] > 0){
	include_once ("16_menu.tpl");
	$units_type = $database->getMovement(34, $village->wid, 1);
	$settlers = $database->getMovement(7, $village->wid, 1);
	$oasis_incoming = 0;
	$array = $database->getOasis($village->wid);
	foreach($array as $conqured) $oasis_incoming += count($database->getMovement(6, $conqured['wref'], 0));
	
	$units_incoming = count($units_type);
	$settlers_incoming = count($settlers);
	for($i = 0; $i < $units_incoming; $i++){
		if($units_type[$i]['attack_type'] == 1 && $units_type[$i]['sort_type'] == 3) $units_incoming -= 1;
	}
	if($units_incoming > 0 || $settlers_incoming > 0 || $oasis_incoming > 0){
		?>
	<h4><?php echo INCOMING_TROOPS;?> (<?php echo $units_incoming+$settlers_incoming+$oasis_incoming; ?>)</h4>
	<?php
		
		include ("16_incomming.tpl");
	} else {
		echo '<p>' . ((defined('LANG') && LANG === 'ar') ? 'لا توجد قوات قادمة حالياً.' : 'No incoming troops at the moment.') . '</p>';
	}
}
else echo '<b>'.RALLYPOINT_COMMENCE.'</b><br>';
?>
</div>
