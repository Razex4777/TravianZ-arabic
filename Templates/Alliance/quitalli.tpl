<?php
if(!isset($aid)) $aid = $session->alliance;

$allianceinfo = $database->getAlliance($aid);
$isOwner      = ($aid && $database->isAllianceOwner($session->uid) == $aid);

if ($isOwner) {
	$membersCount = $database->countAllianceMembers($aid);
}

echo "<h1>".$allianceinfo['tag']." - ".$allianceinfo['name']."</h1>";
include("alli_menu.tpl");
?>
<form method="post" action="allianz.php">
<input type="hidden" name="a" value="11">
<input type="hidden" name="o" value="11">
<input type="hidden" name="s" value="5">

<table cellpadding="1" cellspacing="1" id="quit" class="small_option"><thead>
<tr>
<th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'مغادرة التحالف' : 'Quit alliance'; ?></th>
</tr>
</thead><tbody>
<?php
	if ($isOwner && $membersCount > 1) {
?>
<tr>
	<td colspan="2" class="info">
		<?php echo (defined('LANG') && LANG === 'ar') ? 'بما أنك مؤسس التحالف، يجب عليك اختيار مؤسس بديل قبل مغادرتك.' : 'Because you are the alliance founder, you need to select a replacement founder before you leave.'; ?>
	</td>
</tr>
<tr>
	<th>
		<?php echo (defined('LANG') && LANG === 'ar') ? 'المؤسس الجديد:' : 'new&nbsp;founder:'; ?>
		</th>
	<td>
		<?php
			$memberlist = $database->getAllMember($aid);
		?>
		<select name="new_founder" class="name dropdown">
		<?php
			$canQuit = false;
			$minEmbassyLevel = $database->getMinEmbassyLevel( $database->countAllianceMembers($session->alliance) );
			if ($minEmbassyLevel < 3) {
				$minEmbassyLevel = 3;
			}

           	foreach($memberlist as $member) {
           		if (($member['id'] != $session->uid) && ($database->getSingleFieldTypeCount($member['id'], 18, '>=', $minEmbassyLevel) >= 1)) {
               		echo "<option value=\"".$member['id']."\">".$member['username']."</option>";
               		$canQuit = true;
               	}
            }

            if (!$canQuit) {
            	echo "<option value=\"-1\">".((defined('LANG') && LANG === 'ar') ? 'لا يوجد مرشحون!' : 'no candidates!')."</option>";
            }
        ?>
            </select>
	</td>
</tr>
<?php
	} else {
		$canQuit = true;
	}
?>
<tr>
	<td colspan="2" class="info">
		<br /><?php echo (defined('LANG') && LANG === 'ar') ? 'لمغادرة التحالف يجب عليك إدخال كلمة المرور الخاصة بك مرة أخرى لأسباب أمنية.' : 'In order to quit the alliance you have to enter your password again for safety reasons.'; ?>
	</td>
</tr>
<tr>
	<th>
		<?php echo (defined('LANG') && LANG === 'ar') ? 'كلمة المرور:' : 'password:'; ?>
		</th>
	<td>
		<input class="pass text" type="password" name="pw" maxlength="20">
		<span class="error3"><?php echo $form->getError("pw"); ?></span>
	</td>
</tr>
</tbody>
</table>

<?php
	if (!$canQuit) {
?>
	<span style="color: red">
		<br />
		<?php echo (defined('LANG') && LANG === 'ar') ? 'للأسف، لا يوجد أعضاء في التحالف يمتلكون سفارة بالمستوى '.$minEmbassyLevel.' أو أكثر. في هذه الحالة، لن تتمكن من إعادة تعيين دور المؤسس. يمكنك لا تزال <a href="allianz.php?s=5">طرد جميع الأعضاء</a> ومغادرة التحالف بعد ذلك، إذا كنت ترغب.' : 'Unfortunately, there are no members of the alliance with Embassy at level '.$minEmbassyLevel.' or more. In this case, you will not be able to reassign the founder role. You can still <a href="allianz.php?s=5">kick all members</a> and quit the alliance afterwards, if you wish.'; ?>
	</span>
	<?php
        }
    ?>

<p><input type="image" value="ok" name="s1" id="btn_ok" class="dynamic_img" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'موافق' : 'OK'; ?>" /></form></p>
<p class="error"><?php echo $form->getError("founder"); ?></p>
