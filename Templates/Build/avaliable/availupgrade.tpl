<?php
$bid = $_GET['bid'];
unset($_GET['bid']);
$bindicator = $building->canBuild($id,$bid);
$loopsame = ($building->isCurrent($id) || $building->isLoop($id))?1:0;
$doublebuild = ($building->isCurrent($id) && $building->isLoop($id))?1:0;
$uprequire = $building->resourceRequired($id, $bid);
?>
<td class="res">
        <link rel="stylesheet" type="text/css" href="responsive_blocks.css" />
        <div class="res-wrap">
            <span class="res-item"><img class="r1" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'الخشب' : 'Lumber'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'الخشب' : 'Lumber'; ?>" /><?php echo $uprequire['wood']; ?></span>
            <span class="res-item"><img class="r2" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'الطين' : 'Clay'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'الطين' : 'Clay'; ?>" /><?php echo $uprequire['clay']; ?></span>
            <span class="res-item"><img class="r3" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'الحديد' : 'Iron'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'الحديد' : 'Iron'; ?>" /><?php echo $uprequire['iron']; ?></span>
            <span class="res-item"><img class="r4" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'القمح' : 'Crop'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'القمح' : 'Crop'; ?>" /><?php echo $uprequire['crop']; ?></span>
            <span class="res-item"><img class="r5" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'استهلاك القمح' : 'Crop consumption'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'استهلاك القمح' : 'Crop consumption'; ?>" /><?php echo $uprequire['pop']; ?></span>
            <span class="res-item dur"><img class="clock" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'المدة' : 'duration'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'المدة' : 'duration'; ?>" /><?php echo $generator->getTimeFormat($uprequire['time']); ?></span>
        </div>
<?php
                   //-- If available resources combined are not enough, remove NPC button
                   $total_required = (int)($uprequire['wood'] + $uprequire['clay'] + $uprequire['iron'] + $uprequire['crop']);

                   if($session->userinfo['gold'] >= 3 && $building->getTypeLevel(17) >= 1 && $village->atotal >= $total_required) {
                   echo "<div class=\"res-npc-wrap\"><a href=\"build.php?gid=17&t=3&r1=".$uprequire['wood']."&r2=".$uprequire['clay']."&r3=".$uprequire['iron']."&r4=".$uprequire['crop']."\" title=\"NPC trade\"><img class=\"npc\" src=\"img/x.gif\" alt=\"".((defined('LANG') && LANG == 'ar') ? 'تاجر المبادلة (NPC)' : 'NPC trade')."\" title=\"".((defined('LANG') && LANG == 'ar') ? 'تاجر المبادلة (NPC)' : 'NPC trade')."\" /></a></div>";
                 } ?></td>
		</tr>
		<tr>
			<td class="link">
<?php
     if($bindicator == 2) {
     echo "<span class=\"none\">" . WORKERS_ALREADY_WORK_WAITING . "</span>";
	if($session->goldclub == 1){
?>	</br>
<?php
	if($session->gold >= 1 && $village->master == 0){
	    echo "<a class=\"build\" href=\"dorf2.php?master=$bid&id=$id&c=$session->checker\">" . CONSTRUCTING_MASTER_BUILDER . "</a>";
		echo '<font color="#B3B3B3">(costs: <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="Gold"/>1)</font>';
	}else{
		echo "<span class=\"none\">" . CONSTRUCTING_MASTER_BUILDER . "</span>";
		echo '<font color="#B3B3B3">(costs: <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="Gold"/>1)</font>';
	}
	}
     }
     else if($bindicator == 3) {
     echo "<span class=\"none\">" . WORKERS_ALREADY_WORK_WAITING . "</span>";
	if($session->goldclub == 1){
?>	</br>
<?php
	if($session->gold >= 1 && $village->master == 0){
	    echo "<a class=\"build\" href=\"dorf2.php?master=$bid&id=$id&c=$session->checker\">" . CONSTRUCTING_MASTER_BUILDER . "</a>";
		echo '<font color="#B3B3B3">(costs: <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="Gold"/>1)</font>';
	}else{
		echo "<span class=\"none\">" . CONSTRUCTING_MASTER_BUILDER . "</span>";
		echo '<font color="#B3B3B3">(costs: <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="Gold"/>1)</font>';
	}
	}
     }
     else if($bindicator == 4) {
     echo "<span class=\"none\">" . ENOUGH_FOOD_EXPAND_CROPLAND . "</span>";
     }
     else if($bindicator == 5) {
     echo "<span class=\"none\">" . UPGRADE_WAREHOUSE . "</span>";
     }
     else if($bindicator == 6) {
     echo "<span class=\"none\">" . UPGRADE_GRANARY . "</span>";
     }
     else if($bindicator == 7) {
    	$neededtime = $building->calculateAvaliable($id,$bid);
    	echo "<span class=\"none\">" .ENOUGH_RESOURCES . " " .$neededtime[0]." at  ".$neededtime[1]."</span>";
	if($session->goldclub == 1){
?>	</br>
<?php
	if($session->gold >= 1 && $village->master == 0){
	    echo "<a class=\"build\" href=\"dorf2.php?master=$bid&id=$id&c=$session->checker\">" . CONSTRUCTING_MASTER_BUILDER . "</a>";
		echo '<font color="#B3B3B3">(costs: <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="Gold"/>1)</font>';
	}else{
		echo "<span class=\"none\">" . CONSTRUCTING_MASTER_BUILDER . "</span>";
		echo '<font color="#B3B3B3">(costs: <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="Gold"/>1)</font>';
	}
	}
     }
     else if($bindicator == 8) {
	 if($session->access!=BANNED){
     	echo "<a class=\"build\" href=\"dorf2.php?a=$bid&id=$id&c=".$session->checker."\">". CONSTRUCT_BUILD."</a>";
	 }else{
		echo "<a class=\"build\" href=\"banned.php\">". CONSTRUCT_BUILD."</a>";
	 }
     }
     else if($bindicator == 9) {
     $wait_text = (defined('LANG') && LANG == 'ar') ? 'تشييد المبنى (قائمة الانتظار)' : 'Construct building. (waiting loop)';
	 if($session->access!=BANNED){
     	echo "<a class=\"build\" href=\"dorf2.php?a=$bid&id=$id&c=".$session->checker."\">".$wait_text."</a>";
	 }else{
		echo "<a class=\"build\" href=\"banned.php?a=$bid&id=$id&c=".$session->checker."\">".$wait_text."</a>";
	 }
     }
            ?>	
</td>
