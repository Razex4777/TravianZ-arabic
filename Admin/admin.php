<?php
#################################################################################
##                                                                             ##
##              -= YOU MUST NOT REMOVE OR CHANGE THIS NOTICE =-                ##
##                                                                             ##
## --------------------------------------------------------------------------- ##
##                                                                             ##
##  Project:       TravianZ                                                    ##
##  Version:       05.03.2014                                                  ##
##  Filename:      Admin/admin.php     				                           ##
##  Developed by:  Dzoki                                                       ##
##  Edited by:     Shadow and ronix                                            ##
##  License:       Creative Commons BY-NC-SA 3.0                               ##
##  Copyright:     TravianZ (c) 2014 - All rights reserved                     ##
##  URLs:          http://travian.shadowss.ro                                  ##
##  Source code:   https://github.com/Shadowss/TravianZ	                       ##
##                                                                             ##
#################################################################################

session_start();
include_once("../GameEngine/config.php");
include_once("../GameEngine/Database.php");
include_once ("../GameEngine/Lang/" . LANG . ".php");
include_once("../GameEngine/Admin/database.php");
include_once("../GameEngine/Data/buidata.php");
include_once("../GameEngine/Artifacts.php");

include('Templates/ver.tpl');
include('Templates/update_latest.tpl');
$up_avl = $latest - $ver ;

$subpage = 'Login';
$not_include_mootools_js = false;

