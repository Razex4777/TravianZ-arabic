<?php
$ty = (isset($_GET['ty']))? $_GET['ty']:"";
if(isset($_REQUEST["cancel"]) && $_REQUEST["cancel"] == "1") {
    $database->delDemolition($village->wid);
    header("Location: build.php?gid=15&ty=$ty&cancel=0&demolish=0");
	exit;
}

if($session->alliance) $memberCount = $database->countAllianceMembers($session->alliance);
else $memberCount = 0;

if(!empty($_REQUEST["demolish"]) && $_REQUEST["c"] == $session->mchecker) {
    if($_REQUEST["type"] != null && ($_REQUEST["type"] >= 19 && $_REQUEST["type"] <= 40 || $_REQUEST["type"] == 99)) {
        $type = $_REQUEST['type'];
        $demolish_permitted = $database->addDemolition($village->wid,$type);
        if ($demolish_permitted === true) {
            $session->changeChecker();
            header("Location: build.php?gid=15&ty=$type&cancel=0&demolish=0");
        } 
        else header("Location: build.php?gid=15&ty=$type&nodemolish=".$demolish_permitted);
        exit;
    }
}

// --- Gold instant demolish from main building ---
if(isset($_GET['goldDemolish']) && isset($_GET['slot']) && $_GET['goldDemolish'] == 1) {
    $slot = (int) $_GET['slot'];
    if ($slot >= 19 && $slot <= 40) {
        $building->demolishToZero($slot);
        header("Location: dorf2.php");
        exit;
    }
}

if($village->resarray['f'.$id] >= DEMOLISH_LEVEL_REQ) {
    echo "<h2>".DEMOLITION_BUILDING."";
    $VillageResourceLevels = $database->getResourceLevel($village->wid);
    $DemolitionProgress = $database->getDemolition($village->wid);
    if (!empty($DemolitionProgress)) {
        $Demolition = $DemolitionProgress[0];
        echo "<b>";
        echo "<a href='build.php?id=".$_GET['id']."&ty=".$ty."&cancel=1'><img src='img/x.gif' class='del' title='".CANCEL."' alt='".CANCEL."'></a> ";
        echo "".DEMOLITION_OF." ".$building->procResType($VillageResourceLevels['f'.$Demolition['buildnumber'].'t']).": <span id=timer1>".$generator->getTimeFormat($Demolition['timetofinish']-time())."</span>";
            if($session->gold >= 2) {
            ?> 
            <a href="?id=15&buildingFinish=1&ty=<?php echo $ty;?>" title="<?php echo FINISH_GOLD; ?>"><img class="clock" alt="<?php echo FINISH_GOLD; ?>" src="img/x.gif"/></a>
            <?php
}
echo "</b>";
} else {
		if (isset($_GET['nodemolish'])) {
			switch ($_GET['nodemolish']) {
				case 18:
					echo '<p style="color: #ff0000; text-align: right">
					لا يمكن هدم السفارة لأنك قائد التحالف، والسفارة تحتوي على <b>'.$memberCount.'</b> عضو.
					يمكنك <a href="allianz.php?s=5">مغادرة التحالف</a> واختيار قائد جديد، ثم متابعة الهدم.
					</p>';
					break;
			}
		}

        echo "
<form action=\"build.php?gid=15&amp;demolish=1&amp;cancel=0&amp;c=".$session->mchecker."\" method=\"POST\" style=\"display:inline\">
<select id=\"demolition_type\" name=\"type\" class=\"dropdown\">";
        for ($i=19; $i<=41; $i++) {
            $select=($i==$ty)? " SELECTED":"";
            if (isset($VillageResourceLevels['f'.$i]) && $VillageResourceLevels['f'.$i] >= 1 && !$building->isCurrent($i) && !$building->isLoop($i)) {
                echo "<option value=".$i.$select.">".$i.". ".$building->procResType($VillageResourceLevels['f'.$i.'t'])." (".LEVEL." ".$VillageResourceLevels['f'.$i].")</option>";
            }
}
if ($village->natar==1) {
            $select=($ty==99)? " SELECTED":"";
            if ($VillageResourceLevels['f99'] >= 1 && !$building->isCurrent(99) && !$building->isLoop(99)) {
                echo "<option value=99".$select.">99. ".$building->procResType(40)." (".LEVEL." ".$VillageResourceLevels['f99'].")</option>";
            }
}
echo "</select> <button name=\"demolish\" value=\"1\" type=\"submit\" class=\"trav_buttons\" onClick=\"javascript:return verify_demolition();\">".DEMOLISH."</button></form>";

// --- Gold instant demolish option ---
echo "<hr style='border:none; border-top:1px solid #ddd; margin:10px 0;'>";
echo "<p style='font-weight:bold; color:#996633;'>🪙 ".DEMOLISH_TO_ZERO." (".GOLD_TEXT.")</p>";
echo "<form style='display:inline'>";
echo "<input type='hidden' name='gid' value='15'>";
echo "<select id='gold_demolish_type' name='slot' class='dropdown'>";
for ($i=19; $i<=41; $i++) {
    $gSelect = ($i==$ty)? " SELECTED":"";
    if (isset($VillageResourceLevels['f'.$i]) && $VillageResourceLevels['f'.$i] >= 1 && !$building->isCurrent($i) && !$building->isLoop($i)) {
        $bLevel = $VillageResourceLevels['f'.$i];
        $goldNeeded = $bLevel; // 1 gold per level
        echo "<option value=".$i.$gSelect.">".$i.". ".$building->procResType($VillageResourceLevels['f'.$i.'t'])." (".LEVEL." ".$bLevel.") — ".$goldNeeded." ".GOLD_TEXT."</option>";
    }
}
echo "</select> ";
echo "<a href='#' onclick='doGoldDemolish(); return false;' style='color:#996633; font-weight:bold; cursor:pointer;'>🪙 ".DEMOLISH_TO_ZERO."</a>";
echo "</form>";
}
}
?> 

