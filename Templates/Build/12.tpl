<div id="build" class="gid12"><a href="#" onClick="return Popup(12,4);" class="build_logo">

	<img class="building g12" src="img/x.gif" alt="Blacksmith" title="<?php echo BLACKSMITH; ?>" />
</a>
<h1><?php echo BLACKSMITH; ?> <span class="level"><?php echo LEVEL; ?> <?php echo $village->resarray['f'.$id]; ?></span></h1>
<p class="build_desc"><?php echo BLACKSMITH_DESC; ?></p>
<?php
include("GameEngine/Data/unitdata.php");
$abdata = $database->getABTech($village->wid);
?>
<table cellpadding="1" cellspacing="1" id="troops_stats" class="troops_stats" style="margin-bottom: 10px; width: 100%; text-align: center; border: 1px solid #e1e8ed; background-color: #f7f9fa; border-radius: 4px;">
    <thead>
        <tr>
            <th colspan="9" style="text-align:center; padding: 6px; background-color: #e1e8ed; font-weight: bold; border-radius: 4px 4px 0 0;"><?php echo (defined('LANG') && LANG === 'ar') ? 'قوة الجنود الهجومية الحالية' : 'Current Attack Power of Soldiers'; ?></th>
        </tr>
        <tr>
            <td style="font-weight:bold; padding: 4px; border-bottom: 1px solid #e1e8ed;"><?php echo (defined('LANG') && LANG === 'ar') ? 'الجنود' : 'Soldiers'; ?></td>
            <?php
            for($i = ($session->tribe*10-9); $i <= ($session->tribe*10-2); $i++) {
                echo "<td style=\"padding: 4px; border-bottom: 1px solid #e1e8ed;\"><img class=\"unit u".$i."\" src=\"img/x.gif\" alt=\"".$technology->getUnitName($i)."\" title=\"".$technology->getUnitName($i)."\" /></td>";
            }
            ?>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td style="font-weight:bold; padding: 4px;"><img class="att_all" src="img/x.gif" alt="Attack" title="Attack" /></td>
            <?php
            for($i = ($session->tribe*10-9); $i <= ($session->tribe*10-2); $i++) {
                $j = $i % 10;
                if ($j == 0) $j = 10;
                $level = $abdata['b'.$j];
                $unit = ${'u'.$i};
                $atk = round($unit['atk'] + ($unit['atk'] + 300 * $unit['pop'] / 7) * (pow(1.007, $level) - 1));
                echo "<td style=\"padding: 4px; font-weight:bold; color:#d4af37;\">".$atk."</td>";
            }
            ?>
        </tr>
    </tbody>
</table>

<?php
	if ($building->getTypeLevel(12) > 0) {
		include("12_upgrades.tpl");
	} else {
		echo "<p><b><?php echo UPGRADES_COMMENCE_BLACKSMITH; ?></b><br>\n";
	}
include("upgrade.tpl");
?>
        </p>
         </div>
