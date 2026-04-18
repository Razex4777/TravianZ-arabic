<style type="text/css">
.red {
	color: #F00;
}
</style>
<h1><?php echo (defined('LANG') && LANG === 'ar') ? 'تاجر المبادلة (NPC)' : 'NPC Merchant'; ?></h1>
<?php echo (defined('LANG') && LANG === 'ar') ? 'سيقوم تاجر NPC بتبديل أي كمية من الموارد المطلوبة في القرية بموارد أخرى بنسبة 1:1.' : 'The NPC Merchant will exchange any desired amount of <?php echo (defined("LANG") && LANG === "ar") ? "موارد" : "resources"; ?> in a village with other <?php echo (defined("LANG") && LANG === "ar") ? "موارد" : "resources"; ?> at a ratio of 1:1.'; ?> <br>
<br>
<span class="red"><?php echo (defined('LANG') && LANG === 'ar') ? 'هذه الميزة غير مشمولة في نادي الذهب!' : 'This feature is NOT included in the gold club!'; ?></span>