<?php
include("Templates/Plus/pmenu.tpl");
?>

    <h2><?php echo (defined('LANG') && LANG === 'ar') ? 'ادعُ أصدقاءك واحصل على ذهب مجاني' : 'Invite friends and receive free Gold'; ?></h2>

    <p><?php echo (defined('LANG') && LANG === 'ar') ? 'إذا جعلت لاعبين جدد يفتحون حسابًا ويبنون قرية ثانية في ترافين، ستحصل على ذهب. يمكنك استخدام هذا الذهب لشراء حساب بلس أو مزايا بلس.<br><br>لجلب لاعبين جدد، يمكنك دعوتهم عبر البريد الإلكتروني أو بجعلهم ينقرون على رابط الإحالة الخاص بك.' : 'If you get new players to open an account and settle a second village with Travian you will receive gold. You can use this gold to purchase a plus account or plus advantages.<br><br>To bring in new players, you can invite them by e-mail or have them click on your REF link.'; ?></p>

    <h2><?php echo (defined('LANG') && LANG === 'ar') ? 'كيف يتم ذلك؟' : 'How is it done?'; ?></h2>

    <h3><?php echo (defined('LANG') && LANG === 'ar') ? '1) ادعُ أصدقاءك عبر البريد الإلكتروني' : '1) Invite your friends via Email'; ?></h3>
    <p><a href="plus.php?id=5&amp;a=1&amp;mail"><?php echo (defined('LANG') && LANG === 'ar') ? '&laquo; دعوة عبر البريد الإلكتروني' : '&raquo; Invite by e-mail'; ?></a></p>
    <h3><?php echo (defined('LANG') && LANG === 'ar') ? '2) انسخ رابط الإحالة الخاص بك وشاركه!' : '2) Copy your personal REF-Link and share it!'; ?></h3><span class="notice"><?php echo (defined('LANG') && LANG === 'ar') ? 'رابط الإحالة الخاص بك:' : 'Your personal REF Link:'; ?></span>
    <br>
    <span class="link"><?php echo HOMEPAGE.(substr(HOMEPAGE, -1)=="/" ? "":"/");?>anmelden.php?uid=ref_<?php echo $session->uid; ?></span>

    <h3><?php echo (defined('LANG') && LANG === 'ar') ? 'تقدم أصدقائك المدعوين' : 'Progress of your invited friends'; ?></h3>

    <p><?php echo (defined('LANG') && LANG === 'ar') ? 'بمجرد أن يبني اللاعب الذي دعوته قريته <b>الثانية</b>، سيتم إضافة <b>50</b> ذهبة إلى حسابك.' : 'As soon as a player you invited has found his <b>2</b> village, you will be credited with <b>50</b> gold.'; ?></p>

    <table id="brought_in" cellpadding="1" cellspacing="1">
        <thead>
            <tr>
                <th colspan="6"><?php echo (defined('LANG') && LANG === 'ar') ? 'اللاعبون المدعوون' : 'Players brought in'; ?></th>
            </tr>
            <tr>
                <td>UID</td>

                <td><?php echo (defined('LANG') && LANG === 'ar') ? 'عضو منذ' : 'Member since'; ?></td>

                <td><?php echo (defined('LANG') && LANG === 'ar') ? 'السكان' : 'Inhabitants'; ?></td>

                <td><?php echo (defined('LANG') && LANG === 'ar') ? 'القرى' : 'Villages'; ?></td>
            </tr>
        </thead>
		<tbody>
		<?php
		$invite = $database->getInvitedUser($session->uid);
		if(count($invite) > 0){
		foreach($invite as $invited) {
		$varray = $database->getProfileVillages($invited['id']);
		$totalpop = 0;
		foreach($varray as $vil) {
		$totalpop += $vil['pop'];
		}
		?>
            <tr>
                <td><?php echo $invited['id']; ?></td>

                <td><?php echo date("j.m.y",$invited['regtime']); ?></td>

                <td><?php echo $totalpop; ?></td>

                <td><?php echo count($varray); ?></td>
            </tr>
		<?php
		}}else{
		?>
        <tr>
            <td class="none" colspan="6"><?php echo (defined('LANG') && LANG === 'ar') ? 'لم تقم بدعوة أي لاعبين بعد.' : 'You have not brought in any new players yet.'; ?></td>
        </tr>
		<?php } ?>
		</tbody>
        </table>
</div>