<script type="text/javascript">
<!--
	function doGoldDemolish() {
		var sel = document.getElementById('gold_demolish_type');
		var slot = sel.value;
		window.location.href = 'build.php?gid=15&goldDemolish=1&slot=' + slot;
	}

	function verify_demolition() {
		var dType    = document.getElementById('demolition_type');
		var warnLvl3 = <?php
			if (
				$session->alliance &&
				$database->isAllianceOwner($session->uid) == $session->alliance &&
				$memberCount == 1 &&
				$database->getSingleFieldTypeCount($session->uid, 18, '>=', 3) == 1
			) {
				echo 'true';
			} else {
				echo 'false';
			}
		?>;
		var warnLvl1 = <?php
			if ($session->alliance && $database->getSingleFieldTypeCount($session->uid, 18, '>=', 1) == 1) {
				echo 'true';
			} else {
				echo 'false';
			}
		?>;

		if (warnLvl3 && dType.options[dType.selectedIndex].text.indexOf('Embassy') > -1) {
			if (!window.confirm('تحذير!\n'
				+ 'أنت على وشك هدم آخر سفارة من المستوى 3!\n\n'
				+ 'بما أنك قائد التحالف ولا يوجد أعضاء إضافيون، سيتم حل التحالف بعد اكتمال الهدم.\n\n'
				+ 'بعد ذلك يمكنك تأسيس تحالف جديد أو الانضمام لتحالف موجود.\n\n'
				+ 'اضغط موافق للتأكيد أو إلغاء للتوقف.')) {
				return false;
			}
		} else if (warnLvl1 && dType.options[dType.selectedIndex].text.indexOf('Embassy') > -1) {
			if (!window.confirm('تحذير!\n'
				+ 'أنت على وشك هدم آخر سفارة لديك!\n\n'
				+ 'بما أنك في تحالف، ستغادر التحالف تلقائياً بعد اكتمال الهدم.\n\n'
				+ 'بعد ذلك يمكنك تأسيس أو الانضمام لتحالف مجدداً.\n\n'
				+ 'اضغط موافق للتأكيد أو إلغاء للتوقف.')) {
				return false;
			}
		}
		
		return true;
	}
//-->
</script>