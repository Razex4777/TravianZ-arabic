<?php
//TODO: Reduce this file by a lot, by using arrays
// Generate CSRF token for forms on this page
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}
$MyGold = mysqli_query($database->dblink, "SELECT * FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
$golds = mysqli_fetch_array($MyGold);

include ("Templates/Plus/pmenu.tpl");

$MyGold = mysqli_query($database->dblink, "SELECT * FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
$golds = mysqli_fetch_array($MyGold);

$today = date("mdHi");

if (mysqli_num_rows($MyGold)) {
    if ($session->gold == 0)
        echo "<p>".((defined('LANG') && LANG === 'ar') ? 'لا تملك ذهباً حالياً.' : 'You currently don\'t own gold.')."</p>";
    else
        echo "<p>".((defined('LANG') && LANG === 'ar') ? 'لديك حالياً <b> '.$session->gold.' </b> ذهب' : 'You currently have <b> '.$session->gold.' </b>  gold')."</p>";
}

?>
<table class="plusFunctions" cellpadding="1" cellspacing="1">
	<thead>
		<tr>
			<th colspan="5"><?php echo (defined('LANG') && LANG === 'ar') ? 'خصائص بلس' : 'Plus function'; ?></th>
		</tr>
		<tr>
			<td></td>

			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الوصف' : 'Description'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'المدة' : 'Duration'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الذهب' : 'Gold'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الإجراء' : 'Action'; ?></td>
		</tr>
	</thead>
	<tbody>

		<tr>
			<td class="man"><a href="#" onClick="return Popup(0,6);"><img
					class="help" src="img/x.gif" alt="" title="" /></a></td>
			<td class="desc"><b><?php echo (defined('LANG') && LANG === 'ar') ? 'حساب <font color="#71D000">ب</font><font color="#FF6F0F">ل</font><font color="#71D000">ا</font><font color="#FF6F0F">س</font>' : '<font color="#71D000">P</font><font color="#FF6F0F">l</font><font color="#71D000">u</font><font color="#FF6F0F">s</font> Account'; ?></b><br /> <span class="run">
<?php
$datetimep = $golds['plus'];
$datetime1 = $golds['b1'];
$datetime2 = $golds['b2'];
$datetime3 = $golds['b3'];
$datetime4 = $golds['b4'];
$datetimeap = $golds['ap'];
$datetimedp = $golds['dp'];

// Retrieve the current date/time
$date2 = strtotime("NOW");

function formatRemainingTime($endTimestamp, $nowTimestamp) {
    $remaining = (int)$endTimestamp - (int)$nowTimestamp;
    if ($remaining <= 0) {
        return '';
    }

    $days = intdiv($remaining, 86400);
    $remaining %= 86400;
    $hours = intdiv($remaining, 3600);
    $remaining %= 3600;
    $mins = intdiv($remaining, 60);
    $secs = $remaining % 60;

    if(defined('LANG') && LANG === 'ar') {
        return 'المتبقي: <b>'.$days.'</b> أيام <b>'.$hours.'</b> ساعات <b>'.$mins.'</b> دقائق <b>'.$secs.'</b> ثواني (حتى '.date('H:i:s', (int)$endTimestamp).')';
    }
    return 'Remaining: <b>'.$days.'</b> days <b>'.$hours.'</b> hours <b>'.$mins.'</b> mins <b>'.$secs.'</b> secs (until '.date('H:i:s', (int)$endTimestamp).')';
}

if ($datetimep == 0) echo ((defined('LANG') && LANG === 'ar') ? 'احصل على بلس' : 'get PLUS')."<br>";
else 
{
    if ($datetimep <= $date2) {
        print ((defined('LANG') && LANG === 'ar') ? 'انتهت ميزة بلس الخاصة بك.' : 'Your PLUS advantage has ended.')."<br>";
        mysqli_query($database->dblink, "UPDATE " . TB_PREFIX . "users set plus = '0' where `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
    } else {
        echo "<font color='#B3B3B3' size='1'>" . formatRemainingTime($datetimep, $date2) . "</font>";
    }
}
    ?>
    </span></td>
			<td class="dur"><?php
    
if (PLUS_TIME >= 86400) {
        echo '' . (PLUS_TIME / 86400) . ((defined('LANG') && LANG === 'ar') ? ' أيام' : ' Days');
    } else if (PLUS_TIME < 86400) {
        echo '' . (PLUS_TIME / 3600) . ((defined('LANG') && LANG === 'ar') ? ' ساعات' : ' Hours');
    }
    ?>
            </td>
			<td class="cost"><img src="img/x.gif" class="gold" alt="Gold"
				title="Gold" alt="Gold" title="Gold" />20</td>
			<td class="act">

<?php
    $MyGold = mysqli_query($database->dblink, "SELECT * FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
    $golds = mysqli_fetch_array($MyGold);
    
if ($session->access != BANNED) {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 19 && $datetimep < $date2) {
            echo '
                <a href="plus.php?id=8"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 19 && $datetimep > $date2) {
            echo '
                <a href="plus.php?id=8"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
} else {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 19 && $datetimep < $date2) {
            echo '<a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 19 && $datetimep > $date2) {
            echo '<a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="banned.php"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
}
?>
    </span></a>
			</td>
		</tr>

		<tr>
			<td colspan="5" class="empty"></td>

		</tr>
		<tr>
			<td class="man"><a href="#" onClick="return Popup(1,6);"><img
					class="help" src="img/x.gif" alt="" title="" /></a></td>
			<td class="desc">+<b>25</b>% <img class="r1" src="img/x.gif"
				alt="Lumber" title="Lumber" /> <?php echo (defined('LANG') && LANG === 'ar') ? 'الإنتاج: الخشب' : 'Production: Lumber'; ?><br /> <span
				class="run">
<?php

$tl_b1 = $golds['b1'];
if ($tl_b1 >= $date2) {
    echo "<font color='#B3B3B3' size='1'>" . formatRemainingTime($tl_b1, $date2) . "</font> ";
}
?>
&nbsp;    </span>

			</td>
			<td class="dur"><?php

if (PLUS_PRODUCTION >= 86400) {
    echo '' . (PLUS_PRODUCTION / 86400) . ((defined('LANG') && LANG === 'ar') ? ' أيام' : ' Days');
} else if (PLUS_PRODUCTION < 86400) {
    echo '' . (PLUS_PRODUCTION / 3600) . ((defined('LANG') && LANG === 'ar') ? ' ساعات' : ' Hours');
}
?></td>
			<td class="cost"><img src="img/x.gif" class="gold" alt="Gold"
				title="Gold" />5</td>
			<td class="act"><span class="none">

<?php
if ($session->access != BANNED) {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 4 && $tl_b1 < $date2) {
            echo '<a href="plus.php?id=9"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 4 && $datetime1 > $date2) {
            echo '        <a href="plus.php?id=9"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
} else {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 4 && $tl_b1 < $date2) {
            echo '<a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 4 && $datetime1 > $date2) {
            echo '        <a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="banned.php"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
}
?>
   </span></a></td>
		</tr>

		<tr>
			<td class="man"><a href="#" onClick="return Popup(2,6);"><img
					class="help" src="img/x.gif" alt="" title="" /></a></td>

			<td class="desc">+<b>25</b>% <img class="r2" src="img/x.gif"
				alt="Clay" title="Clay" /> <?php echo (defined('LANG') && LANG === 'ar') ? 'الإنتاج: الطين' : 'Production: Clay'; ?><br /> <span class="run">
<?php

$tl_b2 = $golds['b2'];
if ($tl_b2 >= $date2) {
    echo "<font color='#B3B3B3' size='1'>" . formatRemainingTime($tl_b2, $date2) . "</font>";
}
?>
&nbsp;    </span>
			</td>
			<td class="dur"><?php

if (PLUS_PRODUCTION >= 86400) {
    echo '' . (PLUS_PRODUCTION / 86400) . ((defined('LANG') && LANG === 'ar') ? ' أيام' : ' Days');
} else if (PLUS_PRODUCTION < 86400) {
    echo '' . (PLUS_PRODUCTION / 3600) . ((defined('LANG') && LANG === 'ar') ? ' ساعات' : ' Hours');
}
?></td>
			<td class="cost"><img src="img/x.gif" class="gold" alt="Gold"
				title="Gold" />5</td>

			<td class="act"><span class="none">

<?php
if ($session->access != BANNED) {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 4 && $tl_b2 < $date2) {
            echo '<a href="plus.php?id=10"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 4 && $tl_b2 > $date2) {
            echo '        <a href="plus.php?id=10"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold').'</span></a></td>';
        }
    }
} else {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 4 && $tl_b2 < $date2) {
            echo '<a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 4 && $tl_b2 > $date2) {
            echo '        <a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="banned.php"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold').'</span></a></td>';
        }
    }
}
?>

        
		
		</tr>

		<tr>
			<td class="man"><a href="#" onClick="return Popup(3,6);"><img
					class="help" src="img/x.gif" alt="" title="" /></a></td>
			<td class="desc">+<b>25</b>% <img class="r3" src="img/x.gif"
				alt="Iron" title="Iron" /> <?php echo (defined('LANG') && LANG === 'ar') ? 'الإنتاج: الحديد' : 'Production: Iron'; ?><br /> <span class="run">
