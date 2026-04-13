<?php 
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       header.tpl                                                  ##
##  Developed by:  Dzoki                                                       ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
##                                                                             ##
#################################################################################
?>

<div id="header">
    <input type="checkbox" id="mobile-nav-toggle" style="display:none;" />
    <label for="mobile-nav-toggle" class="mobile-hamburger" style="display:none;">
        <span></span>
        <span></span>
        <span></span>
    </label>
    <label for="mobile-nav-toggle" class="mobile-sidebar-backdrop" style="display:none;"></label>
    
    <div id="mtop">
        <a href="<?php echo ($_SESSION['id_user'] != 1 ? 'dorf1.php' : '#'); ?>" id="n1" accesskey="1"><img src="img/x.gif" title="<?php echo (defined('LANG') && LANG === 'ar' ? 'نظرة عامة على القرية' : 'Village overview'); ?>" alt="<?php echo (defined('LANG') && LANG === 'ar' ? 'نظرة عامة على القرية' : 'Village overview'); ?>" /></a>
        <a href="<?php echo ($_SESSION['id_user'] != 1 ? 'dorf2.php' : '#'); ?>" id="n2" accesskey="2"><img src="img/x.gif" title="<?php echo (defined('LANG') && LANG === 'ar' ? 'مركز القرية' : 'Village centre'); ?>" alt="<?php echo (defined('LANG') && LANG === 'ar' ? 'مركز القرية' : 'Village centre'); ?>" /></a>
        <a href="karte.php" id="n3" accesskey="3"><img src="img/x.gif" title="<?php echo (defined('LANG') && LANG === 'ar' ? 'الخريطة' : 'Map'); ?>" alt="<?php echo (defined('LANG') && LANG === 'ar' ? 'الخريطة' : 'Map'); ?>" /></a>
        <a href="statistiken.php" id="n4" accesskey="4"><img src="img/x.gif" title="<?php echo (defined('LANG') && LANG === 'ar' ? 'الإحصائيات' : 'Statistics'); ?>" alt="<?php echo (defined('LANG') && LANG === 'ar' ? 'الإحصائيات' : 'Statistics'); ?>" /></a>
        <?php
        if($message->unread && !$message->nunread) {
        $class = "i2";
        }
        else if(!$message->unread && $message->nunread) {
        $class = "i3";
        }
        else if($message->unread && $message->nunread) {
        $class = "i1";
        }
        else {
        $class = "i4";
        }
        ?>
          <div id="n5" class="<?php echo $class ?>">
            <a href="<?php echo ($_SESSION['id_user'] != 1 ? 'berichte.php' : '#'); ?>" accesskey="5"><img src="img/x.gif" class="l" title="<?php echo (defined('LANG') && LANG === 'ar' ? 'التقارير' : 'Reports'); ?>" alt="<?php echo (defined('LANG') && LANG === 'ar' ? 'التقارير' : 'Reports'); ?>"/></a>
            <a href="nachrichten.php" accesskey="6"><img src="img/x.gif" class="r" title="<?php echo (defined('LANG') && LANG === 'ar' ? 'الرسائل' : 'Messages'); ?>" alt="<?php echo (defined('LANG') && LANG === 'ar' ? 'الرسائل' : 'Messages'); ?>" /></a>
        </div>

		<?php
			// no PLUS needed for Support
			if ($_SESSION['id_user'] != 1) {
		?>
        <a href="plus.php?id=3" id="plus" style="background: transparent !important; width: auto !important; height: auto !important; margin-left: 0 !important; margin-top: 20px !important;">
        <span id="header_gold_display" style="
            display: inline-flex !important;
            align-items: center;
            gap: 5px;
            background: linear-gradient(180deg, #FFD54F 0%, #FF9800 50%, #E65100 100%);
            border: 1px solid #BF6C00;
            border-radius: 6px;
            padding: 3px 12px 3px 8px;
            color: #fff;
            font-weight: bold;
            font-size: 13px;
            text-shadow: 0 1px 2px rgba(0,0,0,0.4);
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.35), 0 1px 3px rgba(0,0,0,0.25);
            line-height: 18px;
            cursor: pointer;
        ">
            <?php if($session->gold >= 2): ?>
                <img src="<?php echo GP_LOCATE; ?>img/a/gold.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'الذهب' : 'Gold'; ?>" title="<?php echo $session->gold; ?> <?php echo (defined('LANG') && LANG === 'ar') ? 'ذهب' : 'Gold'; ?>" style="vertical-align: middle; width: 16px; height: 16px;" />
                <span class="gold_amount" style="display: inline !important; color: #fff; font-weight: bold; font-size: 13px; vertical-align: middle;"><?php echo $session->gold; ?></span>
            <?php else: ?>
                <img src="<?php echo GP_LOCATE; ?>img/a/gold_g.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'الذهب' : 'Gold'; ?>" title="<?php echo $session->gold; ?> <?php echo (defined('LANG') && LANG === 'ar') ? 'ذهب' : 'Gold'; ?>" style="vertical-align: middle; width: 16px; height: 16px;" />
                <span class="gold_amount low" style="display: inline !important; color: rgba(255,255,255,0.7); font-weight: bold; font-size: 13px; vertical-align: middle;"><?php echo $session->gold; ?></span>
            <?php endif; ?>
        </span>
        </a>
       <?php
       		}
       ?>
<style>

.day_image {
    background-image: url("../gpack/travian_default/img/l/day.gif");
width: 18px;
height:18px;
}
.night_image {
      background-image: url("../gpack/travian_default/img/l/night.gif");
width: 18px;
height:18px;
}
  #container {
    width: 30px;
    height: 60px;
    position: relative;
  }
  #wrapper > #container {
    display: table;
    position: static;
  }
  #container div {
    position: absolute;
    top: 50%;
  }
  #container div div {
    position: relative;
    top: -50%;
  }
  #container > div {
    display: table-cell;
    vertical-align: middle;
    position: static;
  }
</style>
<?php
$hour = date('Hi'); 
if ($hour > 1759 or $hour < 500) {
$day_night_img = 'night_image';
} elseif ($hour > 1200) {
$day_night_img = 'day_image';
} else {
$day_night_img = 'day_image';
}
?>
<div id="wrapper">
  <div id="container">
 <div><div><p><img src="img/x.gif" style="display: block; margin: 0 auto; vertical-align:middle;" class="<?php echo $day_night_img;?>"  /></p></div></div>
  </div>
</div>
        <div class="clear"></div>
    </div>
</div>
