<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       message.tpl                                                 ##
##  Developed by:  Dzoki                                                       ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
##                                                                             ##
#################################################################################
$nid = isset($_GET['nid']) ? $_GET['nid'] : '';
$bid = isset($_GET['bid']) ? $_GET['bid'] : '';
?>
<style>
	.del {width:12px; height:12px; background-image: url(img/admin/icon/del.gif);}
</style>
<link href="../<?php echo GP_LOCATE; ?>lang/en/compact.css?v2" rel="stylesheet" type="text/css">
<table id="member" style="width:225px">
  <thead>
	<tr>
		<th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'الرسائل/التقارير' : 'IGM/Reports'; ?></th>
	</tr>
  </thead>
	<tr>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'معرف الرسالة' : 'IGM ID'; ?></td>
		<td><form action="" method="get"><input type="hidden" name="p" value="message"><input type="text" class="fm" name="nid" value="<?php echo $nid;?>"> <input type="image" value="submit" src="../img/admin/b/ok1.gif"></form></td>
	</tr>
	<tr>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'معرف التقرير' : 'Report ID'; ?></td>
		<td><form action="" method="get"><input type="hidden" name="p" value="message"><input type="text" class="fm" name="bid" value="<?php echo $bid;?>"> <input type="image" value="submit" src="../img/admin/b/ok1.gif"></form></td>
	</tr>
</table>
<br>

<?php
if(isset($_GET['nid']) && is_numeric($_GET['nid'])) include('msg.tpl');
elseif(isset($_GET['bid']) && is_numeric($_GET['bid'])) include('report.tpl');
?>

