<?php

$bid = $village->resarray['f'.$id.'t'];
$bindicate = $building->canBuild($id, $bid);
if($bindicate == 1) {
	echo "<p><span class=\"none\">".MAX_LEVEL."</span></p>";
} else if($bindicate == 10) {
	echo "<p><span class=\"none\">".BUILDING_MAX_LEVEL_UNDER."</span></p>";
} else if($bindicate == 11) {
	echo "<p><span class=\"none\">".BUILDING_BEING_DEMOLISHED."</span></p>";
} else {
	$loopsame = ($building->isCurrent($id) || $building->isLoop($id)) ? 1 : 0;
	$doublebuild = ($building->isCurrent($id) && $building->isLoop($id)) ? 1 : 0;
	$master = count($database->getMasterJobsByField($village->wid,$id));

	// master and loopsame would have duplicated level display,
    // so we need to decrease loopsame if master is the only job left
	if ($master == 1 && $loopsame == 1) $loopsame = 0;

    //-- If available resources combined are not enough, remove NPC button
	$uprequire = $building->resourceRequired($id,$village->resarray['f'.$id.'t'],1 + $loopsame + $doublebuild + $master);
?>
<?php
$total_required = (int)($uprequire['wood'] + $uprequire['clay'] + $uprequire['iron'] + $uprequire['crop']);
?>
<p id="contract"><b><?php echo COSTS_UPGRADING_LEVEL;?> <?php echo $village->resarray['f'.$id]+1+$loopsame+$doublebuild+$master; ?>:</b><br />
<link rel="stylesheet" type="text/css" href="responsive_blocks.css" />
<div class="res-wrap">
    <span class="res-item"><img class="r1" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'الخشب' : 'Lumber'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'الخشب' : 'Lumber'; ?>" /><?php echo $uprequire['wood']; ?></span>
    <span class="res-item"><img class="r2" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'الطين' : 'Clay'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'الطين' : 'Clay'; ?>" /><?php echo $uprequire['clay']; ?></span>
    <span class="res-item"><img class="r3" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'الحديد' : 'Iron'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'الحديد' : 'Iron'; ?>" /><?php echo $uprequire['iron']; ?></span>
    <span class="res-item"><img class="r4" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'القمح' : 'Crop'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'القمح' : 'Crop'; ?>" /><?php echo $uprequire['crop']; ?></span>
    <span class="res-item"><img class="r5" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'استهلاك القمح' : 'Crop consumption'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'استهلاك القمح' : 'Crop consumption'; ?>" /><?php echo $uprequire['pop']; ?></span>
    <span class="res-item dur"><img class="clock" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG == 'ar') ? 'المدة' : 'duration'; ?>" title="<?php echo (defined('LANG') && LANG == 'ar') ? 'المدة' : 'duration'; ?>" /><?php echo $generator->getTimeFormat($uprequire['time']); ?></span>
