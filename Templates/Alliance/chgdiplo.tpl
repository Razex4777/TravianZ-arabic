<?php

/*
|--------------------------------------------------------------------------
|   PLEASE DO NOT REMOVE THIS COPYRIGHT NOTICE!
|--------------------------------------------------------------------------
|
|   Developed by:   Dzoki < dzoki.travian@gmail.com >
|
|   This script is property of TravianX Project. You are allowed to change
|   its source and release it, but you have no rights to remove copyright
|   notices.
|
|   TravianX All rights reserved
|
*/


    if(!isset($aid)) $aid = $session->alliance;

    $allianceinfo = $database->getAlliance($aid);
    echo "<h1>".$allianceinfo['tag']." - ".$allianceinfo['name']."</h1>";
    include("alli_menu.tpl");
?>
    <form method="post" action="allianz.php">
        <input type="hidden" name="a" value="6"> <input type="hidden" name="o" value="6"> <input type="hidden" name="s" value="5">

        <table cellpadding="1" cellspacing="1" id="diplomacy" class="dipl">
            <thead>
                <tr>
                    <th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'دبلوماسية التحالف' : 'Alliance diplomacy'; ?></th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <th><?php echo (defined('LANG') && LANG === 'ar') ? 'التحالف' : 'Alliance'; ?></th>

                    <td><input class="ally text" type="text" name="a_name" maxlength="15"></td>
                </tr>

                <tr>
                    <td colspan="2" class="empty"></td>
                </tr>

                <tr>
                    <td colspan="2"><label><input class="radio" type="radio" name="dipl" value="1"> <?php echo (defined('LANG') && LANG === 'ar') ? 'عرض حلف' : 'offer a confederation'; ?></label></td>
                </tr>

                <tr>
                    <td colspan="2"><label><input class="radio" type="radio" name="dipl" value="2"> <?php echo (defined('LANG') && LANG === 'ar') ? 'عرض اتفاقية عدم اعتداء' : 'offer non-aggression pact'; ?></label></td>
                </tr>

                <tr>
                    <td colspan="2"><label><input class="radio" type="radio" name="dipl" value="3"> <?php echo (defined('LANG') && LANG === 'ar') ? 'إعلان حرب' : 'declare war'; ?></label></td>
                </tr>
            </tbody>
        </table>

        <table cellpadding="1" cellspacing="1" id="hint" class="infos">
            <thead>
                <tr>
                    <th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'تنبيه' : 'Hint'; ?></th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'من الآداب الدبلوماسية التحدث إلى تحالف آخر والتفاوض قبل إرسال عرض لاتفاقية عدم اعتداء أو حلف.' : "It's part of diplomatic etiquette to talk to another alliance and negotiate before sending an offer for a non-aggression pact or a confederation."; ?></td>
                </tr>
            </tbody>
        </table>

        <div id="box">
            <p><input type="image" value="ok" name="s1" id="btn_ok" class="dynamic_img" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'موافق' : 'OK'; ?>"></p>

            <p class="error"><?php echo $form->getError("name"); ?></p>
        </div>
    </form>

    <div class="clear"></div>

    <table cellpadding="1" cellspacing="1" id="own" class="dipl">
        <thead>
            <tr>
                <th colspan="3"><?php echo (defined('LANG') && LANG === 'ar') ? 'العروض المرسلة' : 'Own offers'; ?></th>
            </tr>
        </thead>

        <tbody>
        <tr>
        <?php
        $alliance = $session->alliance;

        if(count($database->diplomacyOwnOffers($alliance))){
            foreach($database->diplomacyOwnOffers($alliance) as $row){
                echo '<tr><td width="18"><form method="post" action="allianz.php"><input type="hidden" name="o" value="101"><input type="hidden" name="id" value="'.$row['id'].'"><input type="image" class="cancel" src="img/x.gif" title="'.((defined('LANG') && LANG === 'ar') ? 'إلغاء' : 'Cancel').'" /></form></td><td><a href="allianz.php?aid='.$row['alli2'].'"><center>'.$database->getAllianceName($row['alli2']).'</a></center></td><td width="80"><center>'.([(defined('LANG') && LANG === 'ar') ? 'حلف' : 'Conf', (defined('LANG') && LANG === 'ar') ? 'اتفاقية عدم اعتداء' : 'Nap', (defined('LANG') && LANG === 'ar') ? 'حرب' : 'War'])[$row['type']-1].'</center></td></tr>';
            }
        }
        else echo '<tr><td colspan="3" class="none">'.((defined('LANG') && LANG === 'ar') ? 'لا يوجد' : 'none').'</td></tr>';
        ?>
            </tr>
        </tbody>
    </table>

    <table cellpadding="1" cellspacing="1" id="tip" class="infos">
        <thead>
            <tr>
                <th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'نصيحة' : 'Tip'; ?></th>
            </tr>
        </thead>

        <tbody>
            <tr>
                <td colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'إذا كنت تريد رؤية العلاقات في وصف التحالف تلقائياً، اكتب <span class="e">[diplomatie]</span> في الوصف، <span class="e">[ally]</span>، <span class="e">[nap]</span> و <span class="e">[war]</span> ممكنة أيضاً.' : 'If you want to see connections in the alliance description automatically, type <span class="e">[diplomatie]</span> into the description, <span class="e">[ally]</span>, <span class="e">[nap]</span> and <span class="e">[war]</span> are also possible.'; ?></td>
            </tr>
        </tbody>
    </table>

    <table cellpadding="1" cellspacing="1" id="foreign" class="dipl">
        <thead>
            <tr>
                <th colspan="4"><?php echo (defined('LANG') && LANG === 'ar') ? 'العروض الواردة' : 'Foreign offers'; ?></th>
            </tr>
        </thead>

        <tbody>
        <?php
        $alliance = $session->alliance;
        if(($dInvites = $database->diplomacyInviteCheck($alliance)) && count($dInvites)){
            foreach($dInvites as $row){
                echo '<tr><td width="18"><form method="post" action="allianz.php"><input type="hidden" name="o" value="102"><input type="hidden" name="id" value="'.$row['id'].'"><input type="image" class="cancel" src="img/x.gif" title="'.((defined('LANG') && LANG === 'ar') ? 'إلغاء' : 'Cancel').'" /></td></form><form method="post" action="allianz.php"><td width="18"><input type="hidden" name="o" value="103"><input type="hidden" name="id" value="'.$row['id'].'"><input type="image" class="accept" src="img/x.gif" title="'.((defined('LANG') && LANG === 'ar') ? 'قبول' : 'Accept').'" /></td></form><td><a href="allianz.php?aid='.$row['alli1'].'"><center>'.$database->getAllianceName($row['alli1']).'</a></center></td><td width="80"><center>'.([(defined('LANG') && LANG === 'ar') ? 'حلف' : 'Conf', (defined('LANG') && LANG === 'ar') ? 'اتفاقية عدم اعتداء' : 'Nap', (defined('LANG') && LANG === 'ar') ? 'حرب' : 'War'])[$row['type']-1].'</center></td></tr>';
            }
        }
        else echo '<tr><td colspan="3" class="none">'.((defined('LANG') && LANG === 'ar') ? 'لا يوجد' : 'none').'</td></tr>';
        ?>
        </tbody>
    </table>

    <table cellpadding="1" cellspacing="1" id="existing" class="dipl">
        <thead>
            <tr>
                <th colspan="3"><?php echo (defined('LANG') && LANG === 'ar') ? 'العلاقات القائمة' : 'Existing relationships'; ?></th>
            </tr>
        </thead>

        <tbody>
		<?php
        $alliance = $session->alliance;

        if(($rels = $database->diplomacyExistingRelationships($alliance)) && count($rels)){
            foreach($rels as $row){
                echo '<tr><td width="18"><form method="post" action="allianz.php"><input type="hidden" name="o" value="104"><input type="hidden" name="id" value="'.$row['id'].'"><input type="image" class="cancel" src="img/x.gif" title="'.((defined('LANG') && LANG === 'ar') ? 'إلغاء' : 'Cancel').'" /></form></td><td><a href="allianz.php?aid='.($row['alli1'] == $session->alliance ? $row['alli2'] : $row['alli1']).'"><center>'.$database->getAllianceName(($row['alli1'] == $session->alliance ? $row['alli2'] : $row['alli1'])).'</a></center></td><td width="80"><center>'.([(defined('LANG') && LANG === 'ar') ? 'حلف' : 'Conf', (defined('LANG') && LANG === 'ar') ? 'اتفاقية عدم اعتداء' : 'Nap', (defined('LANG') && LANG === 'ar') ? 'حرب' : 'War'])[$row['type']-1].'</center></td></tr>';
            }
        }
        else echo '<tr><td colspan="3" class="none">'.((defined('LANG') && LANG === 'ar') ? 'لا يوجد' : 'none').'</td></tr>';
        ?>
        </tbody>
    </table>
