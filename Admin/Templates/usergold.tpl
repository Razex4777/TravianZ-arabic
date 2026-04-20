<?php
#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       usergold.tpl                                                ##
##  Developed by:  aggenkeech                                                  ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2025. All rights reserved.                ##
##                                                                             ##
#################################################################################

if($_SESSION['access'] < ADMIN) die("Access Denied: You are not Admin!");
$id = $_SESSION['id']; ?>

<form action="../GameEngine/Admin/Mods/gold_1.php" method="POST">
	<input type="hidden" name="admid" id="admid" value="<?php echo $_SESSION['id']; ?>">
	<table id="member" style="width:350px;">
		<thead>
			<tr>
				<th colspan="2">Give Gold for Specific User</th>
			</tr>
			<tr>
				<td>Amount</td>
				<td></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<center>
						<b>How much gold?</b>
					</center>
				</td>
				<td>
					<center>
						<input class="give_gold" name="gold" value="20" maxlength="4">&nbsp;
						<img src="../img/admin/gold.gif" class="gold" alt="Gold" name="gold" title="Gold"/>
					</center>
				</td>
			</tr>
			<tr>
				<td>
					<center>
						<b>Paid Gold?</b><br/>
						<small style="color:#888">(Check if player paid real money)</small>
					</center>
				</td>
				<td>
					<center>
						<input type="checkbox" name="is_paid" value="1" style="width:20px;height:20px;"> Yes
					</center>
				</td>
			</tr>
			<tr>
				<td>
					<center>
						<b>For which user (id)?</b>
					</center>
				</td>
				<td>
					<center>
						<input class="give_gold" name="id" value="">&nbsp;
					</center>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<center>
						<input type="image" src="../img/admin/b/ok1.gif" value="submit" title="Give Gold">
					</center>
				</td>
			</tr>
		</tbody>
	</table>
</form>

<?php
	if(isset($_GET['g']))
	{
		echo '<br /><br /><font color="Red"><b>Gold Added</font></b>';
	}
?>