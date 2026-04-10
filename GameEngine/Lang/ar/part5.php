<?php
//Admin setting - Admin/Templates/config.tpl & editLogSet.tpl
define('LOG_SETT', 'إعدادات السجل');
define('EDIT_LOG_SETT', 'تعديل إعدادات السجل');
define('CONF_LOG_BUILD', 'سجل البناء');
define('CONF_LOG_BUILD_TOOLTIP', 'تفعيل السجل لأوامر البناء في القرية.');
define('CONF_LOG_TECHNOLOGY', 'سجل التقنية');
define('CONF_LOG_TECHNOLOGY_TOOLTIP', 'تفعيل السجل للأبحاث وتطوير القوات.');
define('CONF_LOG_LOGIN', 'سجل الدخول');
define('CONF_LOG_LOGIN_TOOLTIP', 'تفعيل السجل لدخول اللاعبين.');
define('CONF_LOG_GOLD', 'سجل الذهب');
define('CONF_LOG_GOLD_TOOLTIP', 'تفعيل السجل لإنفاق الذهب المالي.');
define('CONF_LOG_ADMIN', 'سجل الإدارة');
define('CONF_LOG_ADMIN_TOOLTIP', 'تفعيل السجل لأعمال الإدارة ونشاطها.');
define('CONF_LOG_WAR', 'سجل الهجمات');
define('CONF_LOG_WAR_TOOLTIP', 'تفعيل السجل لهجمات اللاعبين.');
define('CONF_LOG_MARKET', 'سجل السوق');
define('CONF_LOG_MARKET_TOOLTIP', 'تفعيل السجل لنشاط السوق.');
define('CONF_LOG_ILLEGAL', 'سجل العمليات غير الشرعية');
define('CONF_LOG_ILLEGAL_TOOLTIP', 'تفعيل سجل العمليات المشبوهة.');

//Admin setting - Admin/Templates/config.tpl & editNewsboxSet.tpl
define('NEWSBOX_SETT', 'إعدادات صندوق الأخبار');
define('EDIT_NEWSBOX_SETT', 'تعديل إعدادات صندوق الأخبار');
define('EDIT_NEWSBOX1', 'صندوق الأخبار 1');
define('EDIT_NEWSBOX1_TOOLTIP', 'تفعيل ظهور صندوق الأخبار 1.');
define('EDIT_NEWSBOX2', 'صندوق الأخبار 2');
define('EDIT_NEWSBOX2_TOOLTIP', 'تفعيل ظهور صندوق الأخبار 2.');
define('EDIT_NEWSBOX3', 'صندوق الأخبار 3');
define('EDIT_NEWSBOX3_TOOLTIP', 'تفعيل ظهور صندوق الأخبار 3.');

//Admin setting - Admin/Templates/config.tpl SQL Settings
define('SQL_SETTINGS', 'إعدادات قاعدة البيانات');
define('CONF_SQL_HOSTNAME', 'اسم المضيف');
define('CONF_SQL_HOSTNAME_TOOLTIP', 'اسم المضيف للسيرفر (عادة: localhost).');
define('CONF_SQL_PORT', 'المنفذ');
define('CONF_SQL_PORT_TOOLTIP', 'المنفذ لربط قواعد البيانات عادة: 3306.');
define('CONF_SQL_DBUSER', 'اسم مستخدم القاعدة');
define('CONF_SQL_DBUSER_TOOLTIP', 'اسم المستخدم لاتصال قاعدة البيانات.');
define('CONF_SQL_DBPASS', 'كلمة سر القاعدة');
define('CONF_SQL_DBPASS_TOOLTIP', 'كلمة المرور الخاصة بقاعدة البيانات.');
define('CONF_SQL_DBNAME', 'اسم قاعدة البيانات');
define('CONF_SQL_DBNAME_TOOLTIP', 'اسم قاعدة البيانات.');
define('CONF_SQL_TBPREFIX', 'بادئة الجداول');
define('CONF_SQL_TBPREFIX_TOOLTIP', 'البادئة المستخدمة لمسميات الجداول.');
define('CONF_SQL_DBTYPE', 'نوع قاعدة البيانات');
define('CONF_SQL_DBTYPE_TOOLTIP', 'نوع قاعدة البيانات المستخدمة.');

//Admin setting - Admin/Templates/config.tpl & editExtraSet.tpl
define('EXTRA_SETT', 'إعدادات إضافية');
define('EDIT_EXTRA_SETT', 'تعديل إعدادات إضافية');
define('CONF_EXTRA_LIMITMAIL', 'تحديد صندوق البريد');
define('CONF_EXTRA_LIMITMAIL_TOOLTIP', 'تفعيل عدد محدد للرسائل بالبريد.');
define('CONF_EXTRA_MAXMAIL', 'أقصى عدد للرسائل');
define('CONF_EXTRA_MAXMAIL_TOOLTIP', 'أقصى عدد من الرسائل يمكن أن يحويه صندوق البريد.');

