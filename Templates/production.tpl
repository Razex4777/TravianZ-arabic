<?php 
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       production.tpl                                              ##
##  Developed by:  Dzoki                                                       ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
##                                                                             ##
#################################################################################
?>
<table id="production" cellpadding="1" cellspacing="1">
	<thead><tr>
			<th colspan="2"><?php echo PRODUCTION; ?></th>
	</tr></thead><tbody>	
	<tr>
		<td class="ico"><img class="r1" src="img/x.gif" alt="<?php echo LUMBER; ?>" title="<?php echo LUMBER; ?>" /></td>
		<td class="num"><?php echo number_format($village->getProd("wood")); ?></td>
	</tr>
		
	<tr>
		<td class="ico"><img class="r2" src="img/x.gif" alt="<?php echo CLAY; ?>" title="<?php echo CLAY; ?>" /></td>
		<td class="num"><?php echo number_format($village->getProd("clay")); ?></td>
	</tr>
		
	<tr>
		<td class="ico"><img class="r3" src="img/x.gif" alt="<?php echo IRON; ?>" title="<?php echo IRON; ?>" /></td>
		<td class="num"><?php echo number_format($village->getProd("iron")); ?></td>
	</tr>
		
	<tr>
		<td class="ico"><img class="r4" src="img/x.gif" alt="<?php echo CROP; ?>" title="<?php echo CROP; ?>" /></td>
		<td class="num"><?php echo number_format($village->getProd("crop")); ?></td>
	</tr>
		</tbody>	
</table>