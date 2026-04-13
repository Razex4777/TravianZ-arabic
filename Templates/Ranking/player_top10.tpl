    <?php
	$place = $place1 = $place2 = $place3 = "?";


    for($i=1;$i<=0;$i++) {
    echo "Row ".$i;
    }

    $result = mysqli_query($database->dblink,"SELECT * FROM ".TB_PREFIX."users WHERE access<".(INCLUDE_ADMIN?"10":"8")." AND id > 5 AND tribe<=3 AND tribe > 0 ORDER BY ap DESC, id DESC Limit 10");
    $result2 = mysqli_query($database->dblink,"SELECT * FROM ".TB_PREFIX."users WHERE id = '".$session->uid."' ORDER BY ap DESC, id DESC Limit 1");
	?>
	<table cellpadding="1" cellspacing="1">
	<thead>
		<tr>
			<th><?php echo (defined('LANG') && LANG === 'ar') ? 'أفضل 10 لاعبين' : 'Top 10 players'; ?><div id="submenu"><a title="<?php echo (defined('LANG') && LANG === 'ar') ? 'العشرة الأوائل' : 'Top 10'; ?>" href="statistiken.php?id=7"><img class="active btn_top10" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'العشرة الأوائل' : 'Top 10'; ?>"></a><a title="<?php echo (defined('LANG') && LANG === 'ar') ? 'مدافع' : 'defender'; ?>" href="statistiken.php?id=32"><img class="btn_def" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'مدافع' : 'defender'; ?>"></a><a title="<?php echo (defined('LANG') && LANG === 'ar') ? 'مهاجم' : 'attacker'; ?>" href="statistiken.php?id=31"><img class="btn_off" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'مهاجم' : 'attacker'; ?>"></a></div><div id="submenu2"><a title="<?php echo (defined('LANG') && LANG === 'ar') ? 'الرومان' : 'Romans'; ?>" href="statistiken.php?id=11"><img class="btn_v1" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'الرومان' : 'Romans'; ?>"></a><a title="<?php echo (defined('LANG') && LANG === 'ar') ? 'التيوتون' : 'Teutons'; ?>" href="statistiken.php?id=12"><img class="btn_v2" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'التيوتون' : 'Teutons'; ?>"></a><a title="<?php echo (defined('LANG') && LANG === 'ar') ? 'الغال' : 'Gauls'; ?>" href="statistiken.php?id=13"><img class="btn_v3" src="img/x.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'الغال' : 'Gauls'; ?>"></a></div></th>
		</tr>
	</thead>
</table>
<table cellpadding="1" cellspacing="1" id="top10_offs" class="top10 row_table_data">
	<thead>
		<tr>
			<th onclick="return Popup(3,5)"><img src="img/x.gif" class="help" alt="Instructions" title="Instructions">
			</th>
			<th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'مهاجمو الأسبوع' : 'Attackers of the week'; ?></th>
		</tr>
		<tr>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'رقم' : 'No.'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'اللاعب' : 'Player'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'النقاط' : 'Points'; ?></td>
		</tr>
	</thead>
	<tbody>
<?php
    $goldRewards = [1=>450, 2=>300, 3=>250, 4=>200, 5=>150, 6=>140, 7=>130, 8=>120, 9=>110, 10=>100];
    while($row = mysqli_fetch_array($result))
      {
	  if($row['id']==$session->uid) {
	  if($row['id']==$session->uid) {
	  $place = $i;
	  }
	  }
	  $reward = isset($goldRewards[$i]) ? ' <span style="color:#FFA500; font-size:10px; font-weight:bold" title="Gold Reward">💰 +'.$goldRewards[$i].'</span>' : '';
	  if($row['id']==$session->uid) echo "<tr class=\"own hl\">"; else echo "<tr>"; 
      echo "<td class=\"ra fc\">".$i++.".&nbsp;</td>";
      echo "<td class=\"pla\"><a href='spieler.php?uid=".$row['id']."'>".$row['username']."</a>".$reward."</td>";
      echo "<td class=\"val lc\">".$row['ap']."</td>";
      echo "</tr>";
      }
?>
		 <tr>
			<td colspan="3" class="empty"></td>
		</tr>