//Admin setting - Admin/Templates/config.tpl & editAdminInfo.tpl
define('ADMIN_INFO', 'معلومات الإدارة');
define('EDIT_ADMIN_INFO', 'تعديل معلومات الإدارة');
define('CONF_ADMIN_NAME', 'اسم الإدارة');
define('CONF_ADMIN_NAME_TOOLTIP', 'اسم حساب الإدارة.');
define('CONF_ADMIN_EMAIL', 'بريد الإدارة');
define('CONF_ADMIN_EMAIL_TOOLTIP', 'بريد الإدارة للتواصل.');
define('CONF_ADMIN_SHOWSTATS', 'تضمين الإدارة بالإحصائيات');
define('CONF_ADMIN_SHOWSTATS_TOOLTIP', 'السماح لظهور إدارة اللعبة بالإحصائيات.');
define('CONF_ADMIN_SUPPMESS', 'تضمين رسائل الدعم');
define('CONF_ADMIN_SUPPMESS_TOOLTIP', 'إرسال رسائل المساعدة لبريد المدير.');
define('CONF_ADMIN_RAIDATT', 'السماح بالهجوم على المدير');
define('CONF_ADMIN_RAIDATT_TOOLTIP', 'السماح للاعبين بالهجوم ونهب إدارة اللعبة.');

/*
|--------------------------------------------------------------------------
|   Index
|--------------------------------------------------------------------------
*/

$lang['index'][0][1] = 'مرحباً في سيرفر '.SERVER_NAME;
$lang['index'][0][2] = 'دليل اللعبة';
$lang['index'][0][3] = 'العب الآن مجاناً!';
$lang['index'][0][4] = 'ما هي '.SERVER_NAME;
$lang['index'][0][5] = SERVER_NAME.' هي <b>لعبة متصفح</b> تتميز بعالم قديم مع آلاف اللاعبين الآخرين.</p><p>إنها <strong>مجانية للعب</strong> ولا تتطلب <strong>أي تحميل</strong>.';
$lang['index'][0][6] = 'انقر هنا للعب '.SERVER_NAME;
$lang['index'][0][7] = 'إجمالي اللاعبين';
$lang['index'][0][8] = 'اللاعبون الفعالون';
$lang['index'][0][9] = 'اللاعبون المتصلون';
$lang['index'][0][10] = 'عن اللعبة';
$lang['index'][0][11] = 'ستبدأ كرئيس لقرية صغيرة وتنطلق في مغامرة مثيرة.';
$lang['index'][0][12] = 'قم ببناء القرى، خض الحروب أو أسس طرق التجارة مع جيرانك.';
$lang['index'][0][13] = 'العب مع وضد آلاف اللاعبين الآخرين واحكم عالم ترافيان.';
$lang['index'][0][14] = 'الأخبار';
$lang['index'][0][15] = 'الأسئلة الشائعة (FAQ)';
$lang['index'][0][16] = 'الصور';
$lang['forum'] = 'المنتدى';
$lang['register'] = 'التسجيل';
$lang['login'] = 'تسجيل الدخول';
$lang['screenshots']['title1'] = 'القرية';
$lang['screenshots']['desc1'] = 'بناء القرية';
$lang['screenshots']['title2'] = 'الموارد';
$lang['screenshots']['desc2'] = 'الموارد الخشب، الطين، الحديد والقمح';
$lang['screenshots']['title3'] = 'الخريطة';
$lang['screenshots']['desc3'] = 'موقع قريتك على الخريطة';
$lang['screenshots']['title4'] = 'المباني';
$lang['screenshots']['desc4'] = 'كيف تبني المباني أو تطور حقول الموارد';
$lang['screenshots']['title5'] = 'التقارير';
$lang['screenshots']['desc5'] = 'تقارير الهجوم الخاصة بك';
$lang['screenshots']['title6'] = 'الإحصائيات';
$lang['screenshots']['desc6'] = 'عرض مركزك في ترتيب الإحصائيات';
$lang['screenshots']['title7'] = 'اقتصاد أو جيش';
$lang['screenshots']['desc7'] = 'يمكنك اختيار اللعب بشكل العسكريين أو الاقتصاديين';

// Added for Anleitung submenu
define('TRIBES', 'القبائل');
define('BUILDINGS', 'المباني');
