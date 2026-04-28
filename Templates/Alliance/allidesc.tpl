<?php
if(!isset($aid)) $aid = $session->alliance;

$varmedal = $database->getProfileMedalAlly($aid);
$allianceinfo = $database->getAlliance($aid);
$memberlist = $database->getAllMember($aid);
$totalpop = 0;
$memberIDs = [];

foreach($memberlist as $member) {
    $memberIDs[] = $member['id'];
}
$data = $database->getVSumField($memberIDs,"pop");

if (count($data)) {
    foreach ($data as $row) {
        $totalpop += $row['Total'];
    }
}

echo "<h1>".$allianceinfo['tag']." - ".$allianceinfo['name']."</h1>";
include("alli_menu.tpl");
?>
<table cellpadding="1" cellspacing="1" id="edit"><thead>
<form method="post" action="allianz.php">
<input type="hidden" name="a" value="3">
<input type="hidden" name="o" value="3">
<input type="hidden" name="s" value="5">
<tr>
<th colspan="3"><?php echo (defined('LANG') && LANG === 'ar') ? 'التحالف' : 'Alliance'; ?></th>
</tr><tr>
<td colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'التفاصيل' : 'Details'; ?></td>
<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الوصف' : 'Description'; ?></td>
</tr></thead>
<tbody>

<tr><td colspan="2"></td><td class="empty"></td></tr>

<tr>
<th><?php echo (defined('LANG') && LANG === 'ar') ? 'الرمز' : 'Tag'; ?></td><td class="s7"><?php echo $allianceinfo['tag']; ?></th>
<td rowspan="8" class="desc1"><textarea tabindex="1" name="be1"><?php echo isset($_POST['be1']) ? $_POST['be1'] : stripslashes($allianceinfo['desc']); ?></textarea></td>
</tr>

<tr>
<th><?php echo (defined('LANG') && LANG === 'ar') ? 'الاسم' : 'Name'; ?></th><td><?php echo $allianceinfo['name']; ?></td>
</tr>

<tr><td colspan="2" class="empty"></td></tr>

<tr>
<th><?php echo (defined('LANG') && LANG === 'ar') ? 'الرتبة' : 'Rank'; ?></th><td><?php echo $ranking->getAllianceRank($aid); ?>.</td>
</tr>

<tr>
<th><?php echo (defined('LANG') && LANG === 'ar') ? 'النقاط' : 'Points'; ?></th><td><?php echo $totalpop; ?></td>
</tr>

<tr>
<th><?php echo (defined('LANG') && LANG === 'ar') ? 'الأعضاء' : 'Members'; ?></th><td><?php echo count($memberlist); ?></td>
</tr>

<tr><td colspan="2" class="empty"></td></tr>

<tr><td colspan="2" class="desc2"><textarea tabindex="2" name="be2"><?php echo isset($_POST['be2']) ? $_POST['be2'] : stripslashes($allianceinfo['notice']); ?></textarea></td></tr>
    <p>
        <table cellspacing="1" cellpadding="2" class="tbg">
        <tr><td class="rbg" colspan="4"><?php echo (defined('LANG') && LANG === 'ar') ? 'الأوسمة' : 'Medals'; ?></td></tr>
        <tr>
            <td><?php echo (defined('LANG') && LANG === 'ar') ? 'الفئة' : 'Category'; ?></td>
            <td><?php echo (defined('LANG') && LANG === 'ar') ? 'الرتبة' : 'Rank'; ?></td>
            <td><?php echo (defined('LANG') && LANG === 'ar') ? 'الأسبوع' : 'Week'; ?></td>
            <td><?php echo (defined('LANG') && LANG === 'ar') ? 'كود BB' : 'BB-Code'; ?></td>
        </tr>
                <?php
/******************************
INDELING CATEGORIEEN:
===============================
== 1. Aanvallers top 10      ==
== 2. Defence top 10         ==
== 3. Klimmers top 10        ==
== 4. Overvallers top 10     ==
== 5. In att en def tegelijk ==
== 6. in top 3 - aanval      ==
== 7. in top 3 - verdediging ==
== 8. in top 3 - klimmers    ==
== 9. in top 3 - overval     ==
******************************/


    foreach($varmedal as $medal) {
    $titel=(defined('LANG') && LANG === 'ar') ? 'مكافأة' : 'Bonus';
    switch ($medal['categorie']) {
    case "1":
        $titel=(defined('LANG') && LANG === 'ar') ? 'مهاجم الأسبوع' : 'Attacker of the Week';
        break;
    case "2":
        $titel=(defined('LANG') && LANG === 'ar') ? 'مدافع الأسبوع' : 'Defender of the Week';
        break;
    case "3":
        $titel=(defined('LANG') && LANG === 'ar') ? 'متسلق الأسبوع' : 'Climber of the week';
        break;
    case "4":
        $titel=(defined('LANG') && LANG === 'ar') ? 'ناهب الأسبوع' : 'Robber of the week';
        break;
    case "5":
        $titel=(defined('LANG') && LANG === 'ar') ? 'أفضل 10 من المهاجمين والمدافعين' : 'Top 10 of both attackers and defenders';
        break;
    case "6":
        $titel=(defined('LANG') && LANG === 'ar') ? 'أفضل 3 مهاجمين للأسبوع '.$medal['points'].' على التوالي' : 'Top 3 of Attackers of week '.$medal['points'].' in a row';
        break;
    case "7":
        $titel=(defined('LANG') && LANG === 'ar') ? 'أفضل 3 مدافعين للأسبوع '.$medal['points'].' على التوالي' : 'Top 3 of Defenders of week '.$medal['points'].' in a row';
        break;
    case "8":
        $titel=(defined('LANG') && LANG === 'ar') ? 'أفضل 3 متسلقين سكان للأسبوع '.$medal['points'].' على التوالي' : 'Top 3 of Pop climbers of week '.$medal['points'].' in a row';
        break;
    case "9":
        $titel=(defined('LANG') && LANG === 'ar') ? 'أفضل 3 ناهبين للأسبوع '.$medal['points'].' على التوالي' : 'Top 3 of Robbers of week '.$medal['points'].' in a row';
        break;
    case "10":
        $titel=(defined('LANG') && LANG === 'ar') ? 'متسلق الرتب للأسبوع' : 'Rank Climber of the week';
        break;
    case "11":
        $titel=(defined('LANG') && LANG === 'ar') ? 'أفضل 3 متسلقين رتب للأسبوع '.$medal['points'].' على التوالي' : 'Top 3 of Rank climbers of week '.$medal['points'].' in a row';
        break;
    case "12":
        $titel=(defined('LANG') && LANG === 'ar') ? 'أفضل 10 مهاجمين رتب للأسبوع '.$medal['points'].' على التوالي' : 'Top 10 of Rank Attackers of week '.$medal['points'].' in a row';
        break;
    }
                 echo"<tr>
                   <td> ".$titel."</td>
                   <td>".$medal['plaats']."</td>
                   <td>".$medal['week']."</td>
                   <td>[#".$medal['id']."]</td>
                  </tr>";
                 } ?>
                 </table></p>
</table>

<p class="btn"><input tabindex="3" type="image" value="" name="s1" id="btn_save" class="dynamic_img" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'حفظ' : 'save'; ?>" /></p></form>