<?php
if($session->gold >= 3 && $village->acrop >= 0) {
                   echo "<span class=\"res-item\"><a href=\"build.php?gid=17&t=3&r1=".$uprequire['wood']."&r2=".$uprequire['clay']."&r3=".$uprequire['iron']."&r4=".$uprequire['crop']."\" title=\"NPC trade\"><img class=\"npc\" src=\"img/x.gif\" alt=\"NPC\" title=\"NPC\" /></a></span>";
} ?>
</div>
</p><br />
<?php
    if($village->acrop < 0) {
        echo "<span class=\"none\">Paralyzed: Crop storage is negative. You Cannot Build Or Upgrade.</span>";
    } else if($bindicate == 2) {
   		echo "<span class=\"none\">".WORKERS_ALREADY_WORK."</span>";
	if($session->goldclub == 1){
?>	</br>
<?php
	if($id <= 18) {
	if($session->gold >= 1 && $village->master == 0){
	    echo "<a class=\"build\" href=\"dorf1.php?master=$bid&id=$id&c=$session->checker\">".CONSTRUCTING_MASTER_BUILDER." </a>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}else{
		echo "<span class=\"none\">".CONSTRUCTING_MASTER_BUILDER."</span>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}
	}else{
	if($session->gold >= 1 && $village->master == 0){
	    echo "<a class=\"build\" href=\"dorf2.php?master=$bid&id=$id&c=$session->checker\">".CONSTRUCTING_MASTER_BUILDER." </a>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}else{
		echo "<span class=\"none\">".CONSTRUCTING_MASTER_BUILDER."</span>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}
	}
	}
    }
    else if($bindicate == 3) {
    	echo "<span class=\"none\">".WORKERS_ALREADY_WORK_WAITING."</span>";
	if($session->goldclub == 1){
?>	</br>
<?php
	if($id <= 18) {
	if($session->gold >= 1 && $village->master == 0){
	    echo "<a class=\"build\" href=\"dorf1.php?master=$bid&id=$id&c=$session->checker\">".CONSTRUCTING_MASTER_BUILDER." </a>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}else{
		echo "<span class=\"none\">".CONSTRUCTING_MASTER_BUILDER."</span>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}
	}else{
	if($session->gold >= 1 && $village->master == 0){
	    echo "<a class=\"build\" href=\"dorf2.php?master=$bid&id=$id&c=$session->checker\">".CONSTRUCTING_MASTER_BUILDER." </a>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}else{
		echo "<span class=\"none\">".CONSTRUCTING_MASTER_BUILDER."</span>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}
	}
	}
    }
    else if($bindicate == 4) {
    	echo "<span class=\"none\">".ENOUGH_FOOD_EXPAND_CROPLAND."</span>";
    }
    else if($bindicate == 5) {
    	echo "<span class=\"none\">".UPGRADE_WAREHOUSE.".</span>";
    }
    else if($bindicate == 6) {
    	echo "<span class=\"none\">".UPGRADE_GRANARY.".</span>";
    }
    else if($bindicate == 7) {
	if($village->allcrop - $village->pop - $technology->getUpkeep($village->unitall, 0) > 0){
    	$neededtime = $building->calculateAvaliable($id,$village->resarray['f'.$id.'t'],1+$loopsame+$doublebuild+$master);
    	echo "<span class=\"none\">".ENOUGH_RESOURCES." ".$neededtime[0]." at  ".$neededtime[1]."</span>";
	}else{
		echo "<span class=\"none\">".YOUR_CROP_NEGATIVE."</span>";
	}
	if($session->goldclub == 1){
?>	</br>
<?php
	if($id <= 18) {
	if($session->gold >= 1 && $village->master == 0){
	    echo "<a class=\"build\" href=\"dorf1.php?master=$bid&id=$id&c=$session->checker\">".CONSTRUCTING_MASTER_BUILDER." </a>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}else{
		echo "<span class=\"none\">".CONSTRUCTING_MASTER_BUILDER."</span>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}
	}else{
	if($session->gold >= 1 && $village->master == 0){
	    echo "<a class=\"build\" href=\"dorf2.php?master=$bid&id=$id&c=$session->checker\">".CONSTRUCTING_MASTER_BUILDER." </a>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}else{
		echo "<span class=\"none\">".CONSTRUCTING_MASTER_BUILDER."</span>";
		echo '<font color="#B3B3B3">('.COSTS.': <img src="'.GP_LOCATE.'img/a/gold_g.gif" alt="Gold" title="'.GOLD.'"/>1)</font>';
	}
	}
	}
    }
    else if($bindicate == 8) {
		if($session->access==BANNED){
    	echo "<a class=\"build\" href=\"banned.php\">".UPGRADE_LEVEL." ";
		}
		else if($id <= 18) {
    	echo "<a class=\"build\" href=\"dorf1.php?a=$id&c=$session->checker\">".UPGRADE_LEVEL." ";
        }
        else {
        echo "<a class=\"build\" href=\"dorf2.php?a=$id&c=$session->checker\">".UPGRADE_LEVEL." ";
        }
		echo $village->resarray['f'.$id]+1;
		echo ".</a>";
		}
    else if($bindicate == 9) {
		if($session->access==BANNED){
    	echo "<a class=\"build\" href=\"banned.php\">".UPGRADE_LEVEL." ";
		}
    	else if($id <= 18) {
    	echo "<a class=\"build\" href=\"dorf1.php?a=$id&c=$session->checker\">".UPGRADE_LEVEL." ";
        }
        else {
        echo "<a class=\"build\" href=\"dorf2.php?a=$id&c=$session->checker\">".UPGRADE_LEVEL." ";
        }
		echo $village->resarray['f'.$id]+($loopsame > 0 ? 2:1);
		echo ".</a> <span class=\"none\">".WAITING."</span> ";
    }
}

// --- Gold: Upgrade to Max Level ---
// Show a gold button to instantly upgrade this building to max level
// Cost = max_level - current_level gold
$currentBuildingType = $village->resarray['f'.$id.'t'];
$currentBuildingLevel = (int) $village->resarray['f'.$id];
$buildingMaxLevel = $building->getMaxLevel($currentBuildingType);

// Exclude unique/special buildings from gold upgrade to max:
// 25 = Residence, 26 = Palace, 40 = WW (these have special building rules)
$excludeFromGoldMax = [25, 26, 40];

if ($currentBuildingType > 0 && $currentBuildingLevel < $buildingMaxLevel && $buildingMaxLevel > 0 && !in_array($currentBuildingType, $excludeFromGoldMax)) {
	$upgradeCost = $buildingMaxLevel - $currentBuildingLevel;
	echo " | ";
	if ($session->gold >= $upgradeCost) {
		
		echo "<a class=\"build\" href=\"build.php?id=$id&upgradeToMax=1\">";
		echo UPGRADE_TO_LEVEL_MAX." $buildingMaxLevel <span style=\"color:#000;font-weight:normal;\">$upgradeCost <img src=\"".GP_LOCATE."img/a/gold_g.gif\" alt=\"".GOLD_TEXT."\" title=\"".GOLD_TEXT."\"/></span>";
		echo "</a>";
	} else {
		echo "<span class=\"none\">";
		echo UPGRADE_TO_LEVEL_MAX." $buildingMaxLevel $upgradeCost <img src=\"".GP_LOCATE."img/a/gold_g.gif\" alt=\"".GOLD_TEXT."\" title=\"".GOLD_TEXT."\"/> - ".NOT_ENOUGH_GOLD_TEXT;
		echo "</span>";
	}
}

// Gold demolish (هدم بالذهب) is only available in the Main Building (المبنى الرئيسي)

?>
