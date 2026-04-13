<?php
include("Templates/Plus/pmenu.tpl");
$free = $session->uid;
?>
<table class="rate_details lang_ltr lang_de" cellpadding="1" cellspacing="1">
	<thead>

		<tr>
			<th colspan="2">Paypal</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="pic">
                <img src="img/bezahlung/paypal.jpg" style="99px; height:99px;" alt="Package G" />
    
                <div>
                    Gold : <?php echo (defined('PLUS_PACKAGE_G_GOLD') ? PLUS_PACKAGE_G_GOLD : 12000); ?>
                    <br />
                    Cost : <?php echo (defined('PLUS_PACKAGE_G_PRICE') ? PLUS_PACKAGE_G_PRICE : '199,99') . ' ' . (defined('PAYPAL_CURRENCY') ? PAYPAL_CURRENCY : 'EUR'); ?>
                    <br />
                    Wait: 24 hours
                </div>
                </td>
                <td class="desc">
                    Initiate Payment by Paypal
                    <br /><br />
                    <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
    
                      <!-- Identify your business so that you can collect the payments. -->
                      <input type="hidden" name="business" value="<?php echo (defined('PAYPAL_EMAIL') ? PAYPAL_EMAIL : 'novgorodschi@icloud.com'); ?>">
                    
                      <!-- Specify a Buy Now button. -->
                      <input type="hidden" name="cmd" value="_xclick">
                    
                      <!-- Specify details about the item that buyers will purchase. -->
                      <input type="hidden" name="item_name" value="<?php echo SERVER_NAME . ' Package G Gold Pack (' . $session->username . ')'; ?>">
                      <input type="hidden" name="amount" value="<?php echo (defined('PLUS_PACKAGE_G_PRICE') ? str_replace(",", ".", PLUS_PACKAGE_G_PRICE) : '199.99'); ?>">
                      <input type="hidden" name="currency_code" value="<?php echo (defined('PAYPAL_CURRENCY') ? PAYPAL_CURRENCY : 'EUR'); ?>">
                    
                      <!-- Display the payment button. -->
                      <input type="image" name="submit" border="0"
                      src="https://www.paypalobjects.com/webstatic/en_US/i/btn/png/btn_buynow_107x26.png"
                      alt="Buy Now">
                      <img alt="" border="0" width="1" height="1" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" >
        
                    </form>
    
                <br />
                More Info about PayPal can be found here: <br />
                <a href="#" onclick="window.open('https://www.paypal.com/en/cgi-bin/webscr?cmd=xpt/cps/popup/OLCWhatIsPayPal-outside','external','scrollbars=yes,status=yes,resizable=yes,toolbar=yes,width=800,height=600');return false;">More Info</a>
                <br />
            </td>
        </tr>
	</tbody>
</table>
<br /><br /><br /><br /><br /><br />
</div>

</div>
