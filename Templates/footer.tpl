<?php


#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Project:       TravianZ                        		       	               ##
##  Version:       06.03.2014 							                           ##
##  Filename       footer.tpl                                                  ##
##  Developed by:  Advocaite , Shadow , ronix                                  ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2014. All rights reserved.                ##
##  URLs:          http://travian.shadowss.ro 				                   ##
##  Source code:   http://github.com/Shadowss/TravianZ/	                       ##
##                                                                             ##
#################################################################################

?>

<style>
/* Desktop footer fix: previous CSS hard-coded height:90px, which clips
   the new multi-line footer content. Keep mobile overrides untouched. */
@media screen and (min-width: 769px) {
    div#footer {
        height: auto !important;
        min-height: 120px;
    }
    div#footer div#mfoot {
        height: auto !important;
        padding: 8px 0 14px;
    }
    div#footer div.footer-menu {
        text-align: center !important;
        padding: 0 12px;
    }
    div#footer div#mfoot div.copyright {
        text-align: center !important;
        line-height: 1.45;
    }
    .footer-stopper {
        margin-bottom: 130px;
    }
}
</style>

<div id="footer">
<div id="mfoot">
<div class="footer-menu">
<br />
<div class="copyright">&copy; 2010 - <?php echo date('Y') . ' ' . (defined('SERVER_NAME') ? SERVER_NAME : 'TravianZ');?> <?php echo (defined('LANG') && LANG === 'ar') ? 'جميع الحقوق محفوظة' : 'All rights reserved'; ?></div>
<div class="copyright" style="margin-top: 6px; font-size: 11px; color: #999;">
    Released by TravianZ &mdash; Thank you for using our version
</div>
<div class="copyright" style="margin-top: 4px; font-size: 11px; color: #888;">
    <?php echo (defined('LANG') && LANG === 'ar') ? 'تعريب: Razex Xelite' : 'Arabic localization: Razex Xelite'; ?>
</div>
</div>
</div>
<div id="cfoot">
</div>
</div>
