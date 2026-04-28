<?php
$noticeClass = (defined('LANG') && LANG === 'ar') ? 
	["تقرير استكشاف", "فوز كمهاجم بدون خسائر", "فوز كمهاجم مع خسائر", "خسارة كمهاجم مع خسائر", "فوز كمدافع بدون خسائر", "فوز كمدافع مع خسائر", "خسارة كمدافع مع خسائر", "خسارة كمدافع بدون خسائر", "وصلت التعزيزات", "",
		"تم تسليم الخشب", "تم تسليم الطين", "تم تسليم الحديد", "تم تسليم القمح", "", "فوز كمدافع بدون خسائر", "فوز كمدافع مع خسائر", "خسارة كمدافع مع خسائر", "فوز في الاستكشاف كمهاجم", "خسارة في الاستكشاف كمهاجم", "فوز في الاستكشاف كمدافع", "خسارة في الاستكشاف كمدافع",
		"تقرير استكشاف"]
	:
	["Scout Report", "Won as attacker without losses", "Won as attacker with losses", "Lost as attacker with losses", "Won as defender without losses", "Won as defender with losses", "Lost as defender with losses", "Lost as defender without losses", "Reinforcement arrived", "",
		"Wood Delivered", "Clay Delivered", "Iron Delivered", "Crop Delivered", "", "Won as defender without losses", "Won as defender with losses", "Lost as defender with losses", "Won scouting as attacker", "Lost scouting as attacker", "Won scouting as defender", "Lost scouting as defender",
		"Scout Report"];
?>
<form method="post" action="berichte.php" name="msg">
<table cellpadding="1" cellspacing="1" id="overview"
	class="row_table_data">
	<thead>
		<tr>
			<th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'الموضوع:' : 'Subject:'; ?></th>
			<th class="sent">
<a href="berichte.php?o=1<?php echo (isset($_GET['t']) ? '&amp;t='.$_GET['t'] : ''); ?>"><?php echo (defined('LANG') && LANG === 'ar') ? 'الإرسال' : 'Sent'; ?></a></th>
		</tr>
	</thead><tfoot>
		<tr><th><?php
		$MyGold = mysqli_query($database->dblink,"SELECT plus FROM ".TB_PREFIX."users WHERE `id`='".(int) $session->uid."'") or die(mysqli_error($database->dblink));
		$golds = mysqli_fetch_array($MyGold);
		$date2=strtotime("NOW");
		if ($golds['plus'] <= $date2) { ?>
		<?php } else { ?>
		<input class="check" type="checkbox" id="s10" name="s10" onclick="Allmsg(this.form);" />
		<?php } ?></th>
			<th class="buttons">
            <?php if (defined('LANG') && LANG === 'ar') { ?>
                <input name="del" type="submit" value="حذف" style="font-weight: bold; background: #f4f4f4; border: 1px solid #71D000; border-radius: 9px; padding: 2px 15px; cursor: pointer; color: #333; font-size: 11px;" />
            <?php } else { ?>
                <input name="del" type="image" id="btn_delete" class="dynamic_img" src="img/x.gif" value="delete" alt="delete" />
            <?php } ?>
            <?php if($session->plus) {
			if(isset($_GET['t']) && $_GET['t'] == 5) {
                if (defined('LANG') && LANG === 'ar') {
                    echo "<input name=\"start\" type=\"submit\" value=\"رجوع\" style=\"font-weight: bold; background: #f4f4f4; border: 1px solid #71D000; border-radius: 9px; padding: 2px 15px; cursor: pointer; color: #333; font-size: 11px; margin-right: 5px;\" />";
                } else {
				    echo "<input name=\"start\" type=\"image\" value=\"back\" alt=\"back\" id=\"btn_back\" class=\"dynamic_img\" src=\"img/x.gif\" />";
                }
			}
			else {
                if (defined('LANG') && LANG === 'ar') {
                    echo "<input name=\"archive\" type=\"submit\" value=\"أرشيف\" style=\"font-weight: bold; background: #f4f4f4; border: 1px solid #71D000; border-radius: 9px; padding: 2px 15px; cursor: pointer; color: #333; font-size: 11px; margin-right: 5px;\" />";
                } else {
				    echo "<input name=\"archive\" type=\"image\" value=\"Archive\" alt=\"Archive\" id=\"btn_archiv\" class=\"dynamic_img\" src=\"img/x.gif\" />";
                }
			}
			}?>
            </th>
						<th class=navi>
                        <?php
    if(!isset($_GET['s']) && count($message->noticearray) < 10) {
    echo "&laquo;&raquo;";
    }
    else if (!isset($_GET['s']) && count($message->noticearray) > 10) {
    echo "&laquo;<a href=\"?".(!empty($_GET['t']) ? 't='.$_GET['t'].'&amp;' : '')."s=10&amp;o=".(!empty($_GET['o']) ? $_GET['o'] : 0)."\">&raquo;</a>";
    }
    else if(isset($_GET['s']) && count($message->noticearray) > $_GET['s']) {
    	if(count($message->noticearray) > ($_GET['s']+10) && $_GET['s']-10 < count($message->noticearray) && $_GET['s'] != 0) {
         echo "<a href=\"?".(!empty($_GET['t']) ? 't='.$_GET['t'].'&amp;' : '')."s=".($_GET['s']-10)."&o=".(!empty($_GET['o']) ? $_GET['o'] : 0)."\">&laquo;</a><a href=\"?".(!empty($_GET['t']) ? 't='.$_GET['t'].'&amp;' : '')."s=".($_GET['s']+10)."&o=".(!empty($_GET['o']) ? $_GET['o'] : 0)."\">&raquo;</a>";
         }
         else if(count($message->noticearray) > $_GET['s']+10) {
         	echo "&laquo;<a href=\"?".(!empty($_GET['t']) ? 't='.$_GET['t'].'&amp;' : '')."s=".($_GET['s']+10)."&o=".(!empty($_GET['o']) ? $_GET['o'] : 0)."\">&raquo;</a>";
         }
        else if (count($message->noticearray) > 10) {
        echo "<a href=\"?".(!empty($_GET['t']) ? 't='.$_GET['t'].'&amp;' : '')."s=".($_GET['s']-10)."&o=".(!empty($_GET['o']) ? $_GET['o'] : 0)."\">&laquo;</a>&raquo;";
        }
    }
    ?>
     </th>
		</tr>
	</tfoot>
	<tbody>
