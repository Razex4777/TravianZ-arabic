<?php
############################################################
##                DO NOT REMOVE THIS NOTICE               ##
##              ADVOCAITE ROCKS TRAVIANX NUTS             ##
##                     FIX BY RONIX                       ##  
##                       TRAVIANZ                         ##  
############################################################
$dataarray = explode(",",$message->readingNotice['data']);
$colspan = (isset($dataarray[184]) && $dataarray[184] > 0) ? 11 : 10;
$colspan2 = 10;

if(!isset($isAdmin)){
    $mapUrl = "karte.php?d=";
    $playerUrl = "spieler.php?uid=";
}elseif($isAdmin){
    $mapUrl = "admin.php?p=village&did=";
    $playerUrl = "admin.php?p=player&uid=";
}

//Attacker
if ($database->getUserField($dataarray[0], 'username', 0) != "[?]") {
	$user_url="<a href=\"".$playerUrl.$database->getUserField($dataarray[0], 'id', 0)."\">".$database->getUserField($dataarray[0], 'username', 0)."</a>";
}
else $user_url="<font color=\"grey\"><b>[?]</b></font>";
	

if($database->getVillageField($dataarray[1],'name') != "[?]") {
	$from_url="<a href=\"".$mapUrl.$dataarray[1]."&c=".$generator->getMapCheck($dataarray[1])."\">".$database->getVillageField($dataarray[1], 'name')."</a>";
}
else $from_url="<font color=\"grey\"><b>[?]</b></font>";

//defender
$defender_name = $database->getUserField($dataarray[28], 'username', 0);
if ($defender_name == "Nature" && defined('LANG') && LANG === 'ar') {
    $defender_name = "وحوش";
}

if ($defender_name != "[?]") {
	$defuser_url="<a href=\"".$playerUrl.$database->getUserField($dataarray[28], 'id', 0)."\">".$defender_name."</a>";
}
else $defuser_url="<font color=\"grey\"><b>[?]</b></font>";
    
if($database->isVillageOases($dataarray[29])){
    $oasisName = $dataarray[30];
	    if(defined('LANG') && LANG === 'ar') {
	        $oasisName = str_replace('Unoccupied Oasis', UNOCCUOASIS, $oasisName);
	        $oasisName = str_replace('Occupied Oasis', OCCUOASIS, $oasisName);
	    }
	    $deffrom_url="<a href=\"".$mapUrl.$dataarray[29]."&c=".$generator->getMapCheck($dataarray[29])."\">".$oasisName."</a>";
	}elseif($database->getVillageField($dataarray[29], 'name') != "[?]") {
    $deffrom_url="<a href=\"".$mapUrl.$dataarray[29]."&c=".$generator->getMapCheck($dataarray[29])."\">".$database->getVillageField($dataarray[29], 'name')."</a>";
}
else $deffrom_url="<font color=\"grey\"><b>[?]</b></font>";
?>
<table cellpadding="1" cellspacing="1" id="report_surround">
			<thead>
				<tr>
					<th><?php echo (defined('LANG') && LANG === 'ar') ? 'الموضوع:' : 'Subject:'; ?></th>
					<th><?php $topic = $message->readingNotice['topic'];
						if(defined('LANG') && LANG === 'ar') {
						    $topic = str_replace(' attacks ', ' يهاجم ', $topic);
						    $topic = str_replace('Unoccupied Oasis', UNOCCUOASIS, $topic);
						    $topic = str_replace('Occupied Oasis', OCCUOASIS, $topic);
						}
						echo $topic; ?></th>
				</tr>
 
				<tr>
					<?php
                $date = $generator->procMtime($message->readingNotice['time']); ?>
					<td class="sent"><?php echo (defined('LANG') && LANG === 'ar') ? 'أرسلت:' : 'Sent:'; ?></td>
					<td><?php echo (defined('LANG') && LANG === 'ar') ? 'في <span>'.$date[0].' الساعة '.$date[1].'</span>' : 'on <span>'.$date[0].' at '.$date[1].'</span> <span>hour</span>'; ?></td>
				</tr>
			</thead>
			<tbody>
				<tr><td colspan="2" class="empty"></td></tr>
				<tr><td colspan="2" class="report_content">
		<table cellpadding="1" cellspacing="1" id="attacker"><thead>
<tr>
<td class="role"><?php echo ATTACKER; ?></td>
<td colspan="<?php echo $colspan ?>"><?php echo $user_url." ".FROM_THE_VILL." ".$from_url;?></td>
</tr>
</thead>
<tbody class="units">
<tr>
<td>&nbsp;</td>
<?php
$tribe = $dataarray[2];
$start = ($tribe - 1) * 10 + 1;
for($i = $start; $i <= ($start + 9); $i++) {
	echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"".$technology->getUnitName($i)."\" alt=\"".$technology->getUnitName($i)."\" /></td>";
}
if(isset($dataarray[184]) && $dataarray[184] > 0){
	echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"".HERO."\" alt=\"".HERO."\" /></td>";
}
echo "</tr><tr><th>".TROOPS."</th>";

