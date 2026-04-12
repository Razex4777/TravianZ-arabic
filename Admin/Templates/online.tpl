<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       online.tpl                                                  ##
##  Developed by:  Dzoki                                                       ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
##                                                                             ##
#################################################################################
?>
<?php
$active = $admin->getUserActive();
?>
<style>
.del {width:12px; height:12px; background-image: url(img/admin/icon/del.gif);}
</style>

<table id="member">
  <thead>
	<tr>
		<th colspan="6"><?php echo (defined('LANG') && LANG === 'ar') ? 'اللاعبون المتصلون' : 'Online users'; ?> (<?php echo count($active);?>)</th>
	</tr>
  </thead>
	<tr>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الاسم [صلاحيات]' : 'Name [access]'; ?></td>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الوقت' : 'Time'; ?></td>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'القبيلة' : 'Tribe'; ?></td>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'السكان' : 'Pop'; ?></td>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'القرى' : 'Villages'; ?></td>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الذهب' : 'Gold'; ?></td>
	</tr>
<?php
if($active){
for ($i = 0; $i <= count($active)-1; $i++) {
$uid = $database->getUserField($active[$i]['username'],'id',1);
$varray = $database->getProfileVillages($uid);
$totalpop = 0;
foreach($varray as $vil) {
	$totalpop += $vil['pop'];
}
		if($active[$i]['tribe'] == 1){
		$tribe = (defined('LANG') && LANG === 'ar') ? 'الرومان' : 'Roman';
		} else if($active[$i]['tribe'] == 2){
		$tribe = (defined('LANG') && LANG === 'ar') ? 'الجرمان' : 'Teuton';
		} else if($active[$i]['tribe'] == 3){
		$tribe = (defined('LANG') && LANG === 'ar') ? 'الإغريق' : 'Gaul';
		}
echo '
	<tr>
		<td><a href="?p=player&uid='.$uid.'">'.$active[$i]['username'].' ['.$active[$i]['access'].']</a></td>
		<td>'.date("d.m.y H:i:s",$active[$i]['timestamp']).'</td>
		<td>'.$tribe.'</td>
		<td>'.$totalpop.'</td>
		<td>'.count($varray).'</td>
		<td><img src="../img/admin/gold.gif" class="gold" alt="Gold" title="This user has: '.$active[$i]['gold'].' gold"/> '.$active[$i]['gold'].'</td>
	</tr>
';
}
}else{
echo '<tr><td  colspan="6" class="hab">'.((defined('LANG') && LANG === 'ar') ? 'لا يوجد لاعبون متصلون' : 'No online users').'</td></tr>';

}

?>

</table>