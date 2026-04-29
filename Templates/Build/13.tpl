<div id="build" class="gid13"><a href="#" onClick="return Popup(13,4);" class="build_logo">

	<img class="building g13" src="img/x.gif" alt="Armoury" title="<?php echo ARMOURY; ?>" />
</a>
<h1><?php echo ARMOURY; ?> <span class="level"><?php echo LEVEL; ?> <?php echo $village->resarray['f'.$id]; ?></span></h1>
<p class="build_desc"><?php echo ARMOURY_DESC; ?></p>
<?php
include("GameEngine/Data/unitdata.php");
$abdata = $database->getABTech($village->wid);
?>
<table cellpadding="1" cellspacing="1" id="troops_stats" class="troops_stats" style="margin-bottom: 10px; width: 100%; text-align: center; border: 1px solid #e1e8ed; background-color: #f7f9fa; border-radius: 4px;">
    <thead>
        <tr>
            <th colspan="9" style="text-align:center; padding: 6px; background-color: #e1e8ed; font-weight: bold; border-radius: 4px 4px 0 0;"><?php echo (defined('LANG') && LANG === 'ar') ? 'قوة الجنود الدفاعية الحالية' : 'Current Defense Power of Soldiers'; ?></th>
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
            <td style="font-weight:bold; padding: 4px;"><img class="def_i" src="img/x.gif" alt="Infantry Defense" title="Infantry Defense" /></td>
            <?php
            for($i = ($session->tribe*10-9); $i <= ($session->tribe*10-2); $i++) {
                $j = $i % 10;
                if ($j == 0) $j = 10;
                $level = $abdata['a'.$j];
                $unit = ${'u'.$i};
                $di = round($unit['di'] + ($unit['di'] + 300 * $unit['pop'] / 7) * (pow(1.007, $level) - 1));
                echo "<td style=\"padding: 4px; font-weight:bold; color:#27ae60;\">".$di."</td>";
            }
            ?>
        </tr>
        <tr>
            <td style="font-weight:bold; padding: 4px;"><img class="def_c" src="img/x.gif" alt="Cavalry Defense" title="Cavalry Defense" /></td>
            <?php
            for($i = ($session->tribe*10-9); $i <= ($session->tribe*10-2); $i++) {
                $j = $i % 10;
                if ($j == 0) $j = 10;
                $level = $abdata['a'.$j];
                $unit = ${'u'.$i};
                $dc = round($unit['dc'] + ($unit['dc'] + 300 * $unit['pop'] / 7) * (pow(1.007, $level) - 1));
                echo "<td style=\"padding: 4px; font-weight:bold; color:#2980b9;\">".$dc."</td>";
            }
            ?>
        </tr>
    </tbody>
</table>

<?php
	if ($building->getTypeLevel(13) > 0) {
		include("13_upgrades.tpl");
	} else {
		echo "<p><b><?php echo UPGRADES_COMMENCE_ARMOURY; ?>Upgrades can commence when armoury is completed.</b><br>\n";
	}
include("upgrade.tpl");
?>
        </p>
         </div>
