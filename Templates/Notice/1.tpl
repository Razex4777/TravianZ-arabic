<?php
$dataarray = explode(",",$message->readingNotice['data']);
$colspan = (isset($dataarray[178]) && $dataarray[178] > 0) ? 11 : 10;
$spy = !empty($dataarray[177]) && !empty($dataarray[176]) && empty($dataarray[195]);

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
    

if($database->getVillageField($dataarray[1], 'name') != "[?]") {
    $from_url="<a href=\"".$mapUrl.$dataarray[1]."&c=".$generator->getMapCheck($dataarray[1])."\">".$database->getVillageField($dataarray[1], 'name')."</a>";
}else $from_url="<font color=\"grey\"><b>[?]</b></font>";

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
	}elseif($database->getVillageField($dataarray[29],'name') != "[?]") {
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
<td colspan="<?php echo $colspan ?>"><?php echo ($user_url ? $user_url : ((defined('LANG') && LANG === 'ar') ? 'قوات التتار' : 'Natar Counterforce')); ?> <?php echo ($from_url ? FROM_THE_VILL.' '.$from_url : '');?></td>
</tr>
</thead>
<tbody class="units">
<tr>
<td>&nbsp;</td>
<?php
$tribe = $dataarray[2] ? $dataarray[2] : 5;
$start = ($tribe - 1) * 10 + 1;
for($i = $start; $i <= ($start + 9); $i++) {
    echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"".$technology->getUnitName($i)."\" alt=\"".$technology->getUnitName($i)."\" /></td>";
}
if (isset($dataarray[178]) && $dataarray[178] > 0){
    echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"".HERO."\" alt=\"".HERO."\" /></td>";
}
echo "</tr><tr><th>".TROOPS."</th>";

for($i = 3; $i <= 12; $i++) {
    if($dataarray[$i] == 0) echo "<td class=\"none\">0</td>"; 
    else echo "<td>".$dataarray[$i]."</td>";  
}

if (isset($dataarray[178]) && $dataarray[178] > 0){
    echo "<td>$dataarray[178]</td>";
}
echo "<tr><th>".CASUALTIES."</th>";

for($i = 13; $i <= 22; $i++) {
    if($dataarray[$i] == 0) echo "<td class=\"none\">0</td>";
    else echo "<td>".$dataarray[$i]."</td>";
}

if(isset($dataarray[178]) && $dataarray[178] > 0){
    if ($dataarray[179] == 0) $tdclass='class="none"'; else $tdclass='';
    echo "<td $tdclass>$dataarray[179]</td>";
}
if(!$spy && array_sum(array_slice($dataarray, 182, 11)) > 0){
echo "</tr><tr><th>".PRISONERS."</th>";
for($i = 182; $i <= 191; $i++) {
    if($dataarray[$i] == 0) echo "<td class=\"none\">0</td>";
    else echo "<td>".$dataarray[$i]."</td>";
}
if(isset($dataarray[178]) && $dataarray[178] > 0){
    if ($dataarray[192] == 0) $tdclass='class="none"'; else $tdclass='';
    echo "<td $tdclass>$dataarray[192]</td>";
}
}  
echo "</tr></tbody>";
if (!empty($dataarray[170]) && !empty($dataarray[171])){ //ram
?>
    <tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
    <img class="unit u<?php echo $dataarray[170]; ?>" src="img/x.gif" alt="<?php echo $technology->getUnitName($dataarray[170]); ?>" title="<?php echo $technology->getUnitName($dataarray[170]); ?>" />
    <?php echo $dataarray[171]; ?>
    </td></tr></tbody>
<?php } 
if (!empty($dataarray[172]) && !empty($dataarray[173])){ //cata
?>
    <tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
    <img class="unit u<?php echo $dataarray[172]; ?>" src="img/x.gif" alt="<?php echo $technology->getUnitName($dataarray[172]); ?>" title="<?php echo $technology->getUnitName($dataarray[172]); ?>" />
    <?php echo $dataarray[173]; ?>
    </td></tr></tbody>
<?php }
if (!empty($dataarray[174]) && !empty($dataarray[175])){ //chief
?>
    <tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
    <img class="unit u<?php echo $dataarray[174]; ?>" src="img/x.gif" alt="<?php echo $technology->getUnitName($dataarray[174]); ?>" title="<?php echo $technology->getUnitName($dataarray[174]); ?>" />
    <?php echo $dataarray[175]; ?>
    </td></tr></tbody>
<?php }
if ($spy){ //spy
?>
    <tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
    
    <?php echo $dataarray[177]; ?>
    </td></tr></tbody>
<?php } 
if (!empty($dataarray[193])){ //release prisoners
?>
    <tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
    
    <?php echo $dataarray[193]; ?>
    </td></tr></tbody>
<?php } 
if (!empty($dataarray[196]) && !empty($dataarray[197])){ //hero
?>
    <tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
    <img class="unit u<?php echo $dataarray[196]; ?>" src="img/x.gif" alt="<?php echo HERO; ?>" title="<?php echo HERO; ?>" />
    <?php echo $dataarray[197]; ?>
    </td></tr></tbody>
<?php }
if(isset($dataarray[195]) && !empty($dataarray[195])){ //No troops returned
?>	
	<tbody class="goods"><tr><th><?php echo INFORMATION; ?></th><td colspan="<?php echo $colspan; ?>">
	<?php echo $dataarray[195]; ?>
    </td></tr></tbody>
<?php }elseif(empty($dataarray[176]) && empty($dataarray[177])){?>
     <tbody class="goods"><tr><th><?php echo BOUNTY; ?></th><td colspan="<?php echo $colspan; ?>">
    <div class="res"><img class="r1" src="img/x.gif" alt="Lumber" title="Lumber" /><?php echo $dataarray[23]; ?> | <img class="r2" src="img/x.gif" alt="Clay" title="Clay" /><?php echo $dataarray[24]; ?> | <img class="r3" src="img/x.gif" alt="Iron" title="Iron" /><?php echo $dataarray[25]; ?> | <img class="r4" src="img/x.gif" alt="Crop" title="Crop" /><?php echo $dataarray[26]; ?></div><div class="carry"><img class="car" src="img/x.gif" alt="carry" title="carry" /><?php echo ($dataarray[23]+$dataarray[24]+$dataarray[25]+$dataarray[26])."/".$dataarray[27]; ?></div>
    </td></tr></tbody></table>
<?php } //Defender(s)
$defArray = [1, $dataarray[55], $dataarray[76], $dataarray[97], $dataarray[118], $dataarray[139]];
$targetTribe = $dataarray[34];
foreach($defArray as $index => $value){
    if($value == 0) continue;
    $heroIndex = ($index == 0 ? 180 : 160 + ($index - 1));
    $heroDeadIndex = ($index == 0 ? 1 : 5); 
    
    $target = ($index == 0 ? $targetTribe : $index) - 1;
    $start = $target * 10 + 1;
    $troopsStart = $index * 21 + 35;
?>    
    <table cellpadding="1" cellspacing="1" class="defender">
    <thead>
    <tr>
    <td class="role"><?php echo DEFENDER; ?></td>
	<td colspan="<?php echo $dataarray[$heroIndex] > 0 ? 11 : 10; ?>"><?php echo ($index == 0) ? $defuser_url." ".FROM_THE_VILL." ".$deffrom_url : REINFORCEMENT; ?></td>	
    </tr></thead>
    <tbody class="units">
    <tr>
    <td>&nbsp;</td>
    
<?php
for($i = $start; $i <= ($start + 9); $i++) {
    echo "<td><img src=\"img/x.gif\" class=\"unit u$i\" title=\"".$technology->getUnitName($i)."\" alt=\"".$technology->getUnitName($i)."\" /></td>";
}
if(isset($dataarray[$heroIndex]) && $dataarray[$heroIndex] > 0){
	echo "<td><img src=\"img/x.gif\" class=\"unit uhero\" title=\"".HERO."\" alt=\"".HERO."\" /></td>";
}
echo "</tr><tr><th>".TROOPS."</th>";

for($i = $troopsStart; $i <= $troopsStart + 9; $i++) {
    if($dataarray[$i] == 0) echo "<td class=\"none\">0</td>";
    else echo "<td>".$dataarray[$i]."</td>";
}

if(isset($dataarray[$heroIndex]) && $dataarray[$heroIndex] > 0){
    echo "<td>".$dataarray[$heroIndex]."</td>";
}
echo "<tr><th>".CASUALTIES."</th>";

for($i = $troopsStart + 10; $i <= $troopsStart + 19; $i++) {
    if($dataarray[$i] == 0) echo "<td class=\"none\">0</td>";
    else echo "<td>".$dataarray[$i]."</td>";
}

if(isset($dataarray[$heroIndex]) && $dataarray[$heroIndex] > 0){
    if ($dataarray[$heroIndex + $heroDeadIndex] == 0) $tdclass1 = 'class="none"';
    echo "<td $tdclass1>".$dataarray[$heroIndex + $heroDeadIndex]."</td>";
}
}
?>
</tr></tbody></table>
</td></tr></tbody></table>