<?php
    while($row = mysqli_fetch_array($result2))
      {
		if($row['id'] == $session->uid) {
		echo "<tr class=\"none\">"; } else { echo "<tr class=\"own hl\">"; }
      echo "<td class=\"ra fc\">".$place."&nbsp;</td>";
	  	if($row['id'] == $session->uid) {
		echo "<td class=\"pla\">".$row['username']."</td>"; } else { echo "<td class=\"pla\"><a href='spieler.php?uid=".$row['id']."'>".$row['username']."</a></td>"; }
      echo "<td class=\"val lc\">".$row['ap']."</td>";
      echo "</tr>";
      }
?>
         </tbody>
</table>


<?php
    for($i=1;$i<=0;$i++) {
    echo "Row ".$i;
    }
    $result = mysqli_query($database->dblink,"SELECT * FROM ".TB_PREFIX."users WHERE access<".(INCLUDE_ADMIN?"10":"8")." AND id > 5 AND tribe<=3 AND tribe > 0 ORDER BY dp DESC, id DESC Limit 10");
    $result2 = mysqli_query($database->dblink,"SELECT * FROM ".TB_PREFIX."users WHERE id = '".$session->uid."' ORDER BY dp DESC Limit 1");
?>
<table cellpadding="1" cellspacing="1" id="top10_defs" class="top10 row_table_data">
	<thead>
		<tr>
			<th onclick="return Popup(3,5)"><img src="img/x.gif" class="help" alt="Instructions" title="Instructions">
			</th>
			<th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'مدافعو الأسبوع' : 'Defenders of the week'; ?></th>
		</tr>
		<tr>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'رقم' : 'No.'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'اللاعب' : 'Player'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'النقاط' : 'Points'; ?></td>
		</tr>
	</thead>
	<tbody>
<?php
    while($row = mysqli_fetch_array($result))
      {
	  if($row['id']==$session->uid) {
	  $place1 = $i;
	  }
	  $reward = isset($goldRewards[$i]) ? ' <span style="color:#FFA500; font-size:10px; font-weight:bold" title="Gold Reward">💰 +'.$goldRewards[$i].'</span>' : '';
	  if($row['id']==$session->uid) {
	  echo "<tr class=\"own hl\">"; } else { echo "<tr>"; }
      echo "<td class=\"ra fc\">".$i++.".&nbsp;</td>";
	  echo "<td class=\"pla\"><a href='spieler.php?uid=".$row['id']."'>".$row['username']."</a>".$reward."</td>";
      echo "<td class=\"val lc\">".$row['dp']."</td>";
      echo "</tr>";
      }
?>
	
		 <tr>
			<td colspan="3" class="empty"></td>
		</tr>
<?php
    while($row = mysqli_fetch_array($result2))
      {
     if($row['id'] == $session->uid) {
		echo "<tr class=\"none\">"; } else { echo "<tr class=\"own hl\">"; }
      echo "<td class=\"ra fc\">".$place1."&nbsp;</td>";
     if($row['id'] == $session->uid) {
		echo "<td class=\"pla\">".$row['username']."</td>"; } else { echo "<td class=\"pla\"><a href='spieler.php?uid=".$row['id']."'>".$row['username']."</a></td>"; }
      echo "<td class=\"val lc\">".$row['dp']."</td>";
      echo "</tr>";
      }
?>
         </tbody>
</table>
	
<?php
    for($i=1;$i<=0;$i++) {
    echo "Row ".$i;
    }
    $result = mysqli_query($database->dblink,"SELECT * FROM ".TB_PREFIX."users WHERE access<".(INCLUDE_ADMIN?"10":"8")." AND id > 5 AND tribe<=3 AND tribe > 0 ORDER BY clp DESC, id DESC Limit 10");
    $result2 = mysqli_query($database->dblink,"SELECT * FROM ".TB_PREFIX."users WHERE id = '".$session->uid."' ORDER BY clp DESC Limit 1");
?>
<div class="clear"></div>
<table cellpadding="1" cellspacing="1" id="top10_climbers" class="top10 row_table_data">
	<thead>
		<tr>
			<th onclick="return Popup(3,5)"><img src="img/x.gif" class="help" alt="Instructions" title="Instructions">
			</th>
			<th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'متسلقو الأسبوع' : 'Climbers of the week'; ?></th>
		</tr>
		<tr>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'رقم' : 'No.'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'اللاعب' : 'Player'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'المراتب' : 'Ranks'; ?></td>
		</tr>
	</thead>
	<tbody>
