<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       editPlusSet.tpl                                             ##
##  Developed by:  martinambrus                                                ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2017. All rights reserved.                ##
##                                                                             ##
#################################################################################
if (!isset($_SESSION)) {
 session_start();
}
if($_SESSION['access'] < 9) die(ACCESS_DENIED_ADMIN);
?>
<script LANGUAGE="JavaScript">
function refresh(tz) {
	document.getElementById('tz').innerHTML=tz;
}
</script>
<h2><center><?php echo PLUS_CONFIGURATION ?></center></h2>
	<form action="../GameEngine/Admin/Mods/editPlusSet.php" method="POST">
		<input type="hidden" name="id" id="id" value="<?php echo $_SESSION['id']; ?>">
			<br />
			<table id="profile" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<th colspan="2"><?php echo EDIT_PLUS_SETT ?></th>
					</tr>
				</thead>
				<tbody>
    				<tr>
    					<td width="50%">
                            <?php echo CONF_PLUS_PAYPALEMAIL ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PAYPALEMAIL_TOOLTIP ?></span></em>
                        </td>
    					<td width="50%">
    					   <input class="fm" name="paypal-email" value="<?php echo (defined('PAYPAL_EMAIL') ? PAYPAL_EMAIL : '@'); ?>" style="width: 70%;">
    					</td>
    				</tr>
    				<tr>
                        <td width="50%">
                            <?php echo CONF_PLUS_CURRENCY ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_CURRENCY_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="paypal-currency" value="<?php echo (defined('PAYPAL_CURRENCY') ? PAYPAL_CURRENCY : 'EUR'); ?>" style="width: 70%;">
                        </td>
                    </tr>

                    <tr>
                        <td width="50%">
                           <?php echo CONF_PLUS_PACKAGEGOLDA ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PACKAGEGOLDA_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-a-gold" value="<?php echo (defined('PLUS_PACKAGE_A_GOLD') ? PLUS_PACKAGE_A_GOLD : 60); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           <?php echo CONF_PLUS_PACKAGEPRICEA ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PACKAGEPRICEA_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-a-price" value="<?php echo (defined('PLUS_PACKAGE_A_PRICE') ? PLUS_PACKAGE_A_PRICE : '1,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    
                    <tr>
                        <td width="50%">
                           <?php echo CONF_PLUS_PACKAGEGOLDB ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PACKAGEGOLDB_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-b-gold" value="<?php echo (defined('PLUS_PACKAGE_B_GOLD') ? PLUS_PACKAGE_B_GOLD : 120); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           <?php echo CONF_PLUS_PACKAGEPRICEB ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PACKAGEPRICEB_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-b-price" value="<?php echo (defined('PLUS_PACKAGE_B_PRICE') ? PLUS_PACKAGE_B_PRICE : '4,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    
                    <tr>
                        <td width="50%">
                           <?php echo CONF_PLUS_PACKAGEGOLDC ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PACKAGEGOLDC_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-c-gold" value="<?php echo (defined('PLUS_PACKAGE_C_GOLD') ? PLUS_PACKAGE_C_GOLD : 360); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           <?php echo CONF_PLUS_PACKAGEPRICEC ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PACKAGEPRICEC_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-c-price" value="<?php echo (defined('PLUS_PACKAGE_C_PRICE') ? PLUS_PACKAGE_C_PRICE : '9,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    
                    <tr>
                        <td width="50%">
                           <?php echo CONF_PLUS_PACKAGEGOLDD ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PACKAGEGOLDD_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-d-gold" value="<?php echo (defined('PLUS_PACKAGE_D_GOLD') ? PLUS_PACKAGE_D_GOLD : 1000); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           <?php echo CONF_PLUS_PACKAGEPRICED ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PACKAGEPRICED_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-d-price" value="<?php echo (defined('PLUS_PACKAGE_D_PRICE') ? PLUS_PACKAGE_D_PRICE : '19,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>

                    <tr>
                        <td width="50%">
                           <?php echo CONF_PLUS_PACKAGEGOLDE ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PACKAGEGOLDE_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-e-gold" value="<?php echo (defined('PLUS_PACKAGE_E_GOLD') ? PLUS_PACKAGE_E_GOLD : 2000); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           <?php echo CONF_PLUS_PACKAGEPRICEE ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PACKAGEPRICEE_TOOLTIP ?></span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-e-price" value="<?php echo (defined('PLUS_PACKAGE_E_PRICE') ? PLUS_PACKAGE_E_PRICE : '49,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           Package F Gold <em class="tooltip">?<span class="classic">Package F Gold Amount</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-f-gold" value="<?php echo (defined('PLUS_PACKAGE_F_GOLD') ? PLUS_PACKAGE_F_GOLD : 5000); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           Package F Price <em class="tooltip">?<span class="classic">Package F Price</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-f-price" value="<?php echo (defined('PLUS_PACKAGE_F_PRICE') ? PLUS_PACKAGE_F_PRICE : '99,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           Package G Gold <em class="tooltip">?<span class="classic">Package G Gold Amount</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-g-gold" value="<?php echo (defined('PLUS_PACKAGE_G_GOLD') ? PLUS_PACKAGE_G_GOLD : 12000); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           Package G Price <em class="tooltip">?<span class="classic">Package G Price</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-g-price" value="<?php echo (defined('PLUS_PACKAGE_G_PRICE') ? PLUS_PACKAGE_G_PRICE : '199,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           Package H Gold <em class="tooltip">?<span class="classic">Package H Gold Amount</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-h-gold" value="<?php echo (defined('PLUS_PACKAGE_H_GOLD') ? PLUS_PACKAGE_H_GOLD : 20000); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           Package H Price <em class="tooltip">?<span class="classic">Package H Price</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-h-price" value="<?php echo (defined('PLUS_PACKAGE_H_PRICE') ? PLUS_PACKAGE_H_PRICE : '299,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>

                    <tr>
                        <td width="50%">
                           Package F Gold <em class="tooltip">?<span class="classic">Package F Gold Amount</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-f-gold" value="<?php echo (defined('PLUS_PACKAGE_F_GOLD') ? PLUS_PACKAGE_F_GOLD : 5000); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           Package F Price <em class="tooltip">?<span class="classic">Package F Price</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-f-price" value="<?php echo (defined('PLUS_PACKAGE_F_PRICE') ? PLUS_PACKAGE_F_PRICE : '99,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>

                    <tr>
                        <td width="50%">
                           Package G Gold <em class="tooltip">?<span class="classic">Package G Gold Amount</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-g-gold" value="<?php echo (defined('PLUS_PACKAGE_G_GOLD') ? PLUS_PACKAGE_G_GOLD : 12000); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           Package G Price <em class="tooltip">?<span class="classic">Package G Price</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-g-price" value="<?php echo (defined('PLUS_PACKAGE_G_PRICE') ? PLUS_PACKAGE_G_PRICE : '199,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>

                    <tr>
                        <td width="50%">
                           Package H Gold <em class="tooltip">?<span class="classic">Package H Gold Amount</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-h-gold" value="<?php echo (defined('PLUS_PACKAGE_H_GOLD') ? PLUS_PACKAGE_H_GOLD : 20000); ?>" style="width: 70%;">
                        </td>
                    </tr>
                    <tr>
                        <td width="50%">
                           Package H Price <em class="tooltip">?<span class="classic">Package H Price</span></em>
                        </td>
                        <td width="50%">
                           <input class="fm" name="plus-h-price" value="<?php echo (defined('PLUS_PACKAGE_H_PRICE') ? PLUS_PACKAGE_H_PRICE : '299,99'); ?>" style="width: 70%;">
                        </td>
                    </tr>

					<tr>
						<td><?php echo CONF_PLUS_ACCDURATION ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_ACCDURATION_TOOLTIP ?></span></em></td>
						<td>
							<select name="plus_time">
								<option value="(3600*12)" <?php if(PLUS_TIME==43200) echo "selected";?>>12 <?php echo (defined('LANG') && LANG === 'ar') ? 'ساعات' : 'hours'; ?></option>
								<option value="(3600*24)" <?php if(PLUS_TIME==86400) echo "selected";?>>1 <?php echo (defined('LANG') && LANG === 'ar') ? 'يوم' : 'day'; ?></option>
								<option value="(3600*24*2)" <?php if(PLUS_TIME==172800) echo "selected";?>>2 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
								<option value="(3600*24*3)" <?php if(PLUS_TIME==259200) echo "selected";?>>3 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
								<option value="(3600*24*4)" <?php if(PLUS_TIME==345600) echo "selected";?>>4 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
								<option value="(3600*24*5)" <?php if(PLUS_TIME==432000) echo "selected";?>>5 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
								<option value="(3600*24*6)" <?php if(PLUS_TIME==518400) echo "selected";?>>6 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
								<option value="(3600*24*7)" <?php if(PLUS_TIME==604800) echo "selected";?>>7 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo CONF_PLUS_PRODUCTDURATION ?> <em class="tooltip">?<span class="classic"><?php echo CONF_PLUS_PRODUCTDURATION_TOOLTIP ?></span></em></td>
						<td>
							<select name="plus_production">
								<option value="(3600*12)" <?php if(PLUS_TIME==43200) echo "selected";?>>12 <?php echo (defined('LANG') && LANG === 'ar') ? 'ساعات' : 'hours'; ?></option>
								<option value="(3600*24)" <?php if(PLUS_TIME==86400) echo "selected";?>>1 <?php echo (defined('LANG') && LANG === 'ar') ? 'يوم' : 'day'; ?></option>
								<option value="(3600*24*2)" <?php if(PLUS_TIME==172800) echo "selected";?>>2 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
								<option value="(3600*24*3)" <?php if(PLUS_TIME==259200) echo "selected";?>>3 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
								<option value="(3600*24*4)" <?php if(PLUS_TIME==345600) echo "selected";?>>4 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
								<option value="(3600*24*5)" <?php if(PLUS_TIME==432000) echo "selected";?>>5 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
								<option value="(3600*24*6)" <?php if(PLUS_TIME==518400) echo "selected";?>>6 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
								<option value="(3600*24*7)" <?php if(PLUS_TIME==604800) echo "selected";?>>7 <?php echo (defined('LANG') && LANG === 'ar') ? 'أيام' : 'days'; ?></option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
			<br />
			<table width="100%">
				<tr><td align="left"><a href="../Admin/admin.php?p=config"><< <?php echo EDIT_BACK ?></a></td>
					<td align="right"><input type="image" border="0" src="../img/admin/b/ok1.gif"></td>
				</tr>
			</table>
		</form>
