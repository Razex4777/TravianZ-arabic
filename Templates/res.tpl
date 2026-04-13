<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       res.tpl                                                     ##
##  Developed by:  Dzoki                                                       ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
##                                                                             ##
#################################################################################
?>

<?php
// Natars cration script does not have village initialized
if (!empty($village)) {
    $wood            = round( $village->getProd( "wood" ) );
    $clay            = round( $village->getProd( "clay" ) );
    $iron            = round( $village->getProd( "iron" ) );
    $crop            = round( $village->getProd( "crop" ) );
    $totalproduction = $village->allcrop; // all crops + bakery + grain mill

    $awood = round($village->awood);
    $aclay = round($village->aclay);
    $airon = round($village->airon);
    $acrop = round($village->acrop);
    $maxstore = $village->maxstore;
    $maxcrop = $village->maxcrop;

    // Green when storage is >= 80% full
    $woodClass = ($awood >= $maxstore * 0.8) ? ' res_full' : '';
    $clayClass = ($aclay >= $maxstore * 0.8) ? ' res_full' : '';
    $ironClass = ($airon >= $maxstore * 0.8) ? ' res_full' : '';
    $cropClass = ($acrop >= $maxcrop * 0.8) ? ' res_full' : '';
?>

<div id="res">
<div id="resWrap">

	<table cellpadding="1" cellspacing="1">
		<tr>
			<td><img src="img/x.gif" class="r1" alt="<?php echo LUMBER; ?>" title="<?php echo LUMBER; ?>" /></td>
			<td id="l4" title="<?php echo $wood; ?>" class="res-pill<?php echo $woodClass; ?>"><?php echo $awood."/".$maxstore; ?></td>

			<td><img src="img/x.gif" class="r2" alt="<?php echo CLAY; ?>" title="<?php echo CLAY; ?>" /></td>
			<td id="l3" title="<?php echo $clay; ?>" class="res-pill<?php echo $clayClass; ?>"><?php echo $aclay."/".$maxstore; ?></td>

			<td><img src="img/x.gif" class="r3" alt="<?php echo IRON; ?>" title="<?php echo IRON; ?>" /></td>
			<td id="l2" title="<?php echo $iron; ?>" class="res-pill<?php echo $ironClass; ?>"><?php echo $airon."/".$maxstore; ?></td>

			<td><img src="img/x.gif" class="r4" alt="<?php echo CROP; ?>" title="<?php echo CROP; ?>" /></td>
			<?php if($acrop > 0){ ?>
			<td id="l1" title="<?php echo $crop; ?>" class="res-pill<?php echo $cropClass; ?>"><?php echo $acrop."/".$maxcrop; ?></td>
			<?php }else{ ?>
			<td title="<?php echo $crop; ?>" class="res-pill"><?php echo "0/".$maxcrop; ?></td>
			<?php } ?>

			<td><img src="img/x.gif" class="r5" alt="<?php echo CROP_COM; ?>" title="<?php echo CROP_COM; ?>" /></td>
			<td class="res-pill res-consumption"><?php echo ($village->pop+$technology->getUpkeep($village->unitall,0))."/".$totalproduction; ?></td>
		</tr>
	</table>
    </div>
</div>

<style>
/* ===== Resource Bar — Green Pill Fields ===== */

/* Transparent table base */
#res table,
#res table td {
    background-color: transparent !important;
}

#res td {
    font-weight: bold;
    padding: 1px !important;
    vertical-align: middle;
}

/* Icon cells — snug spacing */
#res td:has(img.r1),
#res td:has(img.r2),
#res td:has(img.r3),
#res td:has(img.r4),
#res td:has(img.r5) {
    padding: 0 0 0 6px !important;
}

/* Resource value pills */
.res-pill {
    background: linear-gradient(180deg, #8BC34A 0%, #689F38 100%);
    border: 1px solid #558B2F;
    border-radius: 4px;
    padding: 1px 6px !important;
    color: #fff;
    font-weight: bold;
    font-size: 11px;
    text-shadow: 0 1px 1px rgba(0,0,0,0.25);
    box-shadow: inset 0 1px 0 rgba(255,255,255,0.2);
    white-space: nowrap;
}

/* Full storage: bright green glow */
.res-pill.res_full {
    background: linear-gradient(180deg, #AEEA00 0%, #71D000 50%, #4CAF50 100%);
    border-color: #33691E;
    box-shadow: inset 0 1px 0 rgba(255,255,255,0.35), 0 0 4px rgba(139,195,74,0.4);
}

/* Crop consumption: neutral grey-blue */
.res-pill.res-consumption {
    background: linear-gradient(180deg, #90A4AE 0%, #607D8B 100%);
    border-color: #455A64;
}

/* Resource icon spacing */
#res table img {
    margin-left: 5px;
}
</style>
<?php
}