<?php
    while($row = mysqli_fetch_array($result))
      {
	  if($row['id']==$session->uid) {
	  $place2 = $i;
	  }
	  $reward = isset($goldRewards[$i]) ? ' <span style="color:#FFA500; font-size:10px; font-weight:bold" title="Gold Reward">💰 +'.$goldRewards[$i].'</span>' : '';
	  if($row['id']==$session->uid) {
	  echo "<tr class=\"own hl\">"; } else { echo "<tr>"; }
      echo "<td class=\"ra fc\">".$i++.".&nbsp;</td>";
      echo "<td class=\"pla\"><a href='spieler.php?uid=".$row['id']."'>".$row['username']."</a>".$reward."</td>";
      echo "<td class=\"val lc\">".$row['clp']."</td>";
      echo "</tr>";
      }
?>
		 <tr>
			<td colspan="3" class="empty"></td>
		</tr>
<?php
    while($row = mysqli_fetch_array($result2))
      {
		if($row['id'] == $session->uid) {
		echo "<tr class=\"none\">"; } else { echo "<tr class=\"own hl\">"; }
      echo "<td class=\"ra fc\">".$place2."&nbsp;</td>";
		if($row['id'] == $session->uid) {
		echo "<td class=\"pla\">".$row['username']."</td>"; } else { echo "<td class=\"pla\"><a href='spieler.php?uid=".$row['id']."'>".$row['username']."</a></td>"; }      echo "<td class=\"val lc\">".$row['clp']."</td>";
      echo "</tr>";
      }
?>
         </tbody>
</table>
<?php
    for($i=1;$i<=0;$i++) {
    echo "Row ".$i;
    }
    $result = mysqli_query($database->dblink,"SELECT * FROM ".TB_PREFIX."users WHERE access<".(INCLUDE_ADMIN?"10":"8")." AND id > 5 AND tribe<=3 AND tribe > 0 ORDER BY RR DESC, id DESC Limit 10");
    $result2 = mysqli_query($database->dblink,"SELECT * FROM ".TB_PREFIX."users WHERE id = '".$session->uid."' ORDER BY RR DESC Limit 1");
?>
<table cellpadding="1" cellspacing="1" id="top10_raiders" class="top10 row_table_data">
	<thead>
		<tr>
			<th onclick="return Popup(3,5)"><img src="img/x.gif" class="help" alt="Instructions" title="Instructions">
			</th>
			<th colspan="2"><?php echo (defined('LANG') && LANG === 'ar') ? 'لصوص الأسبوع' : 'Robbers of the week'; ?></th>
		</tr>
		<tr>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'رقم' : 'No.'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'اللاعب' : 'Player'; ?></td>
			<td><?php echo (defined('LANG') && LANG === 'ar') ? 'الموارد' : 'Resources'; ?></td>
		</tr>
	</thead>
	<tbody>
<?php
    while($row = mysqli_fetch_array($result))
      {
	  if($row['RR'] >= 0) {
	  if($row['id']==$session->uid) {
	  $place3 = $i;
	  }
	  $reward = isset($goldRewards[$i]) ? ' <span style="color:#FFA500; font-size:10px; font-weight:bold" title="Gold Reward">💰 +'.$goldRewards[$i].'</span>' : '';
	  if($row['id']==$session->uid) {
	  echo "<tr class=\"own hl\">"; } else { echo "<tr>"; }
      echo "<td class=\"ra fc\">".$i++.".&nbsp;</td>";
      echo "<td class=\"pla\"><a href='spieler.php?uid=".$row['id']."'>".$row['username']."</a>".$reward."</td>";
      echo "<td class=\"val lc\">".$row['RR']."</td>";
      echo "</tr>";
	  }
      }
?>
		 <tr>
			<td colspan="3" class="empty"></td>
		</tr>
<?php
    while($row = mysqli_fetch_array($result2))
      {
      if($row['id']==$session->uid) {
		echo "<tr class=\"none\">"; } else { echo "<tr class=\"own hl\">"; }
      echo "<td class=\"ra fc\">".$place3."&nbsp;</td>";
      if($row['id']==$session->uid) {
		echo "<td class=\"pla\">".$row['username']."</td>"; } else { echo "<td class=\"pla\"><a href='spieler.php?uid=".$row['id']."'>".$row['username']."</a></td>"; }
      echo "<td class=\"val lc\">".$row['RR']."</td>";
      echo "</tr>";
      }
	  
//	mysqli_close($con);
?>
         </tbody>
</table>

