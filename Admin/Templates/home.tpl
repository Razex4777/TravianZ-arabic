<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       home.tpl                                                    ##
##  Developed by:  Dzoki                                                       ##
##  Reworked:      aggenekech												   ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
##                                                                             ##
#################################################################################
?>
<font size="3">
	<b>
		<center>
			<?php echo (defined('LANG') && LANG === 'ar') ? 'مرحباً بك في' : 'WELCOME TO'; ?>
				<?php
				if($_SESSION['access'] == MULTIHUNTER)
				{
					echo (defined('LANG') && LANG === 'ar') ? 'متعدد الصيادين' : 'MULTIHUNTER';
				}
				else if($_SESSION['access'] == ADMIN)
				{
					echo (defined('LANG') && LANG === 'ar') ? 'المسؤول' : 'ADMINISTRATOR';
				} ?>
			<?php echo (defined('LANG') && LANG === 'ar') ? 'لوحة التحكم' : 'CONTROL PANEL'; ?>
		</center>
	</b>
</font>


<br /><br /><br /><br />

	<?php echo (defined('LANG') && LANG === 'ar') ? 'مرحباً' : 'Hello'; ?> <b><?php echo $_SESSION['admin_username']; ?></b>, <?php echo (defined('LANG') && LANG === 'ar') ? 'أنت مسجل الدخول بصفتك:' : 'You are logged in as:'; ?> <b><font color="Red"><?php echo (defined('LANG') && LANG === 'ar') ? 'مسؤول' : 'Administrator'; ?></font></b></center>
	<br /><br /><br />

	<br /><br /><br /><br /><br />


	<font color="#c5c5c5" size="1">
		Credits: Akakori & Elmar<br />
		Fixed, remade and new features added by <b>Dzoki</b><br />
		Reworked by <b>aggenkeech</b><br />
		Remaked by <b>Shadow</b>
	</font>
