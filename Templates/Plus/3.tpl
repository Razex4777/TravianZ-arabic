<?php
//TODO: Reduce this file by a lot, by using arrays
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
			<td class="desc"><b><font color="#71D000">P</font><font
					color="#FF6F0F">l</font><font color="#71D000">u</font><font
					color="#FF6F0F">s</font></b> <?php echo (defined('LANG') && LANG === 'ar') ? 'حساب' : 'Account'; ?><br /> <span class="run">
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
				title="Gold" alt="Gold" title="Gold" />10</td>
			<td class="act">

<?php
    $MyGold = mysqli_query($database->dblink, "SELECT * FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
    $golds = mysqli_fetch_array($MyGold);
    
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 9 && $datetimep < $date2) {
            echo '
                <a href="plus.php?id=8"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } elseif ($golds['gold'] > 9 && $datetimep > $date2) {
            echo '
                <a href="plus.php?id=8"><span>'.((defined('LANG') && LANG === 'ar') ? 'تمديد' : 'Extend');
        } else {
            echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
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
			<td class="desc"><?php echo (defined('LANG') && LANG === 'ar') ? 'إكمال أوامر البناء والأبحاث في هذه القرية الآن (لا يعمل مع القصر والإقامة).' : 'Complete construction orders and researches in this
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
                <a href="plus.php?id=7"><span>'.((defined('LANG') && LANG === 'ar') ? 'تشغيل' : 'On');
        } else {
            echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
} else {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 1) {
            echo '
                <a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تشغيل' : 'On');
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
			<td class="desc"><?php echo (defined('LANG') && LANG === 'ar') ? 'تبادل 1:1 مع تاجر NPC' : '1:1 Trade with the NPC merchant'; ?></td>
			<td class="dur"><?php echo (defined('LANG') && LANG === 'ar') ? 'الآن' : 'now'; ?></td>
			<td class="cost"><img src="img/x.gif" class="gold" alt="Gold"
				title="Gold" />3</td>

			<td class="act"><span class="none">

<?php
if ($session->access != BANNED) {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 2) {
            echo ' <a href="build.php?gid=17&t=3"><span>'.((defined('LANG') && LANG === 'ar') ? 'تبادل' : 'NPC');
        } else {
            echo '<a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    }
} else {
    if (mysqli_num_rows($MyGold)) {
        if ($golds['gold'] > 2) {
            echo ' <a href="banned.php"><span>'.((defined('LANG') && LANG === 'ar') ? 'تبادل' : 'NPC');
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
			<th colspan="5"><?php echo (defined('LANG') && LANG === 'ar') ? 'نادي ترافيان الذهبي' : 'Travian Gold Club'; ?></th>
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
			<td class="man"><a href="#" onClick="return Popup(9,6);"><img
					class="help" src="img/x.gif" alt="" title="" /></a></td>
			<td class="desc"><b><?php echo (defined('LANG') && LANG === 'ar') ? 'النادي الذهبي' : 'Gold Club'; ?></b></br> <span class="run"> </span></td>
			<td class="dur"><?php echo (defined('LANG') && LANG === 'ar') ? 'طوال الجولة' : 'Whole game round'; ?></td>
			<td class="cost"><img src="img/x.gif" class="gold" alt="Gold"
				title="Gold" alt="Gold" title="Gold" />100</td>
			<td class="act">

<?php
$MyGold = mysqli_query($database->dblink, "SELECT * FROM " . TB_PREFIX . "users WHERE `id`='" . $session->uid . "'") or die(mysqli_error($database->dblink));
$golds = mysqli_fetch_array($MyGold);

if (mysqli_num_rows($MyGold)) {
    if ($golds['goldclub'] == 0) {
        if ($golds['gold'] > 99) {
            echo '
                <a href="plus.php?id=15"><span>'.((defined('LANG') && LANG === 'ar') ? 'تفعيل' : 'Activate');
        } else {
            echo '
                <a href="plus.php?s=1"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'ذهب غير كافي' : 'too little gold');
        }
    } else {
        echo '<a href="plus.php?id=3"><span class="none">'.((defined('LANG') && LANG === 'ar') ? 'مفعّل' : 'On');
    }
}
?>
    </span></a>
			</td>
		</tr>
	</tbody>
</table>
</div>