<?php
// Calculate seconds until next midnight (00:00 server time)
$now = time();
$nextMidnight = strtotime('tomorrow midnight');
$secondsLeft = max(0, $nextMidnight - $now);
?>
<div id="dailyGoldCountdown" style="margin:15px auto; max-width:600px; padding:16px 20px; background:linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%); border:2px solid #e2b33e; border-radius:10px; text-align:center; color:#f0e6d3; font-family:Arial,sans-serif; box-shadow:0 4px 15px rgba(226,179,62,0.3);">
    <div style="font-size:14px; font-weight:bold; color:#e2b33e; margin-bottom:8px; text-transform:uppercase; letter-spacing:1px;">
        🏆 <?php echo (defined('LANG') && LANG === 'ar') ? 'المكافأة اليومية' : 'Daily Gold Reward'; ?> 🏆
    </div>
    <div style="font-size:12px; color:#c9b88c; margin-bottom:10px;">
        <?php echo (defined('LANG') && LANG === 'ar')
            ? '🪙 500 ذهب مجاني لجميع اللاعبين + مكافأة إضافية لأفضل 10'
            : '🪙 500 free gold for all players + bonus for Top 10'; ?>
    </div>
    <div style="display:flex; justify-content:center; align-items:center; gap:6px; margin-bottom:10px;">
        <div style="background:rgba(226,179,62,0.15); border:1px solid #e2b33e; border-radius:6px; padding:8px 12px; min-width:50px;">
            <div id="dgHours" style="font-size:26px; font-weight:bold; color:#FFD700; text-shadow:0 0 8px rgba(255,215,0,0.5);">00</div>
            <div style="font-size:9px; color:#c9b88c; text-transform:uppercase;"><?php echo (defined('LANG') && LANG === 'ar') ? 'ساعة' : 'Hours'; ?></div>
        </div>
        <span style="font-size:26px; color:#e2b33e; font-weight:bold;">:</span>
        <div style="background:rgba(226,179,62,0.15); border:1px solid #e2b33e; border-radius:6px; padding:8px 12px; min-width:50px;">
            <div id="dgMinutes" style="font-size:26px; font-weight:bold; color:#FFD700; text-shadow:0 0 8px rgba(255,215,0,0.5);">00</div>
            <div style="font-size:9px; color:#c9b88c; text-transform:uppercase;"><?php echo (defined('LANG') && LANG === 'ar') ? 'دقيقة' : 'Min'; ?></div>
        </div>
        <span style="font-size:26px; color:#e2b33e; font-weight:bold;">:</span>
        <div style="background:rgba(226,179,62,0.15); border:1px solid #e2b33e; border-radius:6px; padding:8px 12px; min-width:50px;">
            <div id="dgSeconds" style="font-size:26px; font-weight:bold; color:#FFD700; text-shadow:0 0 8px rgba(255,215,0,0.5);">00</div>
            <div style="font-size:9px; color:#c9b88c; text-transform:uppercase;"><?php echo (defined('LANG') && LANG === 'ar') ? 'ثانية' : 'Sec'; ?></div>
        </div>
    </div>
    <div style="font-size:10px; color:#8a7e6b; border-top:1px solid rgba(226,179,62,0.3); padding-top:8px;">
        <?php echo (defined('LANG') && LANG === 'ar')
            ? '🥇450 · 🥈300 · 🥉250 · 4ᵗʰ 200 · 5ᵗʰ 150 · 6ᵗʰ 140 · 7ᵗʰ 130 · 8ᵗʰ 120 · 9ᵗʰ 110 · 10ᵗʰ 100'
            : '🥇450 · 🥈300 · 🥉250 · 4ᵗʰ 200 · 5ᵗʰ 150 · 6ᵗʰ 140 · 7ᵗʰ 130 · 8ᵗʰ 120 · 9ᵗʰ 110 · 10ᵗʰ 100'; ?>
    </div>
</div>
<script type="text/javascript">
(function(){
    var left = <?php echo (int)$secondsLeft; ?>;
    function pad(n){ return n < 10 ? '0'+n : n; }
    function tick(){
        if(left <= 0){
            document.getElementById('dgHours').textContent = '00';
            document.getElementById('dgMinutes').textContent = '00';
            document.getElementById('dgSeconds').textContent = '00';
            return;
        }
        var h = Math.floor(left/3600);
        var m = Math.floor((left%3600)/60);
        var s = left%60;
        document.getElementById('dgHours').textContent = pad(h);
        document.getElementById('dgMinutes').textContent = pad(m);
        document.getElementById('dgSeconds').textContent = pad(s);
        left--;
    }
    tick();
    setInterval(tick, 1000);
})();
</script>
<div>