<?php

$tl_b3 = $golds['b3'];
if ($tl_b3 >= $date2) {
    echo "<font color='#B3B3B3' size='1'>" . formatRemainingTime($tl_b3, $date2) . "</font>";
}
?>
&nbsp;    </span>
			</td>
			<td class="dur"><?php

if (PLUS_PRODUCTION >= 86400) {
    echo '' . (PLUS_PRODUCTION / 86400) . ((defined('LANG') && LANG === 'ar') ? ' أيام' : ' Days');
} else if (PLUS_PRODUCTION < 86400) {
    echo '' . (PLUS_PRODUCTION / 3600) . ((defined('LANG') && LANG === 'ar') ? ' ساعات' : ' Hours');
}
?></td>
			<td class="cost"><img src="img/x.gif" class="gold" alt="Gold"
				title="Gold" />5</td>
			<td class="act"><span class="none">

<?php
if ($session->access != BANNED) {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 4 && $tl_b3 < $date2) {
            echo '<a href="plus.php?id=11"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 4 && $tl_b3 > $date2) {
            echo '        <a href="plus.php?id=11"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
} else {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 4 && $tl_b3 < $date2) {
            echo '<a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 4 && $tl_b3 > $date2) {
            echo '        <a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="banned.php"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
}
?>
&nbsp;    </span></a></td>
		</tr>

		<tr>

			<td class="man"><a href="#" onClick="return Popup(4,6);"><img
					class="help" src="img/x.gif" alt="" title="" /></a></td>
			<td class="desc">+<b>25</b>% <img class="r4" src="img/x.gif"
				alt="Crop" title="Crop" /> <?php echo (defined('LANG') && LANG === 'ar') ? 'الإنتاج: القمح' : 'Production: Crop'; ?><br /> <span class="run">
