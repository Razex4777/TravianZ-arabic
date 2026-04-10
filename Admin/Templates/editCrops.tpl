<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       editCrops.tpl                                               ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
#################################################################################

$id = $_GET['did'];
$village = $database->getVillage($id);
if(isset($id))
{
	include("search2.tpl"); ?>
	<form action="../GameEngine/Admin/Mods/editCrops.php" method="POST">
		<input type="hidden" name="admid" id="admid" value="<?php echo $_SESSION['id']; ?>">
		<input type="hidden" name="id" value="<?php echo $_GET['did']; ?>" />
		<br />
		
		<p>This will convert this village into a Cropper and update all resource fields to the given levels.</p>

		<table id="member" cellpadding="1" cellspacing="1" >
			<thead>
				<tr>
					<th colspan="2">Build Cropper</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="on">Cropper Type</td>
					<td class="on">
						<select name="type" class="dropdown">
							<option value="6">15 Cropper</option>
							<option value="1">9 Cropper</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="on">Wood Level</td>
					<td class="on"><input class="fm" name="wood" value="10"></td>
				</tr>
				<tr>
					<td class="on">Clay Level</td>
					<td class="on"><input class="fm" name="clay" value="10"></td>
				</tr>
				<tr>
					<td class="on">Iron Level</td>
					<td class="on"><input class="fm" name="iron" value="10"></td>
				</tr>
				<tr>
					<td class="on">Crop Level</td>
					<td class="on"><input class="fm" name="crop" value="10"></td>
				</tr>
			</tbody>
		</table>
		<br /><br />
		<center><input type="image" src="../img/admin/b/ok1.gif" value="submit"></center>
	</form>
<?php
}
else
{
	include("404.tpl");
}
?>
