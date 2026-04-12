<table cellpadding="1" cellspacing="1" id="member">
	<thead>
		<tr>
			<th colspan="10"><?php echo (defined('LANG') && LANG === 'ar') ? 'لاعبون غير مفعلين' : 'Players Not Activated'; ?></th>
		</tr>
		<tr>
			<td class="on">#</td>
			<td class="on">ID</td>
			<td class="on"><?php echo (defined('LANG') && LANG === 'ar') ? 'اسم المستخدم' : 'Username'; ?></td>
			<td class="on"><?php echo (defined('LANG') && LANG === 'ar') ? 'البريد الإلكتروني' : 'Email'; ?></td>
			<td class="on"><?php echo (defined('LANG') && LANG === 'ar') ? 'القبيلة' : 'Tribe'; ?></td>
			<td class="on"><?php echo (defined('LANG') && LANG === 'ar') ? 'كود التفعيل' : 'Activation Code'; ?></td>
			<td class="on"><?php echo (defined('LANG') && LANG === 'ar') ? 'تفعيل 2؟؟' : 'Act 2??'; ?></td>
			<td class="on"><?php echo (defined('LANG') && LANG === 'ar') ? 'الوقت' : 'Time'; ?></td>
		</tr>
	</thead>
	<tbody>
		<?php
			$sql = "SELECT * FROM ".TB_PREFIX."activate";
			$result = mysqli_query($GLOBALS["link"], $sql);
			$i = 0;
			while($row = mysqli_fetch_assoc($result))
			{
				$i++;
				if($row['tribe'] == 1) {$tribe = (defined('LANG') && LANG === 'ar') ? 'الرومان' : 'Roman'; }
				elseif($row['tribe'] == 2) {$tribe = (defined('LANG') && LANG === 'ar') ? 'الجرمان' : 'Teuton'; }
				elseif($row['tribe'] == 3) {$tribe = (defined('LANG') && LANG === 'ar') ? 'الإغريق' : 'Gaul'; }
				echo "
				<tr>
					<td>".$i."</td>
					<td>".$row['id']."</td>
					<td>".$row['username']."</td>
					<td><a href=\"mailto:".$row['email']."\">".$row['email']."</a></td>
					<td>".$tribe."</td>
					<td>".$row['act']."</td>
					<td>".$row['act2']."</td>
					<td class=\"hab\">".date('d:m:Y H:i', $row['timestamp'])."</td>
				</tr>";
			}
		?>
	</tbody>
</table>