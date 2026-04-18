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
			<td><div id="l4" title="<?php echo $wood; ?>" class="res-pill<?php echo $woodClass; ?>"><?php echo $awood."/".$maxstore; ?></div></td>

			<td><img src="img/x.gif" class="r2" alt="<?php echo CLAY; ?>" title="<?php echo CLAY; ?>" /></td>
			<td><div id="l3" title="<?php echo $clay; ?>" class="res-pill<?php echo $clayClass; ?>"><?php echo $aclay."/".$maxstore; ?></div></td>

			<td><img src="img/x.gif" class="r3" alt="<?php echo IRON; ?>" title="<?php echo IRON; ?>" /></td>
			<td><div id="l2" title="<?php echo $iron; ?>" class="res-pill<?php echo $ironClass; ?>"><?php echo $airon."/".$maxstore; ?></div></td>

			<td><img src="img/x.gif" class="r4" alt="<?php echo CROP; ?>" title="<?php echo CROP; ?>" /></td>
			<?php if($acrop > 0){ ?>
			<td><div id="l1" title="<?php echo $crop; ?>" class="res-pill<?php echo $cropClass; ?>"><?php echo $acrop."/".$maxcrop; ?></div></td>
			<?php }else{ ?>
			<td><div title="<?php echo $crop; ?>" class="res-pill"><?php echo "0/".$maxcrop; ?></div></td>
			<?php } ?>

			<td><img src="img/x.gif" class="r5" alt="<?php echo CROP_COM; ?>" title="<?php echo CROP_COM; ?>" /></td>
			<td><div class="res-pill res-consumption"><?php echo ($village->pop+$technology->getUpkeep($village->unitall,0))."/".$totalproduction; ?></div></td>
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
    padding: 0 !important;
    vertical-align: middle;
}

/* Icon cells — snug spacing */
#res td:has(img) {
    padding-inline-end: 4px !important; /* Space between icon and its pill */
}

/* Add space after each pill to separate it from the next resource icon */
#res td:has(.res-pill) {
    padding-inline-end: 14px !important; 
}

/* Resource value pills */
.res-pill {
    display: inline-block;
    background: linear-gradient(180deg, #9CCC65 0%, #7CB342 100%); /* Softer, richer green */
    border: 1px solid #558B2F;
    border-radius: 12px; /* rounder */
    padding: 2px 6px !important; /* Smaller on desktop */
    color: #fff;
    font-family: inherit;
    font-weight: 700;
    font-size: 11px; /* Normal size on desktop */
    line-height: normal;
    text-shadow: 0 1px 2px rgba(0,0,0,0.3);
    box-shadow: inset 0 1px 0 rgba(255,255,255,0.3), 0 2px 4px rgba(0,0,0,0.1);
    white-space: nowrap;
}

/* Enlarge on Mobile */
@media screen and (max-width: 768px) {
    .res-pill {
        padding: 4px 10px !important;
        font-size: 13px !important;
    }
}

/* Full storage: bright glowing green */
.res-pill.res_full {
    background: linear-gradient(180deg, #B2FF59 0%, #76FF03 50%, #64DD17 100%);
    border-color: #33691E;
    color: #000;
    text-shadow: none;
    box-shadow: inset 0 1px 0 rgba(255,255,255,0.6), 0 0 8px rgba(118,255,3,0.6);
}

/* Crop consumption: sleek slate-gray */
.res-pill.res-consumption {
    background: linear-gradient(180deg, #78909C 0%, #546E7A 100%);
    border-color: #37474F;
}

/* Reset margin for images so padding-inline-end does the work */
#res table img {
    margin: 0 !important;
    display: block;
}
</style>
<?php
}
