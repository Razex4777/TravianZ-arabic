<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       special.tpl                                                 ##
##  Developed by:  Dzoki                                                       ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
##                                                                             ##
#################################################################################
?>


<table cellpadding="1" cellspacing="1" id="support_mh">
	<thead>
	<tr>
	<th><?php echo (defined('LANG') && LANG === 'ar') ? 'الدعم الفني ومتعدد الصيادين' : 'Support and Multihunter'; ?></th>
	</tr>
	</thead>
	<tbody>
	<tr>
	<td><b><?php echo (defined('LANG') && LANG === 'ar') ? 'الدعم الفني:' : 'Support:'; ?></b><br><?php echo (defined('LANG') && LANG === 'ar') ? 'الدعم الفني هو مجموعة من اللاعبين ذوي الخبرة الذين سيجيبون على أسئلتك بكل سرور.' : 'The support is a group of experienced players who will answer your questions gladly.'; ?><br />
	 <a href="nachrichten.php?t=1&amp;id=1">&raquo; <?php echo (defined('LANG') && LANG === 'ar') ? 'كتابة رسالة' : 'Write message'; ?></a>
	</td>
	</tr>
	<tr>
	<td><b><?php echo (defined('LANG') && LANG === 'ar') ? 'متعدد الصيادين:' : 'Multihunter:'; ?></b><br><?php echo (defined('LANG') && LANG === 'ar') ? 'متعدد الصيادين مسؤولون عن الالتزام بـ' : 'The Multihunters are responsible for the compliance with the'; ?> <a href="rules.php"><b><?php echo GAME_RULES;?></b></a><?php echo (defined('LANG') && LANG === 'ar') ? '. إذا كانت لديك أسئلة حول القوانين أو تريد الإبلاغ عن مخالفة، يمكنك مراسلة متعدد الصيادين.' : '. If you have questions about the rules or want to report a violation, you can message a Multihunter.'; ?><br />
	 <a href="nachrichten.php?t=1&amp;id=0">&raquo; <?php echo (defined('LANG') && LANG === 'ar') ? 'كتابة رسالة' : 'Write message'; ?></a>
	</td>
	</tr>
	</tbody>
	</table>