for($i = 3; $i <= 12; $i++) {
    if($dataarray[$i] == 0) echo "<td class=\"none\">0</td>";
    else echo "<td>".$dataarray[$i]."</td>";
}

if(isset($dataarray[184]) && $dataarray[184] > 0){
	echo "<td>$dataarray[184]</td>";
}
echo "<tr><th>".CASUALTIES."</th>";
for($i = 13; $i <= 22; $i++) {
    if($dataarray[$i] == 0) echo "<td class=\"none\">0</td>";
    else echo "<td>".$dataarray[$i]."</td>";
}
if(isset($dataarray[184]) && $dataarray[184] > 0){
    if ($dataarray[185] == 0) $tdclass='class="none"'; else $tdclass='';
    echo "<td $tdclass>$dataarray[185]</td>";
}
if(array_sum(array_slice($dataarray, 186, 11)) > 0){
echo "</tr><tr><th>".PRISONERS."</th>";

for($i = 186; $i <= 195; $i++) {
    if($dataarray[$i] == 0) echo "<td class=\"none\">0</td>";
    else echo "<td>".$dataarray[$i]."</td>"; 
}

if(isset($dataarray[184]) && $dataarray[184] > 0){
    if ($dataarray[196] == 0) $tdclass='class="none"'; else $tdclass='';
    echo "<td $tdclass>$dataarray[196]</td>";
}
}  
if (!empty($dataarray[198]) && !empty($dataarray[199])){ //ram
?>
	<tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
	<img class="unit u<?php echo $dataarray[198]; ?>" src="img/x.gif" alt="<?php echo $technology->getUnitName($dataarray[198]); ?>" title="<?php echo $technology->getUnitName($dataarray[198]); ?>" />
	<?php echo $dataarray[199]; ?>
    </td></tr></tbody>
<?php } 
if (!empty($dataarray[200]) && !empty($dataarray[201])){ //cata
?>
	<tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
	<img class="unit u<?php echo $dataarray[200]; ?>" src="img/x.gif" alt="<?php echo $technology->getUnitName($dataarray[200]); ?>" title="<?php echo $technology->getUnitName($dataarray[200]); ?>" />
	<?php echo $dataarray[201]; ?>
    </td></tr></tbody>
<?php }
if (!empty($dataarray[202]) && !empty($dataarray[203])){ //chief
?>
	<tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
	<img class="unit u<?php echo $dataarray[202]; ?>" src="img/x.gif" alt="<?php echo $technology->getUnitName($dataarray[202]); ?>" title="<?php echo $technology->getUnitName($dataarray[202]); ?>" />
	<?php echo $dataarray[203]; ?>
    </td></tr></tbody>
<?php }
if (!empty($dataarray[205]) && !empty($dataarray[206])){ //hero
?>
	<tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
	<img class="unit u<?php echo $dataarray[205]; ?>" src="img/x.gif" alt="<?php echo HERO; ?>" title="<?php echo HERO; ?>" />
	<?php echo $dataarray[206]; ?>
    </td></tr></tbody>
<?php }
if(isset($dataarray[204]) && !empty($dataarray[204])){ //No troops returned
?>	
	<tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
	<?php echo $dataarray[204]; ?>
    </td></tr></tbody>
<?php }?>
</td></tr></tbody>
</table>
	
<?php
$target = $dataarray[34] - 1;
$start = ($target * 10) + 1;
$troopsStart = ($target * 21) + 35;
?>
<table cellpadding="1" cellspacing="1" class="defender">
<thead>
<tr>
<td class="role"><?php echo DEFENDER; ?></td>
<td colspan="<?php echo $colspan2; ?>"><?php echo $defuser_url." ".FROM_THE_VILL." ".$deffrom_url; ?></td>	
</tr></thead>
<tbody class="units">
<tr>
<td>&nbsp;</td>

<?php
for($i = $start; $i <= ($start + 9); $i++)
{
	echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"".$technology->getUnitName($i)."\" alt=\"".$technology->getUnitName($i)."\" /></td>";
}
echo "</tr><tr><th>".TROOPS."</th>";
for($i = $troopsStart; $i <= $troopsStart + 9; $i++) echo "<td class=\"none\">?</td>";

echo "<tr><th>".CASUALTIES."</th>";
for($i = $troopsStart + 10; $i <= $troopsStart + 19; $i++) echo "<td class=\"none\">?</td>";
?>
</tr></tbody></table>
</td></tr></tbody></table>