<?php
if(!isset($aid)) $aid = $session->alliance;

$allianceinfo = $database->getAlliance($aid);
$allianceInvitations = $database->getAliInvitations($aid);
echo "<h1>".$allianceinfo['tag']." - ".$allianceinfo['name']."</h1>";
include("alli_menu.tpl");
?>

<form method="post" action="allianz.php">
<input type="hidden" name="s" value="5">
<input type="hidden" name="o" value="4">
<input type="hidden" name="a" value="4">

<table cellpadding="1" cellspacing="1" id="invite" class="small_option"><thead>
<tr>
<th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'دعوة لاعب للانضمام إلى التحالف' : 'Invite a player into the alliance'; ?></th>
</tr>
</thead><tbody>
<tr><th><?php echo (defined('LANG') && LANG === 'ar') ? 'الاسم' : 'Name'; ?></th>
<td><input class="name text" type="text" name="a_name" maxlength="30"><span class="error"></span></td>
</tr>
</tbody></table>
<p><button value="ok" name="s1" id="btn_ok" class="trav_buttons" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'موافق' : 'OK'; ?>" onclick="this.disabled=true;this.form.submit();" /> <?php echo (defined('LANG') && LANG === 'ar') ? 'موافق' : 'Ok'; ?> </button></form> </p>

<p class="error"><?php echo $form->getError("name"); ?></p><br />
<table cellpadding="1" cellspacing="1" id="invitations" class="small_option"><thead>

<tr>

<th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'الدعوات:' : 'Invitations:'; ?></th>
</tr></thead>
<tbody>
<?php
if (count($allianceInvitations) == 0) {
	echo "<tr>";
    echo "<td class=none colspan=2>".((defined('LANG') && LANG === 'ar') ? 'لا يوجد' : 'none')."</td>";
	echo "</tr>";
    } else {
 	foreach($allianceInvitations as $invit) {
	$invited = $database->getUserField($invit['uid'],'username',0);
    echo "<tr>";
    echo "<td class=abo><a href=\"?o=4&s=5&d=".$invit['id']."\"><img src=\"gpack/travian_default/img/a/del.gif\" width=\"12\" height=\"12\" alt=\"".((defined('LANG') && LANG === 'ar') ? 'حذف' : 'Del')."\"></a></td>";
	echo "<td><a href=spieler.php?uid=".$invit['uid'].">".$invited."</td>";
    echo "</tr>";
	}
}
?>
</tbody>
</table>