<?php

$tl_b4 = $golds['b4'];
if ($tl_b4 >= $date2) {
    echo "<font color='#B3B3B3' size='1'>" . formatRemainingTime($tl_b4, $date2) . "</font>";
}
?>
&nbsp;    </span>
			</td>
			<td class="dur"><?php

if (PLUS_PRODUCTION >= 86400) {
    echo '' . (PLUS_PRODUCTION / 86400) . ((defined('LANG') && LANG === 'ar') ? ' أيام' : ' Days');
} else if (PLUS_PRODUCTION < 86400) {
    echo '' . (PLUS_PRODUCTION / 3600) . ((defined('LANG') && LANG === 'ar') ? ' ساعات' : ' Hours');
}
?></td>
			<td class="cost"><img src="img/x.gif" class="gold" alt="Gold"
				title="Gold" />5</td>
			<td><span class="none">
<?php
if ($session->access != BANNED) {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 4 && $tl_b4 < $date2) {
            echo '<a href="plus.php?id=12"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 4 && $tl_b4 > $date2) {
            echo '        <a href="plus.php?id=12"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
} else {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 4 && $tl_b4 < $date2) {
            echo '<a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 4 && $tl_b4 > $date2) {
            echo '        <a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="banned.php"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
}
?>
</span></a></td>
		</tr>

		<tr>
			<td colspan="5" class="empty"></td>
		</tr>
		<tr>

			<td class="man"><a href="#" onClick="return Popup(7,6);"><img
					class="help" src="img/x.gif" alt="" title="" /></a></td>
			<td class="desc"><?php echo (defined('LANG') && LANG === 'ar') ? 'إكمال أوامر البناء والأبحاث في هذه القرية الآن (لا يعمل مع القصر والسكن).' : 'Complete construction orders and researches in this
				village now (does not work for Palace and Residence).'; ?></td>
			<td class="dur"><?php echo (defined('LANG') && LANG === 'ar') ? 'الآن' : 'now'; ?></td>
			<td class="cost"><img src="img/x.gif" class="gold" alt="Gold"
				title="Gold" />2</td>
			<td class="act"><span class="none">

