<?php 
$deletedArtifacts = $database->getDeletedArtifacts();
?>

<link href="../<?php echo GP_LOCATE; ?>lang/en/lang.css?f4b7d" rel="stylesheet" type="text/css">
<link href="../<?php echo GP_LOCATE; ?>lang/en/compact.css?v2" rel="stylesheet" type="text/css">

<h1><?php echo (defined('LANG') && LANG === 'ar') ? 'إدارة التحف' : 'Artifacts management'; ?></h1>
<form method="post" action="../Admin/admin.php?action=addArtifacts">
<table id="member">
  <thead>
	<tr>
		<th colspan="4"><?php echo (defined('LANG') && LANG === 'ar') ? 'إضافة تحف' : 'Add artifact(s)'; ?></th>
	</tr>
	<tr>
		<td class="ra"></td>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'النوع' : 'Type'; ?></td>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الكمية' : 'Quantity'; ?></td>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'معرف اللاعب' : 'Player id'; ?></td>
	</tr>
  </thead>
  </tbody>
	<tr>
		<td class="icon"><img id="artifactImage" class="artefact_icon_1" src="../img/x.gif"></td>
		<td>
			<select name="selectedArtifact" id="selectedArtifact" onchange="changeArtifactImage()">
				<?php 
				$artifactArrays = array_merge(Artifacts::NATARS_ARTIFACTS, Artifacts::NATARS_WW_BUILDING_PLANS);
				foreach($artifactArrays as $desc => $artifactType){
				    foreach($artifactType as $artifact){
				        echo '<option value="'.$artifact['type'].':'.$artifact['size'].':'.$desc.'">'.$artifact['name'].'</option>';
				    }
				}
				        
				?>
			</select>
		</td>
		<td><input type="number" value="1" min="1" max="999" name="artifactQuantity"></td>
		<td><input type="text" value="<?php echo Artifacts::NATARS_UID; ?>" name="playerId"></td>
	</tr>
	<tr>
		<td colspan="4"><div style="text-align: center"><button id="addArtifacts" class="trav_buttons" value="add" name="addArtifacts" onclick="this.disabled=true;this.form.submit();"> <?php echo (defined('LANG') && LANG === 'ar') ? 'إضافة' : 'Add'; ?> </button></div></td>
	</tr>
   </tbody>
</table>
</form>

<table id="member">
	<thead>
		<tr>
			<th colspan="8"><?php echo (defined('LANG') && LANG === 'ar') ? 'التحف المحذوفة' : 'Deleted artifact(s)'; ?></th>
		</tr>
		<tr>
			<td class="ra"></td>
			<td class="ra"></td>
			<td colspan="1"><?php echo (defined('LANG') && LANG === 'ar') ? 'الاسم' : 'Name'; ?></td>
			<td colspan="1"><?php echo (defined('LANG') && LANG === 'ar') ? 'المكافأة' : 'Bonus'; ?></td>
			<td colspan="1"><?php echo (defined('LANG') && LANG === 'ar') ? 'مدى التأثير' : 'Area of effect'; ?></td>
			<td colspan="1"><?php echo (defined('LANG') && LANG === 'ar') ? 'وقت الاحتلال' : 'Time of conquer'; ?></td>
			<td colspan="1"><?php echo (defined('LANG') && LANG === 'ar') ? 'المالك القديم' : 'Old owner'; ?></td>
			<td colspan="1"><?php echo (defined('LANG') && LANG === 'ar') ? 'القرية القديمة' : 'Old village'; ?></td>
		</tr>
	</thead>
	<tbody>
	<?php 
	if(empty($deletedArtifacts)){
	?>
		<tr>
			<td colspan="8"><div style="text-align: center"><?php echo NO_ARTEFACTS; ?></div></td>
		</tr>
	<?php }else{ 
	
	    foreach($deletedArtifacts as $artifact){
	        $artifactInfo = Artifacts::getArtifactInfo($artifact);
	?>
		<tr>
			<td><a href="?action=returnArtifact&artid=<?php echo $artifact['id']; ?>&del=1" title="Return to Natars">
				<img src="../../img/admin/acc.gif">
			</a></td>
			
			<td class="icon"><img class="artefact_icon_<?php echo $artifact['type']; ?>" src="../img/x.gif"></td>
			<td colspan="1"><div style="text-align: center"><?php echo $artifact['name']; ?></div></td>
			<td colspan="1"><div style="text-align: center"><?php echo $artifactInfo['bonus']; ?></div></td>
			<td colspan="1"><div style="text-align: center"><?php echo $artifactInfo['effectInfluence']; ?></div></td>
			<td colspan="1"><div style="text-align: center"><?php echo date("d.m.Y H:i:s", $artifact['conquered']); ?></div></td>
			
			<td colspan="1"><div style="text-align: center">
			<?php 
			$oldOwnerName = $database->getUserField($artifact['owner'], "username", 0);
			if($oldOwnerName != "[?]"){			
		    ?> 
		    <a href="?p=player&uid=<?php echo $artifact['owner']; ?>"><?php echo $oldOwnerName; ?></a>
		    <?php 
			}else{
			?>
			<span><font color="grey"><?php echo $oldOwnerName; ?></font></span>
			<?php }?>
			</div></td>
			
			<td colspan="1"><div style="text-align: center">
			<?php 
			$oldVillageName = $database->getVillageField($artifact['vref'], "name");
			if($oldVillageName != "[?]"){			
		    ?> 
		    <a href="?p=village&did=<?php echo $artifact['vref']; ?>"><?php echo $oldVillageName; ?></a>
		    <?php 
			}else{
			?>
			<span><font color="grey"><?php echo $oldVillageName; ?></font></span>
			<?php }?>
			</div></td>
			
			<?php } ?>
		</tr>
	<?php
    }
	?>
	</tbody>
</table><br />

<h1><?php echo (defined('LANG') && LANG === 'ar') ? 'إدارة قرى المعجزة' : 'WW villages management'; ?></h1>
<form method="post" action="../Admin/admin.php?action=addWWVillages">
<table id="member">
  <thead>
	<tr>
		<th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'إضافة قرى معجزة' : 'Add WW village(s)'; ?></th>
	</tr>
	<tr>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'عدد القرى' : 'Number of village(s)'; ?></td>
		<td><?php echo (defined('LANG') && LANG === 'ar') ? 'معرف اللاعب' : 'Player id'; ?></td>
	</tr>
  </thead>
  </tbody>
	<tr>
		<td>
			<div style="text-align: center">
				<input type="number" value="1" min="1" max="999" name="numberOfVillages">
			</div>
		</td>
		<td>
			<div style="text-align: center">
				<input type="text" value="<?php echo Artifacts::NATARS_UID; ?>" name="playerId">
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2"><div style="text-align: center"><button id="addWWVillages" class="trav_buttons" value="add" name="addWWVillages" onclick="this.disabled=true;this.form.submit();"> <?php echo (defined('LANG') && LANG === 'ar') ? 'إضافة' : 'Add'; ?> </button></div></td>
	</tr>
   </tbody>
</table>
</form>

<script type="text/javascript">
	function changeArtifactImage(){
		var selectedItem = document.getElementById("selectedArtifact").value.split(":")[0];
		
		document.getElementById("artifactImage").className = "artefact_icon_" + selectedItem;
    }
</script>