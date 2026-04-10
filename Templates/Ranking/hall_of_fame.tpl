<?php

#################################################################################
##              -= YOU MAY NOT REMOVE OR CHANGE THIS NOTICE =-                 ##
## --------------------------------------------------------------------------- ##
##  Filename       hall_of_fame.tpl                                            ##
##  Developed by:  TravianZ Custom                                             ##
##  License:       TravianZ Project                                            ##
##  Copyright:     TravianZ (c) 2010-2011. All rights reserved.                ##
##  Description:   Hall of Fame - Historical record of daily winners           ##
#################################################################################

// Fetch all Hall of Fame records ordered by period (newest first)
$hofQuery = "SELECT * FROM ".TB_PREFIX."hall_of_fame ORDER BY period DESC, id ASC";
$hofResult = mysqli_query($database->dblink, $hofQuery);

// Category label mapping (uses constants if defined, falls back to English)
$categoryLabels = [
    'top_attacker' => defined('HOF_TOP_ATTACKER') ? HOF_TOP_ATTACKER : 'Top Attacker',
    'top_defender' => defined('HOF_TOP_DEFENDER') ? HOF_TOP_DEFENDER : 'Top Defender',
    'top_climber'  => defined('HOF_TOP_CLIMBER')  ? HOF_TOP_CLIMBER  : 'Top Climber',
    'top_robber'   => defined('HOF_TOP_ROBBER')   ? HOF_TOP_ROBBER   : 'Top Robber',
    'top_alliance' => defined('HOF_TOP_ALLIANCE') ? HOF_TOP_ALLIANCE : 'Top Alliance',
];

// Group records by period
$periods = [];
if ($hofResult && mysqli_num_rows($hofResult) > 0) {
    while ($row = mysqli_fetch_assoc($hofResult)) {
        $periods[$row['period']][] = $row;
    }
}
?>

<table cellpadding="1" cellspacing="1" id="hall_of_fame" class="world">
    <thead>
        <tr>
            <th colspan="5"><?php echo defined('HALL_OF_FAME') ? HALL_OF_FAME : 'Hall of Fame'; ?></th>
        </tr>
        <tr>
            <td class="hab"><?php echo defined('HOF_CATEGORY') ? HOF_CATEGORY : 'Category'; ?></td>
            <td class="hab"><?php echo defined('HOF_WINNER') ? HOF_WINNER : 'Winner'; ?></td>
            <td class="hab"><?php echo defined('HOF_ALLIANCE') ? HOF_ALLIANCE : 'Alliance'; ?></td>
            <td class="hab"><?php echo defined('HOF_POINTS') ? HOF_POINTS : 'Points'; ?></td>
            <td class="hab"><?php echo defined('HOF_DATE') ? HOF_DATE : 'Date'; ?></td>
        </tr>
    </thead>
    <tbody>
<?php if (empty($periods)): ?>
        <tr>
            <td colspan="5" style="text-align:center; padding:20px;">
                <?php echo defined('HOF_NO_RECORDS') ? HOF_NO_RECORDS : 'No records yet.'; ?>
            </td>
        </tr>
<?php else: ?>
    <?php foreach ($periods as $period => $records): ?>
        <tr class="hl">
            <td colspan="5" style="font-weight:bold; background-color:#e8e4cf;">
                <?php echo (defined('HOF_PERIOD') ? HOF_PERIOD : 'Period') . ' #' . (int)$period; ?>
            </td>
        </tr>
        <?php foreach ($records as $idx => $record): ?>
        <tr class="<?php echo ($idx % 2 == 0) ? 'rbg1' : 'rbg2'; ?>">
            <td>
                <?php echo isset($categoryLabels[$record['category']]) ? $categoryLabels[$record['category']] : htmlspecialchars($record['category']); ?>
            </td>
            <td>
                <?php if ($record['player_id'] > 0): ?>
                    <a href="spieler.php?uid=<?php echo (int)$record['player_id']; ?>"><?php echo htmlspecialchars($record['player_name']); ?></a>
                <?php else: ?>
                    —
                <?php endif; ?>
            </td>
            <td>
                <?php if ($record['alliance_id'] > 0): ?>
                    <a href="allianz.php?aid=<?php echo (int)$record['alliance_id']; ?>"><?php echo htmlspecialchars($record['alliance_name']); ?></a>
                <?php else: ?>
                    —
                <?php endif; ?>
            </td>
            <td><?php echo number_format((int)$record['points']); ?></td>
            <td><?php echo date('Y-m-d', (int)$record['timestamp']); ?></td>
        </tr>
        <?php endforeach; ?>
    <?php endforeach; ?>
<?php endif; ?>
    </tbody>
</table>
