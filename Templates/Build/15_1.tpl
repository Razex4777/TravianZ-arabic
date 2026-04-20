<?php
$ty = (isset($_GET['ty']))? $_GET['ty']:"";
if(isset($_REQUEST["cancel"]) && $_REQUEST["cancel"] == "1") {
    $database->delDemolition($village->wid);
    header("Location: build.php?gid=15&ty=$ty&cancel=0&demolish=0");
	exit;
}

if($session->alliance) $memberCount = $database->countAllianceMembers($session->alliance);
else $memberCount = 0;

// --- Regular demolish (queue-based, one level at a time) ---
// Gold demolish is handled in build.php before template loading
if(!empty($_REQUEST["demolish"]) && $_REQUEST["c"] == $session->mchecker && !(isset($_POST['goldDemolish']) && $_POST['goldDemolish'] == '1')) {
    if($_REQUEST["type"] != null && (($_REQUEST["type"] >= 19 && $_REQUEST["type"] <= 40) || $_REQUEST["type"] == 99)) {
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
<form action=\"build.php?gid=15&amp;demolish=1&amp;cancel=0&amp;c=".$session->mchecker."\" method=\"POST\" style=\"display:inline\" id=\"demolish_form\">
<select id=\"demolition_type\" name=\"type\" class=\"dropdown\">";
        for ($i=19; $i<=41; $i++) {
            $select=($i==$ty)? " SELECTED":"";
            if (isset($VillageResourceLevels['f'.$i]) && $VillageResourceLevels['f'.$i] >= 1 && !$building->isCurrent($i) && !$building->isLoop($i)) {
                $bLevel = $VillageResourceLevels['f'.$i];
                echo "<option value=".$i.$select." data-level=\"".$bLevel."\">".$i.". ".$building->procResType($VillageResourceLevels['f'.$i.'t'])." (".LEVEL." ".$bLevel.")</option>";
            }
}
if ($village->natar==1) {
            $select=($ty==99)? " SELECTED":"";
            if ($VillageResourceLevels['f99'] >= 1 && !$building->isCurrent(99) && !$building->isLoop(99)) {
                $bLevel = $VillageResourceLevels['f99'];
                echo "<option value=99".$select." data-level=\"".$bLevel."\">99. ".$building->procResType(40)." (".LEVEL." ".$bLevel.")</option>";
            }
}
echo "</select> ";
// Gold checkbox — like the reference video
echo "<label style='margin: 0 8px; cursor:pointer;'><input type='checkbox' id='gold_demolish_check' name='goldDemolish' value='1'> <img src=\"img/x.gif\" class=\"gold\" alt=\"".GOLD_TEXT."\" title=\"".GOLD_TEXT."\"/> ".DEMOLISH_GOLD_PER_LEVEL."</label> ";
echo "<button name=\"demolish\" value=\"1\" type=\"submit\" class=\"trav_buttons\" onClick=\"javascript:return verify_demolition();\">".DEMOLISH."</button></form>";
if (isset($_GET['nogold'])) {
    echo "<p style='color:red;'>".(defined('LANG') && LANG === 'ar' ? 'ليس لديك ذهب كافٍ لإتمام عملية الهدم.' : 'Not enough gold to demolish this building.')."</p>";
}
}
}
?> 

<script type="text/javascript">
<!--
	function verify_demolition() {
		var dType    = document.getElementById('demolition_type');
		var goldCheck = document.getElementById('gold_demolish_check');
		var selectedOption = dType.options[dType.selectedIndex];
		var buildingLevel = parseInt(selectedOption.getAttribute('data-level')) || 0;

		// If gold checkbox is checked, confirm gold spending then redirect via GET
		if (goldCheck && goldCheck.checked) {
			var goldCost = buildingLevel;
			if (!window.confirm('<?php echo DEMOLISH_TO_ZERO; ?>\n\n' 
				+ selectedOption.text + '\n\n'
				+ '<?php echo GOLD_TEXT; ?>: ' + goldCost + '\n\n'
				+ '<?php echo addslashes(CONFIRM_DEMOLISH_ZERO_GOLD_JS ?? "هل أنت متأكد؟"); ?>')) {
				return false;
			}
			// Redirect via GET to the existing goldDemolish handler in build.php
			window.location.href = 'build.php?id=' + dType.value + '&goldDemolish=1&slot=' + dType.value;
			return false; // prevent form submission
		}

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
