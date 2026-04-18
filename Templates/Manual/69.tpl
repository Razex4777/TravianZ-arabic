<style type="text/css">
.hall {
	color: #808080;
}
</style>
<h1><?php echo (defined('LANG') && LANG === 'ar') ? 'نادي الذهب' : 'Gold club'; ?></h1>
<?php echo (defined('LANG') && LANG === 'ar') ? 'سيتم محاسبتك مرة واحدة فقط للدخول في نادي الذهب. بعد ذلك، يمكنك الوصول إلى ميزات حصرية متنوعة. بعض هذه الميزات الحصرية مجانية، بينما تكلف الأخرى مبلغاً معيناً من الذهب في كل استخدام.' : 'You will only be charged once for entry into Gold club. Afterwards you have access to various exclusive features. Some of the exclusive features are free, others cost a defined amount of gold per use.'; ?><br>
<br>
<strong><?php echo (defined('LANG') && LANG === 'ar') ? 'ميزات نادي الذهب المجانية:' : 'Free Gold club features:'; ?></strong>
<ul>
    <li><?php echo (defined('LANG') && LANG === 'ar') ? 'قائمة المزارع' : 'Raid list'; ?></li>
    <li><?php echo (defined('LANG') && LANG === 'ar') ? 'إحصائيات الغنائم' : 'Raid statistics'; ?></li>
    <li><?php echo (defined('LANG') && LANG === 'ar') ? 'جعل التجار يذهبون ثلاث مرات' : 'Let merchants go thrice'; ?></li>
    <li><?php echo (defined('LANG') && LANG === 'ar') ? 'البحث عن القرى ذات الـ 9 و 15 حقل قمح بما في ذلك الواحات' : 'Search for 9 and 15 croppers including oases'; ?></li>
</ul>
<strong><?php echo (defined('LANG') && LANG === 'ar') ? 'ميزات نادي الذهب المدفوعة:' : 'Priced Gold club features:'; ?></strong>
<ul>
    <li><?php echo (defined('LANG') && LANG === 'ar') ? 'تعيين بنّاء رئيسي بحد يصل إلى 3 أوامر بناء' : 'Assign master builder up to 3 construction orders'; ?></li>
    <li><?php echo (defined('LANG') && LANG === 'ar') ? 'خطوط تجارية تلقائية بين قراك' : 'Automated trade routes between your own villages'; ?></li>
    <li><?php echo (defined('LANG') && LANG === 'ar') ? 'إخفاء القوات من الهجمات في الغابة' : 'Hide troops from attacks in the forest'; ?><br><span class="hall"><?php echo (defined('LANG') && LANG === 'ar') ? '(ممكن فقط في حال لم تعد أي قوات في الثواني الـ <strong>10</strong> الأخيرة)' : '(only possible if in the last <strong>10</strong> seconds no troops came home)'; ?></span></li>
</ul>