<?php 
		$timeleft = $database->getVillageField($village->wid, 'celebration');
		if($timeleft > time()){
			echo '</br>';
			echo '<table cellpadding="0" cellspacing="0" id="building_contract">';
			echo '<tr><td>';
            echo CELEBRATION_NEEDS;
            echo "</td><td><span id=\"timer".++$session->timer."\">";
            echo $generator->getTimeFormat($timeleft - time());
            echo "</span> ".HRS_TEXT."</td>";
            echo "<td>".DONE_AT_TEXT." ".date('H:i', $timeleft)."</td></tr>";
			echo "</table>";
		}
?>