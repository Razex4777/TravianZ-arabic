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
<!-- Mobile-only panorama banner (hidden on desktop via CSS, shown on mobile) -->
<div id="mobile_header_banner">
    <span class="mobile_server_name"><?php echo SERVER_NAME; ?></span>
</div>
<?php
$_protect_ts = isset($session->userinfo['protect']) ? (int)$session->userinfo['protect'] : 0;
$_gold_protect_ts = isset($session->userinfo['gold_protect']) ? (int)$session->userinfo['gold_protect'] : 0;
$_active_protect_ts = max($_protect_ts, $_gold_protect_ts);

if ($_active_protect_ts > time()) {
    $_protect_remaining = $_active_protect_ts - time();
?>
    <div id="bp_timer_box" style="position: absolute; left: 20px; top: 20px; background: #1cb5c9; color: white; border-radius: 12px; padding: 5px 12px; font-weight: bold; font-family: Tahoma, Arial, sans-serif; font-size: 14px; display: flex; align-items: center; gap: 6px; z-index: 1000; box-shadow: 0 2px 5px rgba(0,0,0,0.3);">
        <span style="font-size: 16px;">🕊️</span>
        <span id="bp_countdown"><?php echo $generator->getTimeFormat($_protect_remaining); ?></span>
    </div>
    <script>
    (function(){
        var rem = <?php echo $_protect_remaining; ?>;
        var el = document.getElementById('bp_countdown');
        if(!el) return;
        setInterval(function(){
            rem--;
            if(rem <= 0){ el.parentNode.style.display='none'; return; }
            var h = Math.floor(rem/3600);
            var m = Math.floor((rem%3600)/60);
            var s = rem%60;
            el.textContent = (h<10?'0'+h:h)+':'+(m<10?'0'+m:m)+':'+(s<10?'0'+s:s);
        }, 1000);
    })();
    </script>
<?php
}
?>
    <input type="checkbox" id="mobile-nav-toggle" style="display:none;" />
    <label for="mobile-nav-toggle" class="mobile-hamburger" style="display:none;">
        <span></span>
        <span></span>
        <span></span>
    </label>
    <label for="mobile-nav-toggle" class="mobile-sidebar-backdrop" style="display:none;"></label>
    
    <div id="mtop">
        <a href="plus.php?id=3" id="plus">
        <span id="header_gold_display">
            <?php if($session->gold >= 2): ?>
                <img src="<?php echo GP_LOCATE; ?>img/a/gold.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'الذهب' : 'Gold'; ?>" title="<?php echo $session->gold; ?> <?php echo (defined('LANG') && LANG === 'ar') ? 'ذهب' : 'Gold'; ?>" />
                <span class="gold_amount"><?php echo $session->gold; ?></span>
            <?php else: ?>
                <img src="<?php echo GP_LOCATE; ?>img/a/gold_g.gif" alt="<?php echo (defined('LANG') && LANG === 'ar') ? 'الذهب' : 'Gold'; ?>" title="<?php echo $session->gold; ?> <?php echo (defined('LANG') && LANG === 'ar') ? 'ذهب' : 'Gold'; ?>" />
                <span class="gold_amount low"><?php echo $session->gold; ?></span>
            <?php endif; ?>
        </span>
        </a>
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
<style>
/* === GLOBAL: Override gpack's "div#mtop a#plus span { display:none }" ===
   Moving #plus inside #mtop triggered the gpack hiding rule.
   This higher-specificity rule (3 IDs) keeps gold visible on ALL screens. */
div#mtop a#plus span#header_gold_display {
    display: inline-flex !important;
    align-items: center !important;
    gap: 3px !important;
}
div#mtop a#plus span#header_gold_display span.gold_amount,
div#mtop a#plus span#header_gold_display span.gold_amount.low {
    display: inline !important;
}

/* === Desktop Gold Display Override ===
   Override gpack's margin-left:115px to place gold on the LEFT.
   Nav circles follow naturally in the middle. */
@media screen and (min-width: 981px) {
    div#mtop a#plus {
        float: left !important;
        margin-left: 120px !important;  /* Brings gold closer to the 5 circles */
        margin-right: 8px !important;
        margin-top: 18px !important;
        display: inline-flex !important;
        align-items: center;
        gap: 4px;
        background: linear-gradient(to bottom, #ffc107, #ff9800);
        border: 1px solid #d87b00;
        border-radius: 5px;
        padding: 2px 8px;
        height: 22px;
        text-decoration: none;
        box-shadow: inset 0 1px 1px rgba(255,255,255,0.5), 0 1px 3px rgba(0,0,0,0.2);
    }
    div#mtop a#plus:hover {
        background: linear-gradient(to bottom, #ffca28, #ffa726);
    }
    div#mtop a#plus span,
    div#mtop a#plus span#header_gold_display {
        display: inline-flex !important;
        align-items: center;
        gap: 3px;
    }
    div#mtop a#plus span#header_gold_display .gold_amount,
    div#mtop a#plus span#header_gold_display .gold_amount.low {
        color: #fff;
        font-size: 12px;
        font-weight: 900;
        text-shadow: 1px 1px 1px rgba(0,0,0,0.3);
    }
    div#mtop a#plus img {
        width: 14px;
        height: 14px;
    }
}

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