if (!empty($_GET['p'])) {
    switch ($_GET['p']) {
        case 'server_info':
            $subpage = 'Server Info';
            break;

        case 'online':
            $subpage = 'Online Users';
            break;

        case 'notregistered':
            $subpage = 'Players Not Activated';
            break;

        case 'inactive':
            $subpage = 'Players Inactivate';
            break;

        case 'report':
            $subpage = 'Players Report';
            break;
            
        case 'message':
            $subpage = 'Players Message';
            break;

        case 'map':
            $subpage = 'Map';
            break;
        
		case 'map_tile':
			$subpage = 'Map Tile';
			$not_include_mootools_js = true;
			break;	
			
        case 'natars':
            $subpage = 'Natars Management';
            break;

        case 'search':
            $subpage = 'General Search';
            break;

        case 'message':
            $subpage = 'Search IGMs/Reports';
            break;

        case 'ban':
            $subpage = 'Ban/Unban Players';
            break;

        case 'maintenance':
            $subpage = 'Server Maintenance';
            break;

        case 'cleanban':
            $subpage = 'Clean Banlist Data';
            break;

        case 'gold':
            $subpage = 'Give All Free Gold';
            break;

        case 'usergold':
            $subpage = 'Give Free Gold To Specific User';
            break;

        case 'maintenenceResetGold':
            $subpage = 'Reset Gold';
            break;

        case 'delmedal':
            $subpage = 'Delete Player Medals';
            break;

        case 'delallymedal':
            $subpage = 'Delete Ally Medals';
            break;

        case 'givePlus':
            $subpage = 'Give All Plus';
            break;

        case 'maintenenceResetPlus':
            $subpage = 'Reset Plus';
            break;

        case 'givePlusRes':
            $subpage = 'Give All Res Bonus';
            break;

        case 'maintenenceResetPlusBonus':
            $subpage = 'Reset Res Bonus';
            break;

        case 'addUsers':
            $subpage = 'Create Users';
            break;

        case 'users':
            $subpage = 'Users List';
            break;

        case 'admin_log':
            $subpage = 'Admin Log';
            break;

        case 'config':
            $subpage = 'Server Settings';
            break;

        case 'editServerSet':
            $subpage = 'Server Configuration';
            break;

        case 'editPlusSet':
            $subpage = 'PLUS Settings';
            break;

        case 'editLogSet':
            $subpage = 'Log Settings';
            break;

        case 'editNewsboxSet':
            $subpage = 'NewsBox Settings';
            break;

        case 'editExtraSet':
            $subpage = 'Extra Settings';
            break;

        case 'editAdminInfo':
            $subpage = 'Edit Admin Information';
            break;

        case 'resetServer':
            $subpage = 'Server Resetting';
            break;

        case 'player':
            if (!empty($_GET['uid'])) {
                $displayarray = $database->getUserArray($_GET['uid'],1);
                $user=$displayarray;
                $subpage = 'Player Details ('.$user['username'].')';
            } else {
                $subpage = 'Player Details (no player)';
            }
            break;

        case 'editUser':
            if (!empty($_GET['uid'])) {
                $user = $database->getUserArray($_GET['uid'],1);
                $subpage = 'Edit Player ('.$user['username'].')';
            } else {
                $subpage = 'Edit Player (no player)';
            }
            break;

        case 'deletion':
            if (!empty($_GET['uid'])) {
                $user = $database->getUserArray($_GET['uid'],1);
                $subpage = 'Delete Player ('.$user['username'].')';
            } else {
                $subpage = 'Delete Player (no player)';
            }
            break;

        case 'Newmessage':
            if (!empty($_GET['uid'])) {
                $user = $database->getUserArray($_GET['uid'],1);
                $subpage = 'Compose Message ('.$user['username'].')';
            } else {
                $subpage = 'Compose Message';
            }
            break;

        case 'editPlus':
            if (!empty($_GET['uid'])) {
                $user = $database->getUserArray($_GET['uid'],1);
                $subpage = 'Edit Plus &amp; Resources  ('.$user['username'].')';
            } else {
                $subpage = 'Edit Plus &amp; Resources';
            }
            break;

        case 'editSitter':
            if (!empty($_GET['uid'])) {
                $user = $database->getUserArray($_GET['uid'],1);
                $subpage = 'Edit Sitters ('.$user['username'].')';
            } else {
                $subpage = 'Edit Sitters ';
            }
            break;

        case 'editOverall':
            if (!empty($_GET['uid'])) {
                $user = $database->getUserArray($_GET['uid'],1);
                $subpage = 'Edit Off &amp; Def ('.$user['username'].')';
            } else {
                $subpage = 'Edit Off &amp; Def';
            }
            break;

        case 'editWeek':
            if (!empty($_GET['uid'])) {
                $user = $database->getUserArray($_GET['uid'],1);
                $subpage = 'Edit Weekly Off &amp; Def ('.$user['username'].')';
            } else {
                $subpage = 'Edit Weekly Off &amp; Def';
            }
            break;

        case 'userlogin':
            if (!empty($_GET['uid'])) {
                $player = mysqli_fetch_assoc(mysqli_query($GLOBALS["link"], "SELECT * FROM ".TB_PREFIX."users WHERE id = ".(int) $_GET['uid']));
                $subpage = 'User Logins ('.$player['username'].')';
            } else {
                $subpage = 'User Logins (no player)';
            }
            break;

        case 'userillegallog':
            if (!empty($_GET['uid'])) {
                $player = mysqli_fetch_assoc(mysqli_query($GLOBALS["link"], "SELECT * FROM ".TB_PREFIX."users WHERE id = ".(int) $_GET['uid']));
                $subpage = 'User Illegals Log ('.$player['username'].')';
            } else {
                $subpage = 'User Illegals Log (no player)';
            }
            break;

        case 'editHero':
            if (!empty($_GET['uid'])) {
                $user = $database->getUserArray($_GET['uid'],1);
                $subpage = 'Edit Hero ('.$user['username'].')';
            } else {
                $subpage = 'Edit Hero';
            }
            break;

        case 'editAdditional':
            if (!empty($_GET['uid'])) {
                $user = $database->getUserArray($_GET['uid'],1);
                $subpage = 'Edit Additional Info ('.$user['username'].')';
            } else {
                $subpage = 'Edit Additional Info';
            }
            break;

        case 'village':
            if (!empty($_GET['did'])) {
                $village = $database->getVillage($_GET['did']);
                $user = $database->getUserArray($village['owner'],1);
                $subpage = 'Edit Village ('.$village['name'].' &raquo; '.$user['username'].')';
            } else {
                $subpage = 'Edit Village (no village)';
            }
            break;

        case 'editCrops':
            if (!empty($_GET['did'])) {
                $village = $database->getVillage($_GET['did']);
                $user = $database->getUserArray($village['owner'],1);
                $subpage = 'Build Cropper ('.$village['name'].' &raquo; '.$user['username'].')';
            } else {
                $subpage = 'Build Cropper (no village)';
            }
            break;

        case 'editResources':
            if (!empty($_GET['did'])) {
                $village = $database->getVillage($_GET['did']);
                $user = $database->getUserArray($village['owner'],1);
                $subpage = 'Edit Resources ('.$village['name'].' &raquo; '.$user['username'].')';
            } else {
                $subpage = 'Edit Resources (no village)';
            }
            break;

        case 'addTroops':
            if (!empty($_GET['did'])) {
                $village = $database->getVillage($_GET['did']);
                $user = $database->getUserArray($village['owner'],1);
                $subpage = 'Edit Troops ('.$village['name'].' &raquo; '.$user['username'].')';
            } else {
                $subpage = 'Edit Troops (no village)';
            }
            break;

        case 'addABTroops':
            if (!empty($_GET['did'])) {
                $village = $database->getVillage($_GET['did']);
                $user = $database->getUserArray($village['owner'],1);
                $subpage = 'Upgrade Troops ('.$village['name'].' &raquo; '.$user['username'].')';
            } else {
                $subpage = 'Upgrade Troops (no village)';
            }
            break;

        case 'editVillage':
            if (!empty($_GET['did'])) {
                $village = $database->getVillage($_GET['did']);
                $user = $database->getUserArray($village['owner'],1);
                $subpage = 'Edit Village ('.$village['name'].' &raquo; '.$user['username'].')';
            } else {
                $subpage = 'Edit Village (no village)';
            }
            break;

        case 'villagelog':
            if (!empty($_GET['did'])) {
                $village = $database->getVillage($_GET['did']);
                $user = $database->getUserArray($village['owner'],1);
                $subpage = 'Build Log ('.$village['name'].' &raquo; '.$user['username'].')';
            } else {
                $subpage = 'Build Log (no village)';
            }
            break;

        case 'techlog':
            if (!empty($_GET['did'])) {
                $village = $database->getVillage($_GET['did']);
                $user = $database->getUserArray($village['owner'],1);
                $subpage = 'Research Log ('.$village['name'].' &raquo; '.$user['username'].')';
            } else {
                $subpage = 'Research Log (no village)';
            }
            break;
    }
}

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="shortcut icon" href="favicon.ico"/>
		<title>Admin Panel - <?php echo $subpage; ?></title>
		<link rel="stylesheet" type="text/css" href="../img/admin/admin.css">
		<link rel="stylesheet" type="text/css" href="../img/admin/acp.css">
		<link rel="stylesheet" type="text/css" href="../img/admin/admin_mobile.css">
		<link rel="stylesheet" type="text/css" href="../img/img.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
		<script type="text/javascript" src="jquery.cookie.js"></script>
		<?php
		if($not_include_mootools_js){}else{
		?>
		<script type="text/javascript" src="/mt-full.js?423cb"></script>
		<script type="text/javascript" src="ajax.js"></script>
		<script type="text/javascript" src="../new.js?0faab"></script>
		<?php
		}
		?>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="imagetoolbar" content="no">
	</head>
	<body>
    <script type="text/javascript">
                init_local();
                function getMouseCoords(e) {
                    var coords = {};
                    if (!e) var e = window.event;
                    if (e.pageX || e.pageY)     {
                        coords.x = e.pageX;
                        coords.y = e.pageY;
                    }
                    else if (e.clientX || e.clientY)     {
                        coords.x = e.clientX + document.body.scrollLeft
                            + document.documentElement.scrollLeft;
                        coords.y = e.clientY + document.body.scrollTop
                            + document.documentElement.scrollTop;
                    }
                    return coords;
                }

                function med_mouseMoveHandler(e, desc_string){
                    var coords = getMouseCoords(e);
                    med_showDescription(coords, desc_string);
                }

                function med_closeDescription(){
                    var layer = document.getElementById("medal_mouseover");
                    layer.className = "hide";
                }

                function init_local(){
                    med_init();
                }

                function med_init(){
                    layer = document.createElement("div");
                    layer.id = "medal_mouseover";
                    layer.className = "hide";
                    document.body.appendChild(layer);
                }

                function med_showDescription(coords, desc_string){
                    var layer = document.getElementById("medal_mouseover");
                    layer.style.top = (coords.y + 25)+ "px";
                    layer.style.left = (coords.x - 20) + "px";
                    layer.className = "";
                    layer.innerHTML = desc_string;
                }
               </script>
		<script language="javascript">
			function aktiv() {this.srcElement.className='fl1'; }
			function inaktiv() {event.srcElement.className='fl2'; }

			function del(e,id){
				if(e == 'arti'){ var conf = confirm('Dou you really want delete artifact id '+id+'?'); }
				if(e == 'did'){ var conf = confirm('Dou you really want delete village id '+id+'?'); }
				if(e == 'unban'){ var conf = confirm('Dou you really want unban player '+id+'?'); }
				if(e == 'stopDel'){ var conf = confirm('Dou you really want stop deleting user '+id+'?'); }
				if(e == 'oas'){ var conf = confirm('Dou you really want to delete oasis id '+id+'?'); }
				return conf;
			}
		</script>
		<script type="text/javascript">
			function showStuff(id) {
				document.getElementById(id).style.display = 'block';
			}
			function hideStuff(id) {
				document.getElementById(id).style.display = 'none';
			}
			function go_url(url) {
				location=url;
				return(false);
			}

		</script>
		<!-- Start Accordeon Menu -->
		<script type="text/javascript">
		$(document).ready(function () {
			var checkCookie = $.cookie("sub-nav");
			if (checkCookie != "") {
				$('#menu > li.sub > a:eq('+checkCookie+')').addClass('active').next().show();
			}
			$('#menu > li.sub > a').click(function(){
				var navIndex = $('#menu > li.sub > a').index(this);
				$.cookie("sub-nav", navIndex);
				$('#menu li ul').slideUp();
				if ($(this).next().is(":visible")){
					$(this).next().slideUp();
				} else {
					$(this).next().slideToggle();
				}
				return false;
				$('#menu li a').removeClass('active');
				$(this).addClass('active');
			});
			var checkCookie = $.cookie("sub-link");
			if (checkCookie != "") {
				$('#menu > li.sub > ul li a:eq('+checkCookie+')').addClass('active');
			}
			$('.sub ul li a').click(function(){
				var subIndex = $('.sub ul li a').index(this);
				$.cookie("sub-link", subIndex);
				$('.sub ul li a').removeClass('active');
				$(this).addClass('active');
			});
		});
		</script>
		<!-- End Accordeon Menu -->
		<div id="ltop1">
			<div style="position:relative; height:100px; float:left;">
				<img src="../img/x.gif" width="1" height="1">
			</div>
			<p class="center-img">
				<img class="fl2" src="../img/admin/x1.gif" width="70" height="100" border="0" onmouseover="this.className='fl1'" onmouseout="this.className='fl2'">
				<img class="fl2" src="../img/admin/x2.gif" width="70" height="100" border="0" onmouseover="this.className='fl1'" onmouseout="this.className='fl2'">
				<img class="fl2" src="../img/admin/x3.gif" width="70" height="100" border="0" onmouseover="this.className='fl1'" onmouseout="this.className='fl2'">
				<img class="fl2" src="../img/admin/x4.gif" width="70" height="100" border="0" onmouseover="this.className='fl1'" onmouseout="this.className='fl2'">
				<img class="fl2" src="../img/admin/x5.gif" width="70" height="100" border="0" onmouseover="this.className='fl1'" onmouseout="this.className='fl2'">
			</p>
		</div>
		<div id="lmidall">
			<div id="lmidlc">
				<div id="lleft">
					<p class="center-img">
						<a href="<?php echo HOMEPAGE; ?>"><img src="../img/en/a/travian0.gif" class="logo_plus" width="116" height="60" border="0"></a>
					</p>
					<!-- Start Accordeon Menu -->
					<?php
						if($funct->CheckLogin())
						{
							if($_SESSION['access'] == ADMIN)
							{
					?>
					<ul id="menu">
						<li><a href="<?php echo HOMEPAGE; ?>"><?php echo (defined('LANG') && LANG === 'ar') ? 'الصفحة الرئيسية' : 'Server Homepage'; ?></a></li>
						<li><a href="admin.php"><?php echo (defined('LANG') && LANG === 'ar') ? 'لوحة التحكم' : 'Control Panel Home'; ?></a></li>
						<li><a href="<?php echo rtrim(SERVER, '/'); ?>/dorf1.php"><?php echo (defined('LANG') && LANG === 'ar') ? 'العودة إلى السيرفر' : 'Return to the server'; ?></a></li>
						<!--<li><a href="?p=update"><font color="Red"><b>Server Update (<?php echo $up_avl; ?>)</b></font></a></li>-->
						<li><a href="?action=logout"><?php echo (defined('LANG') && LANG === 'ar') ? 'تسجيل الخروج' : 'Logout'; ?></a></li>
						<li class="sub"><a href="#"><?php echo (defined('LANG') && LANG === 'ar') ? 'معلومات السيرفر' : 'Server Info'; ?></a>
							<ul>
								<li><a href="?p=server_info"><?php echo (defined('LANG') && LANG === 'ar') ? 'معلومات السيرفر' : 'Server Info'; ?></a></li>
								<li><a href="?p=online"><?php echo (defined('LANG') && LANG === 'ar') ? 'اللاعبون المتصلون' : 'Online Users'; ?></a></li>
								<li><a href="?p=notregistered"><?php echo (defined('LANG') && LANG === 'ar') ? 'لاعبون غير مفعلين' : 'Players Not Activated'; ?></a></li>
								<li><a href="?p=inactive"><?php echo (defined('LANG') && LANG === 'ar') ? 'لاعبون غير نشطين' : 'Players Inactivate'; ?></a></li>
								<li><a href="?p=report"><?php echo (defined('LANG') && LANG === 'ar') ? 'تقارير اللاعبين' : 'Players Report'; ?></a></li>
								<li><a href="?p=msg"><?php echo (defined('LANG') && LANG === 'ar') ? 'رسائل اللاعبين' : 'Players Message'; ?></a></li>
								<li><a href="?p=map"><?php echo (defined('LANG') && LANG === 'ar') ? 'الخريطة' : 'Map'; ?></a></li>
								<li><a href="?p=map_tile"><?php echo (defined('LANG') && LANG === 'ar') ? 'مربع الخريطة' : 'Map Tile'; ?></a></li>
								<li><a href="?p=natars"><?php echo (defined('LANG') && LANG === 'ar') ? 'إدارة الناتار' : 'Natars Management'; ?></a></li>
							</ul>
						</li>
						<li class="sub"><a href="#"><?php echo (defined('LANG') && LANG === 'ar') ? 'البحث' : 'Search'; ?></a>
							<ul>
								<li><a href="?p=search"><?php echo (defined('LANG') && LANG === 'ar') ? 'بحث عام' : 'General Search'; ?></a></li>
								<li><a href="?p=message"><?php echo (defined('LANG') && LANG === 'ar') ? 'بحث الرسائل/التقارير' : 'Search IGMs/Reports'; ?></a></li>
							</ul>
						</li>
						<li class="sub"><a href="#"><?php echo (defined('LANG') && LANG === 'ar') ? 'الرسائل' : 'Messages'; ?></a>
							<ul>
								<li><a href="<?php echo rtrim(SERVER, '/'); ?>/nachrichten.php"><?php echo (defined('LANG') && LANG === 'ar') ? 'قراءة الرسائل' : 'Read In-Game Messages'; ?></a></li>
								<li><a href="<?php echo rtrim(SERVER, '/'); ?>/massmessage.php"><?php echo (defined('LANG') && LANG === 'ar') ? 'إنشاء رسالة جماعية' : 'Create Mass Message'; ?></a></li>
								<li><a href="<?php echo rtrim(SERVER, '/'); ?>/sysmsg.php"><?php echo (defined('LANG') && LANG === 'ar') ? 'إنشاء رسالة نظام' : 'Create System Message'; ?></a></li>
							</ul>
						</li>
						<li class="sub"><a href="#"><?php echo (defined('LANG') && LANG === 'ar') ? 'الحظر' : 'Ban'; ?></a>
							<ul>
								<li><a href="?p=ban"><?php echo (defined('LANG') && LANG === 'ar') ? 'حظر/إلغاء حظر اللاعبين' : 'Ban/Unban Players'; ?></a></li>
								<li><a href="?p=maintenance"><?php echo (defined('LANG') && LANG === 'ar') ? 'صيانة السيرفر' : 'Server Maintenance'; ?></a></li>
								<li><a href="?p=cleanban"><?php echo (defined('LANG') && LANG === 'ar') ? 'تنظيف قائمة الحظر' : 'Clean Banlist Data'; ?></a></li>
							</ul>
						</li>
						<li class="sub"><a href="#"><?php echo (defined('LANG') && LANG === 'ar') ? 'الذهب' : 'Gold'; ?></a>
							<ul>
								<li><a href="?p=gold"><?php echo (defined('LANG') && LANG === 'ar') ? 'إعطاء ذهب مجاني للجميع' : 'Give All Free Gold'; ?></a></li>
								<li><a href="?p=usergold"><?php echo (defined('LANG') && LANG === 'ar') ? 'إعطاء ذهب لمستخدم محدد' : 'Give Free Gold To Specific User'; ?></a></li>
								<li><a href="?p=maintenenceResetGold"><?php echo (defined('LANG') && LANG === 'ar') ? 'إعادة تعيين الذهب' : 'Reset Gold'; ?></a></li>
							</ul>
						</li>
						<li class="sub"><a href="#"><?php echo (defined('LANG') && LANG === 'ar') ? 'بلس والمكافآت' : 'Plus & Res Bonus'; ?></a>
							<ul>
								<li><a href="?p=givePlus"><?php echo (defined('LANG') && LANG === 'ar') ? 'إعطاء بلس للجميع' : 'Give All Plus'; ?></a></li>
								<li><a href="?p=maintenenceResetPlus"><?php echo (defined('LANG') && LANG === 'ar') ? 'إعادة تعيين البلس' : 'Reset Plus'; ?></a></li>
								<li><a href="?p=givePlusRes"><?php echo (defined('LANG') && LANG === 'ar') ? 'إعطاء مكافأة الموارد للجميع' : 'Give All Res Bonus'; ?></a></li>
								<li><a href="?p=maintenenceResetPlusBonus"><?php echo (defined('LANG') && LANG === 'ar') ? 'إعادة تعيين مكافأة الموارد' : 'Reset Res Bonus'; ?></a></li>
							</ul>
						</li>
						<li class="sub"><a href="#"><?php echo (defined('LANG') && LANG === 'ar') ? 'المستخدمون' : 'Users'; ?></a>
							<ul>
                                <li><a href="?p=users"><?php echo (defined('LANG') && LANG === 'ar') ? 'قائمة المستخدمين' : 'List Users'; ?></a></li>
								<li><a href="?p=addUsers"><?php echo (defined('LANG') && LANG === 'ar') ? 'إنشاء مستخدمين' : 'Create Users'; ?></a></li>
							</ul>
						</li>
						<li class="sub"><a href="#"><?php echo (defined('LANG') && LANG === 'ar') ? 'الإدارة' : 'Admin'; ?></a>
							<ul>
								<li><a href="?p=admin_log"><font color="Red"><b><?php echo (defined('LANG') && LANG === 'ar') ? 'سجل الإدارة' : 'Admin Log'; ?></b></font></a></li>
								<li><a href="?p=config"><?php echo (defined('LANG') && LANG === 'ar') ? 'إعدادات السيرفر' : 'Server Settings'; ?></a></li>
								<li><a href="?p=resetServer"><?php echo (defined('LANG') && LANG === 'ar') ? 'إعادة تعيين السيرفر' : 'Server Resetting'; ?></a></li>
							</ul>
						</li>
					</ul>
					<?php
							} else if($_SESSION['access'] == MULTIHUNTER) {
					?>
					<ul id="menu">
						<li><a href="<?php echo HOMEPAGE; ?>"><?php echo (defined('LANG') && LANG === 'ar') ? 'الصفحة الرئيسية' : 'Server Homepage'; ?></a></li>
						<li><a href="admin.php"><?php echo (defined('LANG') && LANG === 'ar') ? 'لوحة التحكم' : 'Control Panel Home'; ?></a></li>
						<li><a href="<?php echo rtrim(SERVER, '/'); ?>/nachrichten.php"><?php echo (defined('LANG') && LANG === 'ar') ? 'الرسائل داخل اللعبة' : 'In-Game Messages'; ?></a></li>
						<li><a href="?p=server_info"><?php echo (defined('LANG') && LANG === 'ar') ? 'معلومات السيرفر' : 'Server Info'; ?></a></li>
						<li><a href="?p=online"><?php echo (defined('LANG') && LANG === 'ar') ? 'اللاعبون المتصلون' : 'Online users'; ?></a></li>
						<li><a href="?p=search"><?php echo (defined('LANG') && LANG === 'ar') ? 'البحث' : 'Search'; ?></a></li>
						<li><a href="?p=message"><?php echo (defined('LANG') && LANG === 'ar') ? 'الرسائل/التقارير' : 'Msg/Rep'; ?></a></li>
						<li><a href="?p=ban"><?php echo (defined('LANG') && LANG === 'ar') ? 'الحظر' : 'Ban'; ?></a></li>
						<li><a href="?action=logout"><?php echo (defined('LANG') && LANG === 'ar') ? 'تسجيل الخروج' : 'Logout'; ?></a></li>
					</ul>
					<?php
							}
						}
					?>
					<!-- End Accordeon Menu -->
				</div>
				<div id="lmid1">
					<div id="lmid3">
						<?php
							if($funct->CheckLogin())
							{
								if($_POST || $_GET)
								{
									if($_GET['p'] and $_GET['p']!="search")
									{
										$filename = 'Templates/'.$_GET['p'].'.tpl';
										if(file_exists($filename)) include($filename);
										else include('Templates/404.tpl');
									}
									else include('Templates/search.tpl');

									if(isset($_POST['p']) && isset($_POST['s']) && $_POST['p'] and $_POST['s'])
									{
										$filename = 'Templates/results_'.$_POST['p'].'.tpl';
										if(file_exists($filename)) include($filename);
										else include('Templates/404.tpl');
									}
								}
								else include('Templates/home.tpl');
							}
							else include('Templates/login.tpl');
						?>
					</div>
				</div>
			</div>
			<div id="lright1"></div>
			<div id="ce"></div>
		</div>
	</body>
</html>