<?php
if ($session->access != BANNED) {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 1) {
            echo '
                <a href="plus.php?id=7"><span>'.((defined('LANG') && LANG === 'ar') ? 'إنهاء' : 'On');
        } else {
            echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
} else {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 1) {
            echo '
                <a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'إنهاء' : 'On');
        } else {
            echo '<a href="banned.php"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
}
?>
</span></a></td>
		</tr>

		<tr>
			<td class="man"><a href="#" onClick="return Popup(8,6);"><img
					class="help" src="img/x.gif" alt="" title="" /></a></td>
			<td class="desc"><?php echo (defined('LANG') && LANG === 'ar') ? 'الانتقال الى تاجر المبادلة' : '1:1 Trade with the NPC merchant'; ?></td>
			<td class="dur"><?php echo (defined('LANG') && LANG === 'ar') ? 'الآن' : 'now'; ?></td>
			<td class="cost"><img src="img/x.gif" class="gold" alt="Gold"
				title="Gold" />3</td>

			<td class="act"><span class="none">

<?php
if ($session->access != BANNED) {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 2) {
            echo ' <a href="build.php?gid=17&t=3"><span>'.((defined('LANG') && LANG === 'ar') ? 'انتقال' : 'Go');
        } else {
            echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
} else {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 2) {
            echo ' <a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'انتقال' : 'Go');
        } else {
            echo '<a href="banned.php"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
}
?>
</span></a></td>
		</tr>

	</tbody>
</table>


