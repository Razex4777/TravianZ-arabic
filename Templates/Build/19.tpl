<div id="build" class="gid19"><a href="#" onClick="return Popup(19,4);" class="build_logo">
	<img class="building g19" src="img/x.gif" alt="Barracks" title="<?php echo BARRACKS; ?>" />
</a>
<h1><?php echo BARRACKS; ?> <span class="level"><?php echo LEVEL; ?> <?php echo $village->resarray['f'.$id]; ?></span></h1>
<p class="build_desc"><?php echo BARRACKS_DESC; ?> </p>

<?php if ($building->getTypeLevel(19) > 0) { ?>
<form method="POST" name="snd" action="build.php">
				<input type="hidden" name="id" value="<?php echo $id; ?>" />
				<input type="hidden" name="ft" value="t1" />
				<table cellpadding="1" cellspacing="1" class="build_details">
				<thead><tr>
					<td><?php echo NAME; ?></td>
					<td><?php echo QUANTITY; ?></td>
					<td><?php echo MAX; ?></td>
				</tr></thead><tbody>
                <?php
	                include("19_train.tpl");
                ?></table>
	<p><button id="btn_train" class="trav_buttons" value="ok" name="s1" alt="train" onclick="this.disabled=true;this.form.submit();"/> <?php echo TRAIN; ?> </button></form></p>
    <?php
	} else {
		echo "<b>".TRAINING_COMMENCE_BARRACKS."</b><br>\n";
	}
    $trainlist = $technology->getTrainingList(1);
    if(count($trainlist) > 0) {
    	echo "
    <table cellpadding=\"1\" cellspacing=\"1\" class=\"under_progress\">
		<thead><tr>
			<td>".TRAINING."";
		if($session->gold >= 35) {
			echo " <a href=\"?id=".$id."&trainingFinish=1\" title=\"Finish all training immediately for 35 Gold?\"><img class=\"clock\" alt=\"Finish training\" src=\"img/x.gif\"/></a>";
		}
		echo "</td>
			<td>".DURATION."</td>

		</tr></thead>
		<tbody>";
		$TrainCount = 0;
        foreach($trainlist as $train) {
			$TrainCount++;
	        echo "<tr><td class=\"desc\">";
			echo "<img class=\"unit u".$train['unit']."\" src=\"img/x.gif\" alt=\"".$train['name']."\" title=\"".$train['name']."\" />";
			echo $train['amt']." ".$train['name']."</td><td class=\"dur\">";
			if ($TrainCount == 1 ) {
				$NextFinished = $generator->getTimeFormat($train['timestamp2']-time());
				echo "<span id=timer".++$session->timer.">".$generator->getTimeFormat($train['timestamp']-time())."</span>";
			} else {
				echo $generator->getTimeFormat($train['eachtime']*$train['amt']);
			}
			echo "</td>";
		} ?>
		</tr>
		</tbody></table>
    <?php }
include("upgrade.tpl");
?>
</p></div>
