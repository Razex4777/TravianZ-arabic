<?php			   
	//gp link
	if($session->gpack == null || GP_ENABLE == false) {
	$gpack= GP_LOCATE;
	} else {
	$gpack= $session->gpack;
	}


  
//de lintjes
/******************************
INDELING CATEGORIEEN:
===============================
== 1. Aanvallers top 10      ==
== 2. Defence top 10         ==
== 3. Klimmers top 10        ==
== 4. Overvallers top 10     ==
== 5. In att en def tegelijk ==
== 6. in top 3 - aanval      ==
== 7. in top 3 - verdediging ==
== 8. in top 3 - klimmers    ==
== 9. in top 3 - overval     ==
******************************/
//$geregistreerd=date('d.m.Y', ($allianceinfo['timestamp']));

$profiel = preg_replace("/\[war]/s",((defined('LANG') && LANG === 'ar') ? 'في حرب مع' : 'At war with').'<br>'.$database->getAllianceWar($aid), $profiel, 1); 
$profiel = preg_replace("/\[ally]/s",((defined('LANG') && LANG === 'ar') ? 'تحالفات' : 'Confederacies').'<br>'.$database->getAllianceDipProfile($aid,1), $profiel, 1); 
$profiel = preg_replace("/\[nap]/s",((defined('LANG') && LANG === 'ar') ? 'مواثيق عدم اعتداء' : 'NAPs').'<br>'.$database->getAllianceDipProfile($aid,2), $profiel, 1); 
$profiel = preg_replace("/\[diplomatie]/s",((defined('LANG') && LANG === 'ar') ? 'تحالفات' : 'Confederacies').'<br>'.$database->getAllianceDipProfile($aid,1).'<br>'.((defined('LANG') && LANG === 'ar') ? 'مواثيق عدم اعتداء' : 'NAPs').'<br>'.$database->getAllianceDipProfile($aid,2).'<br>'.((defined('LANG') && LANG === 'ar') ? 'في حرب مع' : 'At war with').'<br>'.$database->getAllianceWar($aid), $profiel, 1); 


