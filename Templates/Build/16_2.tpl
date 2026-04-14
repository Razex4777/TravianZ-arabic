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
	
	$units_type = $database->getMovement(3, $village->wid, 0);
	$settlers = $database->getMovement(5, $village->wid, 0);
	$units_outgoing = count($units_type);
	for($i = 0; $i < $units_outgoing; $i++){
		if($units_type[$i]['vref'] != $village->wid) $units_outgoing -= 1;
	}
	$units_outgoing += count($settlers);
	
	if($units_outgoing >= 1){
		echo "<h4>".TROOPS_ON_THEIR_WAY."</h4>";
		include ("16_walking.tpl");
	} else {
		echo '<p>' . ((defined('LANG') && LANG === 'ar') ? 'لا توجد قوات ذاهبة حالياً.' : 'No outgoing troops at the moment.') . '</p>';
	}

	// Also show troops in other villages
	$enforcevill = array();
	$allenforce = $village->enforcetoyou;
	if(count($allenforce) > 0){
		foreach($allenforce as $enforce){
			$conquredvid = $database->getOasisField($enforce['vref'], "conqured");
			if($conquredvid == 0){
				array_push($enforcevill, $enforce);
			}
		}
	}
	if(count($enforcevill) > 0){
		echo "<h4>".TROOPS_IN_OTHER_VILLAGE."</h4>";
		foreach($enforcevill as $enforce){
			$colspan = 10 + $enforce['hero'];
			echo "<table class=\"troop_details\" cellpadding=\"1\" cellspacing=\"1\"><thead><tr><td class=\"role\">
<a href=\"karte.php?d=".$enforce['vref']."&c=".$generator->getMapCheck($enforce['from'])."\">".$database->getVillageField($enforce['from'], "name")."</a></td>
<td colspan=\"$colspan\">";
			echo "<a href=\"karte.php?d=".$enforce['vref']."&c=".$generator->getMapCheck($enforce['vref'])."\">".REINFORCEMENTFOR." ".$database->getVillageField($enforce['vref'], "name")." </a>";
			echo "</td></tr></thead><tbody class=\"units\">";
			$tribe = $database->getUserField($database->getVillageField($enforce['from'], "owner"), "tribe", 0);
			$start = ($tribe - 1) * 10 + 1;
			$end = ($tribe * 10);
			echo "<tr><th>&nbsp;</th>";
			for($i = $start; $i <= ($end); $i++){
				echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"".$technology->getUnitName($i)."\" alt=\"".$technology->getUnitName($i)."\" /></td>";
			}
			if($enforce['hero'] != 0){
				echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"Hero\" alt=\"Hero\" /></td>";
			}
			echo "</tr><tr><th>".TROOPS."</th>";
			for($i = $start; $i <= ($start + 9); $i++){
				if($enforce['u'.$i] == 0){
					echo "<td class=\"none\">";
				}else{
					echo "<td>";
				}
				echo $enforce['u'.$i]."</td>";
			}
			if($enforce['hero'] != 0){
				echo "<td>".$enforce['hero']."</td>";
			}
			echo "</tr></tbody>
<tbody class=\"infos\"><tr><th>".UPKEEP."</th><td colspan=\"$colspan\"><div class='sup'>".$technology->getUpkeep($enforce, $tribe)."<img class=\"r4\" src=\"img/x.gif\" title=\"Crop\" alt=\"Crop\" />".PER_HR."</div><div class='sback'><a href='a2b.php?r=".$enforce['id']."'>".SEND_BACK."</a></div></td></tr>";
			echo "</tbody></table>";
		}
	}
}
else echo '<b>'.RALLYPOINT_COMMENCE.'</b><br>';
?>
</div>