<table class="plusFunctions" cellpadding="1" cellspacing="1">
		<thead>
			<tr>
				<th colspan="5"><?php echo (defined('LANG') && LANG === 'ar') ? 'خدمات الذهب' : 'Gold Services'; ?></th>
			</tr>
			<tr>
				<td></td>
				<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الوصف' : 'Description'; ?></td>
				<td><?php echo (defined('LANG') && LANG === 'ar') ? 'المدة' : 'Duration'; ?></td>
				<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الذهب' : 'Gold'; ?></td>
				<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الإجراء' : 'Action'; ?></td>
			</tr>
		</thead>
		<tbody>

			<tr>
				<td class="man"><a href="#" onClick="return Popup(0,6);"><img class="help" src="img/x.gif" alt="" title="" /></a></td>
				<td class="desc"><?php echo (defined('LANG') && LANG === 'ar') ? '<b>إنهاء تدريب الجنود فوراً</b><br />إكمال جميع تدريبات القوات في هذه القرية حالاً' : '<b>Finish troop training instantly</b><br />Complete all troop training in this village now'; ?></td>
				<td class="dur"><?php echo (defined('LANG') && LANG === 'ar') ? 'الآن' : 'now'; ?></td>
				<td class="cost"><img src="img/x.gif" class="gold" alt="Gold" title="Gold" />35</td>
				<td class="act">
				<?php
				$MyGold = mysqli_query($database->dblink, "SELECT * FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
				$golds = mysqli_fetch_array($MyGold);
				$trainingRows = $database->getTraining($village->wid);
				$hasTraining = !empty($trainingRows);
				if ($session->access != BANNED) {
				    if ($golds['gold'] >= 35) {
				        if ($hasTraining) {
				            echo '<a href="plus.php?id=16"><span>'.((defined('LANG') && LANG === 'ar') ? 'إنهاء' : 'Finish');
				        } else {
				            echo '<span class="none">'.((defined('LANG') && LANG === 'ar') ? 'لا تدريب' : 'No training');
				        }
				    } else {
				        echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
				    }
				} else {
				    echo '<a href="banned.php"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'إنهاء' : 'Finish');
				}
				?>
				</span></a></td>
			</tr>

			<tr>
				<td class="man"><a href="#" onClick="return Popup(0,6);"><img class="help" src="img/x.gif" alt="" title="" /></a></td>
				<td class="desc"><?php echo (defined('LANG') && LANG === 'ar') ? '<b>وصول التعزيزات فوراً</b><br />عودة جميع القوات إلى هذه القرية حالاً (لا يعمل مع المنجنيقات ومحطمات الأبواب والزعماء)' : '<b>Instant reinforcement arrival</b><br />Return all troops to this village now (does not work with catapults, battering rams and chiefs)'; ?></td>
				<td class="dur"><?php echo (defined('LANG') && LANG === 'ar') ? 'الآن' : 'now'; ?></td>
				<td class="cost"><img src="img/x.gif" class="gold" alt="Gold" title="Gold" />35</td>
				<td class="act">
				<?php
				$MyGold = mysqli_query($database->dblink, "SELECT * FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
				$golds = mysqli_fetch_array($MyGold);
				if ($session->access != BANNED) {
				    if ($golds['gold'] >= 35) {
				        echo '<a href="plus.php?id=17"><span>'.((defined('LANG') && LANG === 'ar') ? 'تعجيل' : 'Speed up');
				    } else {
				        echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
				    }
				} else {
				    echo '<a href="banned.php"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'تعجيل' : 'Speed up');
				}
				?>
				</span></a></td>
			</tr>

			<!-- ========== 75% CROP REDUCTION ========== -->
			<tr>
				<td colspan="5" class="empty"></td>
			</tr>
			<tr>
				<td class="man"><a href="#" onClick="return Popup(0,6);"><img class="help" src="img/x.gif" alt="" title="" /></a></td>
				<td class="desc">
					<b><?php echo (defined('LANG') && LANG === 'ar') ? 'تقليل استهلاك القمح 75%' : '75% Crop Consumption Reduction'; ?></b><br />
					<span class="run">
<?php
$cropRedTime = $golds['crop_reduction'];
if ($cropRedTime > $date2) {
    echo "<font color='#B3B3B3' size='1'>" . formatRemainingTime($cropRedTime, $date2) . "</font>";
} else {
    echo (defined('LANG') && LANG === 'ar') ? 'يعمل فقط عندما يكون إنتاج القمح بالسالب' : 'Only works when crop production is negative';
}
?>
					</span>
				</td>
				<td class="dur"><?php echo (defined('LANG') && LANG === 'ar') ? '5 ساعات' : '5 Hours'; ?></td>
				<td class="cost"><img src="img/x.gif" class="gold" alt="Gold" title="Gold" />350</td>
				<td class="act">
<?php
if ($session->access != BANNED) {
    if ($golds['gold'] >= 350) {
        if ($cropRedTime <= $date2) {
            echo '<a href="plus.php?id=18"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } else {
            echo '<a href="plus.php?id=18"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        }
    } else {
        echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
    }
} else {
    echo '<a href="banned.php"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
}
?>
				</span></a></td>
			</tr>

			<!-- ========== BUY RESOURCES WITH GOLD ========== -->
			<tr>
				<td colspan="5" class="empty"></td>
			</tr>
<?php
// Gather village storage data for the Fill Storage calculator
$_villageData = $database->getVillage($village->wid);
$_curWood = (int)$_villageData['wood'];
$_curClay = (int)$_villageData['clay'];
$_curIron = (int)$_villageData['iron'];
$_curCrop = (int)$_villageData['crop'];
$_maxStore = (int)$_villageData['maxstore'];
$_maxCrop  = (int)$_villageData['maxcrop'];
$_playerGold = (int)$golds['gold'];
?>
			<tr>
				<td class="man"><a href="#" onClick="return Popup(0,6);"><img class="help" src="img/x.gif" alt="" title="" /></a></td>
				<td class="desc" colspan="3">
					<b><?php echo (defined('LANG') && LANG === 'ar') ? 'شراء الموارد بالذهب' : 'Buy Resources with Gold'; ?></b><br />
					<span class="run">
						<?php echo (defined('LANG') && LANG === 'ar') ? 'كل 1 ذهب = 20,000 من كل مورد. لا يعمل بالذهب المجاني.' : 'Each 1 gold = 20,000 of each resource. Does not work with free gold.'; ?>
					</span>
					<br /><br />
					<form method="POST" action="plus.php?id=19" style="display:inline;">
						<input type="hidden" name="csrf_token" value="<?php echo htmlspecialchars($_SESSION['csrf_token']); ?>" />
						<label><?php echo (defined('LANG') && LANG === 'ar') ? 'كمية الذهب:' : 'Gold amount:'; ?></label>
						<input type="number" name="gold_amount" id="goldAmountInput" min="1" max="<?php echo $_playerGold; ?>" value="1" style="width:60px; text-align:center;" 
							onchange="updateResourcePreview(this.value)" oninput="updateResourcePreview(this.value)" />
						<button type="button" id="fillStorageBtn" onclick="fillStorageCalc()" style="margin-right:5px; cursor:pointer; background:linear-gradient(135deg,#71D000,#5ab800); color:#fff; border:1px solid #4a9900; border-radius:3px; padding:2px 10px; font-weight:bold; font-size:11px;">
							<?php echo (defined('LANG') && LANG === 'ar') ? '🏪 ملئ المخزن' : '🏪 Fill Storage'; ?>
						</button>
						<br />
						<div id="resourcePreview" style="color:#B3B3B3; font-size:11px; margin:5px 0;">
							(<?php echo (defined('LANG') && LANG === 'ar') ? 'الموارد: 20,000 لكل نوع' : 'Resources: 20,000 each type'; ?>)
						</div>
						<div id="fillBreakdown" style="display:none; background:rgba(0,0,0,0.03); border:1px solid #ddd; border-radius:4px; padding:6px 10px; margin:5px 0; font-size:11px; line-height:1.7;">
						</div>
<?php
if ($session->access != BANNED && $golds['gold'] >= 1) {
    echo '<input type="submit" name="buy_resources" value="'.((defined('LANG') && LANG === 'ar') ? 'شراء' : 'Buy').'" style="margin-top:5px; cursor:pointer;" />';
} else {
    echo '<span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold').'</span>';
}
?>
					</form>
					<script>
					var _RATE = 20000;
					var _curRes = {
						wood: <?php echo $_curWood; ?>,
						clay: <?php echo $_curClay; ?>,
						iron: <?php echo $_curIron; ?>,
						crop: <?php echo $_curCrop; ?>
					};
					var _maxStore = <?php echo $_maxStore; ?>;
					var _maxCrop  = <?php echo $_maxCrop; ?>;
					var _playerGold = <?php echo $_playerGold; ?>;
					var _isAr = <?php echo (defined('LANG') && LANG === 'ar') ? 'true' : 'false'; ?>;

					function updateResourcePreview(val) {
						var amount = parseInt(val) || 0;
						var total = amount * _RATE;
						var fmtTotal = total.toLocaleString();
						// Calculate per-resource after fill (capped at storage)
						var addWood = Math.min(total, _maxStore - _curRes.wood); addWood = Math.max(0, addWood);
						var addClay = Math.min(total, _maxStore - _curRes.clay); addClay = Math.max(0, addClay);
						var addIron = Math.min(total, _maxStore - _curRes.iron); addIron = Math.max(0, addIron);
						var addCrop = Math.min(total, _maxCrop  - _curRes.crop); addCrop = Math.max(0, addCrop);

						var html = _isAr
							? '(الموارد: ' + fmtTotal + ' لكل نوع)'
							: '(Resources: ' + fmtTotal + ' each type)';
						document.getElementById('resourcePreview').innerHTML = html;

						// Show detailed breakdown
						var bd = document.getElementById('fillBreakdown');
						if (amount > 0) {
							bd.style.display = 'block';
							bd.innerHTML = (_isAr ? '🪵 خشب' : '🪵 Wood') + ': ' + _curRes.wood.toLocaleString() + ' → <b style="color:#060">' + (_curRes.wood + addWood).toLocaleString() + '</b> / ' + _maxStore.toLocaleString() + '<br>'
								+ (_isAr ? '🧱 طين' : '🧱 Clay') + ': ' + _curRes.clay.toLocaleString() + ' → <b style="color:#960">' + (_curRes.clay + addClay).toLocaleString() + '</b> / ' + _maxStore.toLocaleString() + '<br>'
								+ (_isAr ? '⚙️ حديد' : '⚙️ Iron') + ': ' + _curRes.iron.toLocaleString() + ' → <b style="color:#666">' + (_curRes.iron + addIron).toLocaleString() + '</b> / ' + _maxStore.toLocaleString() + '<br>'
								+ (_isAr ? '🌾 قمح' : '🌾 Crop') + ': ' + _curRes.crop.toLocaleString() + ' → <b style="color:#C90">' + (_curRes.crop + addCrop).toLocaleString() + '</b> / ' + _maxCrop.toLocaleString();
						} else {
							bd.style.display = 'none';
						}
					}

					function fillStorageCalc() {
						// Calculate remaining space for each resource
						var spaceWood = Math.max(0, _maxStore - _curRes.wood);
						var spaceClay = Math.max(0, _maxStore - _curRes.clay);
						var spaceIron = Math.max(0, _maxStore - _curRes.iron);
						var spaceCrop = Math.max(0, _maxCrop  - _curRes.crop);

						// The limiting resource is the one with LEAST remaining space
						// because buying X gold gives X*20000 of ALL resources equally
						var minSpace = Math.min(spaceWood, spaceClay, spaceIron, spaceCrop);

						// Highlight the limiting resource in breakdown
						var limitRes = '';
						if (minSpace === spaceWood) limitRes = _isAr ? 'الخشب' : 'Wood';
						else if (minSpace === spaceClay) limitRes = _isAr ? 'الطين' : 'Clay';
						else if (minSpace === spaceIron) limitRes = _isAr ? 'الحديد' : 'Iron';
						else limitRes = _isAr ? 'القمح' : 'Crop';

						if (Math.floor(minSpace / _RATE) === 0) {
							var goldNeeded = 0;
							var input = document.getElementById('goldAmountInput');
							input.value = "0";
							updateResourcePreview(0);
							var bd = document.getElementById('fillBreakdown');
							bd.style.display = 'block';
							bd.innerHTML += '<br><span style="color:#D4A017; font-weight:bold;">⚡ '
								+ (_isAr ? 'المساحة المتبقية لـ ' + limitRes + ' غير كافية لعملية شراء واحدة' : 'Remaining storage for ' + limitRes + ' is insufficient for a single gold purchase')
								+ '</span>';
							return;
						}

						// Gold needed = minSpace / rate, floored (no overpaying)
						var goldNeeded = Math.floor(minSpace / _RATE);

						// Cap at player's available gold
						goldNeeded = Math.min(goldNeeded, _playerGold);

						// Set the input and trigger preview update
						var input = document.getElementById('goldAmountInput');
						input.value = goldNeeded;
						updateResourcePreview(goldNeeded);

						var note = '<br><span style="color:#D4A017; font-weight:bold;">⚡ '
							+ (_isAr ? 'المحدد: ' + limitRes + ' (سيمتلئ أولاً)' : 'Limiting: ' + limitRes + ' (fills first)')
							+ '</span>';
						document.getElementById('fillBreakdown').innerHTML += note;
					}
					</script>
				</td>
				<td class="act"></td>
			</tr>

			<!-- ========== 24-HOUR GOLD PROTECTION ========== -->
			<tr>
				<td colspan="5" class="empty"></td>
			</tr>
			<tr>
				<td class="man"><a href="#" onClick="return Popup(0,6);"><img class="help" src="img/x.gif" alt="" title="" /></a></td>
				<td class="desc" colspan="3">
<?php
$protectTime = $golds['gold_protect'];
$protectCount = (int)$golds['gold_protect_count'];
$protectCost = 1000 * pow(2, $protectCount);
$isProtected = ($protectTime > $date2);
?>
					<b><?php echo (defined('LANG') && LANG === 'ar') ? 'تفعيل الحماية 24 ساعة' : '24-Hour Gold Protection'; ?></b><br />
					<span class="run">
<?php
if ($isProtected) {
    echo "<font color='#71D000'>" . ((defined('LANG') && LANG === 'ar') ? '✅ الحماية مفعلة - ' : '✅ Protection Active - ') . "</font>";
    echo "<font color='#B3B3B3' size='1'>" . formatRemainingTime($protectTime, $date2) . "</font>";
} else {
    echo (defined('LANG') && LANG === 'ar') 
        ? 'يتطلب كلمة سر الحساب. لا يشمل القرى التي فيها تحفة أثرية. التكلفة تتضاعف في كل مرة.' 
        : 'Requires account password. Does not include villages with artifacts. Cost doubles each activation.';
}
?>
					</span>
<?php if (!$isProtected): ?>
					<br /><br />
					<?php if (isset($_GET['error']) && $_GET['error'] == 'password'): ?>
						<span style="color:red; font-weight:bold;"><?php echo (defined('LANG') && LANG === 'ar') ? '❌ كلمة السر غير صحيحة!' : '❌ Incorrect password!'; ?></span><br />
					<?php endif; ?>
					<form method="POST" action="plus.php?id=20" style="display:inline;">
						<input type="hidden" name="csrf_token" value="<?php echo htmlspecialchars($_SESSION['csrf_token']); ?>" />
						<label><?php echo (defined('LANG') && LANG === 'ar') ? 'كلمة السر:' : 'Password:'; ?></label>
						<input type="password" name="password" required style="width:120px;" />
						<br />
						<span style="color:#B3B3B3; font-size:11px;">
							<?php echo (defined('LANG') && LANG === 'ar') 
								? 'التكلفة: ' . number_format($protectCost) . ' ذهب (المرة رقم ' . ($protectCount + 1) . ')' 
								: 'Cost: ' . number_format($protectCost) . ' gold (activation #' . ($protectCount + 1) . ')'; ?>
						</span>
						<br />
<?php
if ($session->access != BANNED && $golds['gold'] >= $protectCost) {
    echo '<input type="submit" name="activate_protection" value="'.((defined('LANG') && LANG === 'ar') ? 'تفعيل الحماية' : 'Activate Protection').'" style="margin-top:5px; cursor:pointer;" />';
} else {
    echo '<span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي (تحتاج ' . number_format($protectCost) . ')' : 'too little gold (need ' . number_format($protectCost) . ')').'</span>';
}
?>
					</form>
<?php endif; ?>
				</td>
				<td class="act"></td>
			</tr>

		</tbody>
	</table>
</div>