<?php

if(isset($_GET['s'])) $s = $_GET['s'];
else $s = 0;

$name = 1;
$count = 0;
for($i = (1 + $s); $i <= (10 + $s); $i++){
	if(count($message->noticearray) >= $i){
		echo "<tr><td class=\"sel\"><input class=\"check\" type=\"checkbox\" name=\"n" . $name . "\" value=\"" . $message->noticearray[$i - 1]['id'] . "\" /></td>
		<td class=\"sub\">";
		$type = (isset($_GET['t']) && $_GET['t'] == 5) ? $message->noticearray[$i - 1]['archive'] : $message->noticearray[$i - 1]['ntype'];
		if($type == 23) $type = 22;
		if($type >= 15 && $type <= 17){
			$type -= 11;
			echo "<img src=\"img/x.gif\" class=\"iReport iReport$type\" alt=\"" . $noticeClass[$type] . "\" title=\"" . $noticeClass[$type] . "\" />";
		}else if($type >= 18 && $type <= 22){
			echo "<img src=\"gpack/travian_default/img/scouts/$type.gif\" alt=\"" . $noticeClass[$type] . "\" title=\"" . $noticeClass[$type] . "\" />";
		}else{
			echo "<img src=\"img/x.gif\" class=\"iReport iReport$type\" alt=\"" . $noticeClass[$type] . "\" title=\"" . $noticeClass[$type] . "\" />";
		}
		$topic = $message->noticearray[$i - 1]['topic'];
		if(defined('LANG') && LANG === 'ar') {
			$topic = str_replace(' attacks ', ' يهاجم ', $topic);
			$topic = str_replace('Unoccupied Oasis', UNOCCUOASIS, $topic);
			$topic = str_replace('Occupied Oasis', OCCUOASIS, $topic);
		}
		echo "<div><a href=\"berichte.php?id=" . $message->noticearray[$i - 1]['id'] . "\">" . $topic . "</a> ";
		if($message->noticearray[$i - 1]['viewed'] == 0){
			echo "(" . ((defined('LANG') && LANG === 'ar') ? 'جديد' : 'new') . ")";
		}
		$date = $generator->procMtime($message->noticearray[$i - 1]['time']);
		echo "</div></td><td class=\"dat\">" . $date[0] . " " . $date[1] . "</td></tr>";
	}
	$name++;
}
if(count($message->noticearray) == 0) echo "<td colspan=\"3\" class=\"none\">" . ((defined('LANG') && LANG === 'ar') ? 'لا توجد تقارير متاحة.' : 'There are no reports available.') . "</td></tr>";
    ?>
</tbody>

</table>

