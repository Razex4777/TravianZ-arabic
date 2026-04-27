<?php 
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       troops.tpl                                                  ##
##  Developed by:  Dzoki                                                       ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
##                                                                             ##
#################################################################################
?>
<table id="troops" cellpadding="1" cellspacing="1">
<thead><tr>
	<th colspan="3"><?php echo TROOPS; ?></th>
</tr></thead><tbody>
<?php
$troops = $technology->getAllUnits($village->wid,True,1);
$TroopsPresent = False;
for($i=1;$i<=50;$i++) {
	if($troops['u'.$i] > 0) {
		echo "<tr><td class=\"un\">".$technology->getUnitName($i)."</td><td class=\"num\">".number_format($troops['u'.$i])."</td>";
		echo "<td class=\"ico\"><a href=\"build.php?id=39\"><img class=\"unit u".$i."\" src=\"img/x.gif\" alt=\"".$technology->getUnitName($i)."\" title=\"".$technology->getUnitName($i)."\" /></a></td></tr>";
		$TroopsPresent = True;
	}
}
if($troops['hero'] > 0) {
		echo "<tr><td class=\"un\">".HERO."</td><td class=\"num\">".number_format($troops['hero'])."</td>";
		echo "<td class=\"ico\"><a href=\"build.php?id=39\"><img class=\"unit uhero\" src=\"img/x.gif\" alt=\"".HERO."\" title=\"".HERO."\" /></a></td></tr>";
		$TroopsPresent = True;
}
$units = $technology->getUnitList($village->wid);
if(!$TroopsPresent) {
	echo "<tr><td colspan=\"3\">".NONE."</td></tr>";
}
?>
	</tbody></table>