foreach($varmedal as $medal) {

switch ($medal['categorie']) {
    case "1":
        $titel=(defined('LANG') && LANG === 'ar') ? 'مهاجمو الأسبوع' : "Attackers of the Week";
		$woord=(defined('LANG') && LANG === 'ar') ? 'النقاط' : "Points";
        break;
    case "2":
        $titel=(defined('LANG') && LANG === 'ar') ? 'مدافعو الأسبوع' : "Defenders of the Week";
 		$woord=(defined('LANG') && LANG === 'ar') ? 'النقاط' : "Points";
       break;
    case "3":
        $titel=(defined('LANG') && LANG === 'ar') ? 'متسلقو الأسبوع (الرتب)' : "Climbers of the week(Ranks)";
 		$woord=(defined('LANG') && LANG === 'ar') ? 'الرتب' : "Ranks";
       break;
    case "4":
        $titel=(defined('LANG') && LANG === 'ar') ? 'ناهبو الأسبوع' : "Robbers of the week";
		$woord=(defined('LANG') && LANG === 'ar') ? 'الموارد' : "Resources";
        break;
	 case "5":
        $titel=(defined('LANG') && LANG === 'ar') ? 'الحصول على هذا الوسام يظهر أن تحالفك كان ضمن أفضل 3 مهاجمين ومدافعين لهذا الأسبوع.' : "Receiving this medal shows that your alliance was in the top 3 of both attacckers and defenders of the week.";
        $bonus[$medal['id']]=1;
		break;
	 case "6":
        $titel=(defined('LANG') && LANG === 'ar') ? 'الحصول على هذا الوسام يظهر أن تحالفك كان ضمن أفضل 3 مهاجمين للأسبوع '.$medal['points'].' على التوالي' : "Receiving this medal shows that your alliance was in the top 3 of the attackers of the week ".$medal['points']." in a row";
        $bonus[$medal['id']]=1;
		break;
	 case "7":
        $titel=(defined('LANG') && LANG === 'ar') ? 'الحصول على هذا الوسام يظهر أن تحالفك كان ضمن أفضل 3 مدافعين للأسبوع '.$medal['points'].' على التوالي' : "Receiving this medal shows that your alliance was in the top 3 of the deffenders of the week ".$medal['points']." in a row";
        $bonus[$medal['id']]=1;
		break;
	 case "8":
        $titel=(defined('LANG') && LANG === 'ar') ? 'الحصول على هذا الوسام يظهر أن تحالفك كان ضمن أفضل 3 متسلقين للأسبوع '.$medal['points'].' على التوالي.' : "Receiving this medal shows that your alliance was in the top 3 of the rank climbers of the week ".$medal['points']." in a row.";
        $bonus[$medal['id']]=1;
		break;
	 case "9":
        $titel=(defined('LANG') && LANG === 'ar') ? 'الحصول على هذا الوسام يظهر أن تحالفك كان ضمن أفضل 3 ناهبين للأسبوع '.$medal['points'].' على التوالي.' : "Receiving this medal shows that your alliance was in the top 3 of the robbers of the week ".$medal['points']." in a row.";
        $bonus[$medal['id']]=1;
		break;
    case "11":
        $titel=(defined('LANG') && LANG === 'ar') ? 'الحصول على هذا الوسام يظهر أنك كنت ضمن أفضل 3 متسلقين للأسبوع '.$medal['points'].' على التوالي.' : "Receiving this medal shows that you were in the top 3 of the Rank Climbers of the week ".$medal['points']." in a row.";
        $bonus[$medal['id']]=1;
        break;
         case "12":
        $titel=(defined('LANG') && LANG === 'ar') ? 'الحصول على هذا الوسام يظهر أنك كنت ضمن أفضل 10 مهاجمين للأسبوع '.$medal['points'].' على التوالي.' : "Receiving this medal shows that you were in the top 10 Attackers of the week ".$medal['points']." in a row.";
        $bonus[$medal['id']]=1;
        break;
        case "13":
        $titel=(defined('LANG') && LANG === 'ar') ? 'الحصول على هذا الوسام يظهر أنك كنت ضمن أفضل 10 مدافعين للأسبوع '.$medal['points'].' على التوالي.' : "Receiving this medal shows that you were in the top 10 Defenders of the week ".$medal['points']." in a row.";
        $bonus[$medal['id']]=1;
        break;
        case "15":
        $titel=(defined('LANG') && LANG === 'ar') ? 'الحصول على هذا الوسام يظهر أنك كنت ضمن أفضل 10 ناهبين للأسبوع '.$medal['points'].' على التوالي.' : "Receiving this medal shows that you were in the top 10 Robbers of the week ".$medal['points']." in a row.";
        $bonus[$medal['id']]=1;
        break;
        case "16":
        $titel=(defined('LANG') && LANG === 'ar') ? 'الحصول على هذا الوسام يظهر أنك كنت ضمن أفضل 10 متسلقين للأسبوع '.$medal['points'].' على التوالي.' : "Receiving this medal shows that you were in the top 10 Rank Climbers of the week ".$medal['points']." in a row.";
        $bonus[$medal['id']]=1;
        break;

}

if(isset($bonus[$medal['id']])){
$profiel = preg_replace("/\[#".$medal['id']."]/is",'<img src="'.$gpack.'img/t/'.$medal['img'].'.jpg" border="0" onmouseout="med_closeDescription()" onmousemove="med_mouseMoveHandler(arguments[0],\'<table><tr><td>'.$titel.'<br /><br />'.((defined('LANG') && LANG === 'ar') ? 'تم الحصول عليه في الأسبوع:' : 'Received in week:').' '.$medal['week'].'</td></tr></table>\')">', $profiel, 1);
} else {
$profiel = preg_replace("/\[#".$medal['id']."]/is",'<img src="'.$gpack.'img/t/'.$medal['img'].'.jpg" border="0" onmouseout="med_closeDescription()" onmousemove="med_mouseMoveHandler(arguments[0],\'<table><tr><td>'.((defined('LANG') && LANG === 'ar') ? 'الفئة:' : 'Category:').'</td><td>'.$titel.'</td></tr><tr><td>'.((defined('LANG') && LANG === 'ar') ? 'الأسبوع:' : 'Week:').'</td><td>'.$medal['week'].'</td></tr><tr><td>'.((defined('LANG') && LANG === 'ar') ? 'الرتبة:' : 'Rank:').'</td><td>'.$medal['plaats'].'</td></tr><tr><td>'.$woord.':</td><td>'.$medal['points'].'</td></tr></table>\')">', $profiel, 1);
}
}



?>

