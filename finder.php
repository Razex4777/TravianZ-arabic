<?php
// finder.php — Unified Map Search Feature
// Find 15c, 9c, or specific oasis combinations (150% crop, 100% clay, etc.)

include_once("GameEngine/Generator.php");
$start_timer = $generator->pageLoadTimeStart();
include_once("GameEngine/config.php");
use App\Utils\AccessLogger;
include_once("GameEngine/Village.php");
AccessLogger::logRequest();

// Tables
$TBP = defined('TB_PREFIX') ? TB_PREFIX : 's1_';
$WDATA = $TBP . 'wdata';
$ODATA = $TBP . 'odata';
$VDATA = $TBP . 'vdata';
$USERS = $TBP . 'users';

if (!defined('OASIS_BONUS_NORMAL')) define('OASIS_BONUS_NORMAL', 100);
if (!defined('OASIS_BONUS_MIXED')) define('OASIS_BONUS_MIXED', 75);
if (!defined('OASIS_BONUS_STRONG')) define('OASIS_BONUS_STRONG', 150);


$RENDER_MAX = 50;

// ---------- POST -> GET ----------
if (isset($_POST['s']) && !isset($_POST['oasis_search'])) {
    $x = isset($_POST['x']) ? preg_replace("/[^0-9-]/", "", $_POST['x']) : '0';
    $y = isset($_POST['y']) ? preg_replace("/[^0-9-]/", "", $_POST['y']) : '0';
    $s = isset($_POST['s']) ? preg_replace("/[^0-9]/", "", $_POST['s']) : '1';
    $empty_only = isset($_POST['empty_only']) ? '1' : '0';
    header("Location: " . $_SERVER['PHP_SELF'] . "?s=$s&x=$x&y=$y&empty_only=$empty_only");
    exit;
}

// ---------- Coordinates ----------
$reqX = isset($_POST['x']) ? $_POST['x'] : (isset($_GET['x']) ? $_GET['x'] : null);
$reqY = isset($_POST['y']) ? $_POST['y'] : (isset($_GET['y']) ? $_GET['y'] : null);
if ($reqX !== null && $reqY !== null && is_numeric($reqX) && is_numeric($reqY)) {
    $coor2 = ['x'=>(int)$reqX, 'y'=>(int)$reqY];
} else {
    $wref2 = $village->wid;
    $coor2 = $database->getCoor($wref2);
}
$startX = isset($coor2['x']) ? (int)$coor2['x'] : 0;
$startY = isset($coor2['y']) ? (int)$coor2['y'] : 0;

// ---------- Oasis POST Search ----------
$mode = isset($_GET['mode']) ? $_GET['mode'] : (isset($_POST['oasis_search']) ? 'oasis' : 'crop');
$oasis_results = null;
$oasis_error = "";
$searched_player = "";

if (!isset($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

if (isset($_POST['oasis_search'])) {
    if (empty($_POST['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'])) {
        $oasis_error = (defined('LANG') && LANG === 'ar') ? "الجلسة غير صالحة، يرجى المحاولة مرة أخرى" : "Invalid session token, please try again";
    } else {
        $pname = trim($_POST['player_name']);
        $searched_player = $pname;
        $cost = 2000;
        
        if ($session->gold < $cost) {
            $oasis_error = (defined('LANG') && LANG === 'ar') ? "لا تملك ذهب كافي (المطلوب $cost ذهب)" : "Not enough gold (Required $cost)";
        } elseif (empty($pname)) {
            $oasis_error = (defined('LANG') && LANG === 'ar') ? "الرجاء إدخال إسم اللاعب" : "Please enter a player name";
        } else {
        $pname_esc = mysqli_real_escape_string($database->dblink, $pname);
        $q = "SELECT id, username FROM `$USERS` WHERE username = '$pname_esc'";
        $res = mysqli_query($database->dblink, $q);
        if ($res && mysqli_num_rows($res) > 0) {
            $uRow = mysqli_fetch_assoc($res);
            $uid = (int)$uRow['id'];
            $uname = $uRow['username'];
            $searched_player = $uname;
            
            // Deduct gold
            $database->modifyGold($session->uid, $cost, 0);
            
            // Include getDistance from database
            $sql = "SELECT o.wref AS oasis_id, o.type, w.x, w.y, v.name AS village_name, v.wref AS village_id
                    FROM `$ODATA` o
                    JOIN `$WDATA` w ON w.id = o.wref
                    JOIN `$VDATA` v ON v.wref = o.conqured
                    WHERE v.owner = $uid AND o.conqured != 0";
            $ores = mysqli_query($database->dblink, $sql);
            $oasis_results = [];
            if ($ores) {
                while ($r = mysqli_fetch_assoc($ores)) {
                    $r['dist'] = $database->getDistance($startX, $startY, (int)$r['x'], (int)$r['y']);
                    $oasis_results[] = $r;
                }
                usort($oasis_results, function($a, $b) { return $a['dist'] <=> $b['dist']; });
            }
        } else {
            $oasis_error = (defined('LANG') && LANG === 'ar') ? "اللاعب غير موجود" : "Player not found";
        }
    }
}
}

$selType = (!empty($_GET['s'])) ? (int)$_GET['s'] : 1;
// selType mappings:
// 1 => 15 Crop
// 2 => 9 Crop
// 3 => 150% Crop Oasis
// 4 => 100% Crop Oasis
// 5 => 100% Clay Oasis
// 6 => 100% Iron Oasis
// 7 => 100% Wood Oasis
// 8 => 75% Clay 75% Crop
// 9 => 75% Iron 75% Crop
// 10 => 75% Wood 75% Crop

$searchTriggered = isset($_GET['s']) && isset($_GET['x']) && isset($_GET['y']);
$empty_only = isset($_GET['empty_only']) ? (int)$_GET['empty_only'] : 0;
$emptyCond = $empty_only ? " AND occupied = 0" : "";
$out = [];
$tries = 0;

if ($searchTriggered) {
    if ($selType == 1 || $selType == 2) {
        // Simple search for 15c or 9c (no specific oasis required)
        $fieldWhere = ($selType == 1) ? "6" : "1"; // 6 = 15c, 1 = 9c based on fieldtype in wdata
        $sql = "SELECT id as wref, x, y, fieldtype, occupied FROM `$WDATA` WHERE fieldtype = $fieldWhere" . $emptyCond;
        $res = mysqli_query($database->dblink, $sql);
        $rows = [];
        if ($res) {
            while ($r = mysqli_fetch_assoc($res)) {
                $r['__dist'] = $database->getDistance($startX, $startY, (int)$r['x'], (int)$r['y']);
                $rows[] = $r;
            }
        }
        usort($rows, function($a,$b) { return $a['__dist'] <=> $b['__dist']; });
        $out = array_slice($rows, 0, $RENDER_MAX);

    } else {
        // Complex oasis search
        // Define required bonuses
        $reqWood = 0; $reqClay = 0; $reqIron = 0; $reqCrop = 0;
        if ($selType == 3) $reqCrop = OASIS_BONUS_STRONG;
        if ($selType == 4) $reqCrop = OASIS_BONUS_NORMAL;
        if ($selType == 5) $reqClay = OASIS_BONUS_NORMAL;
        if ($selType == 6) $reqIron = OASIS_BONUS_NORMAL;
        if ($selType == 7) $reqWood = OASIS_BONUS_NORMAL;
        if ($selType == 8) { $reqClay = OASIS_BONUS_MIXED; $reqCrop = OASIS_BONUS_MIXED; }
        if ($selType == 9) { $reqIron = OASIS_BONUS_MIXED; $reqCrop = OASIS_BONUS_MIXED; }
        if ($selType == 10) { $reqWood = OASIS_BONUS_MIXED; $reqCrop = OASIS_BONUS_MIXED; }

        $R = 40; 
        $CAP = $RENDER_MAX;
        $found = [];

        do {
            $tries++;
            $span = $R;
            // Get all candidate villages in bounding box
            $minX = $startX - $R; $maxX = $startX + $R;
            $minY = $startY - $R; $maxY = $startY + $R;

            // Handle wrap naturally using database getDistance equivalent in PHP (or just simple bounds for now assuming no weird wrap behavior needed within short distances)
            // To be safe, we query all wdata and odata in this box, but we need to handle wrap.
            // A simple wrap condition in SQL:
            $wrapCond = function($col, $center, $R, $WMIN, $WMAX) {
                $span = $WMAX - $WMIN + 1;
                $lo = $center - $R; $hi = $center + $R;
                $norm = function($v) use ($WMIN,$span) {
                    $n = ($v - $WMIN) % $span;
                    if ($n < 0) $n += $span;
                    return $WMIN + $n;
                };
                $loN = $norm($lo); $hiN = $norm($hi);
                if ($loN <= $hiN) return "($col BETWEEN $loN AND $hiN)";
                return "(($col BETWEEN $WMIN AND $hiN) OR ($col BETWEEN $loN AND $WMAX))";
            };

            global $MIN_X, $MAX_X, $MIN_Y, $MAX_Y;
            $cX = $wrapCond('x', $startX, $R, $MIN_X, $MAX_X);
            $cY = $wrapCond('y', $startY, $R, $MIN_Y, $MAX_Y);

            // Fetch valleys (fields)
            $sqlValleys = "SELECT id as wref, x, y, fieldtype, occupied FROM `$WDATA` WHERE fieldtype > 0 AND $cX AND $cY" . $emptyCond;
            $resV = mysqli_query($database->dblink, $sqlValleys);
            $valleys = [];
            if ($resV) while ($r = mysqli_fetch_assoc($resV)) $valleys[] = $r;

            // Fetch Oases in R+3 logic
            $cXo = $wrapCond('w.x', $startX, $R+3, $MIN_X, $MAX_X);
            $cYo = $wrapCond('w.y', $startY, $R+3, $MIN_Y, $MAX_Y);
            $sqlOases = "SELECT w.x, w.y, o.type FROM `$ODATA` o JOIN `$WDATA` w ON w.id = o.wref WHERE $cXo AND $cYo";
            $resO = mysqli_query($database->dblink, $sqlOases);
            $oases = [];
            if ($resO) while ($r = mysqli_fetch_assoc($resO)) $oases[] = $r;

            // Compute combinations
            foreach ($valleys as $v) {
                $tw = 0; $tc = 0; $ti = 0; $tcr = 0;
                foreach ($oases as $o) {
                    // Check 7x7
                    $dx = abs($v['x'] - $o['x']);
                    $dy = abs($v['y'] - $o['y']);
                    // Wrap-aware distance for 7x7 (max distance 3)
                    if ($dx > ($MAX_X - $MIN_X + 1)/2) $dx = ($MAX_X - $MIN_X + 1) - $dx;
                    if ($dy > ($MAX_Y - $MIN_Y + 1)/2) $dy = ($MAX_Y - $MIN_Y + 1) - $dy;

                    if ($dx <= 3 && $dy <= 3) {
                        $typ = $o['type'];
                        if ($typ == 1 || $typ == 2) { $tw+=OASIS_BONUS_NORMAL; }
                        elseif ($typ == 3) { $tw+=OASIS_BONUS_MIXED; $tcr+=OASIS_BONUS_MIXED; }
                        elseif ($typ == 4 || $typ == 5) { $tc+=OASIS_BONUS_NORMAL; }
                        elseif ($typ == 6) { $tc+=OASIS_BONUS_MIXED; $tcr+=OASIS_BONUS_MIXED; }
                        elseif ($typ == 7 || $typ == 8) { $ti+=OASIS_BONUS_NORMAL; }
                        elseif ($typ == 9) { $ti+=OASIS_BONUS_MIXED; $tcr+=OASIS_BONUS_MIXED; }
                        elseif ($typ == 10 || $typ == 11) { $tcr+=OASIS_BONUS_NORMAL; }
                        elseif ($typ == 12) { $tcr+=OASIS_BONUS_STRONG; }
                    }
                }
                if ($tw >= $reqWood && $tc >= $reqClay && $ti >= $reqIron && $tcr >= $reqCrop) {
                    $v['__dist'] = $database->getDistance($startX, $startY, (int)$v['x'], (int)$v['y']);
                    $v['__bonuses'] = ['wood'=>$tw, 'clay'=>$tc, 'iron'=>$ti, 'crop'=>$tcr];
                    $found[] = $v;
                }
            }

            if (count($found) < $CAP && $tries < 3) {
                $R *= 2;
            } else {
                break;
            }
        } while (true);

        usort($found, function($a,$b) { return $a['__dist'] <=> $b['__dist']; });
        $out = array_slice($found, 0, $RENDER_MAX);
    }
}

// Live owner info for visible rows
$wrefs = array_map(function($r){ return (int)$r['wref']; }, $out);
$owners = [];
if ($wrefs) {
    $in = implode(',', array_unique($wrefs));
    $sql = "SELECT v.wref, v.name AS vname, v.owner AS owner_id, u.username
            FROM `$VDATA` v
            JOIN `$USERS` u ON u.id = v.owner
            WHERE v.wref IN ($in)";
    $res = mysqli_query($database->dblink, $sql);
    if ($res) while ($row = mysqli_fetch_assoc($res)) { $owners[(int)$row['wref']] = $row; }
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html<?php echo (defined('LANG') && LANG === 'ar') ? ' dir="rtl"' : ''; ?>>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><?php echo SERVER_NAME ?> - <?php echo (defined('LANG') && LANG === 'ar') ? 'باحث الخريطة' : 'Map Finder'; ?></title>
<link rel="shortcut icon" href="favicon.ico"/>
<meta http-equiv="cache-control" content="max-age=0" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="mt-full.js?0faab" type="text/javascript"></script>
<script src="unx.js?f4b7h" type="text/javascript"></script>
<script src="new.js?0faab" type="text/javascript"></script>
<link href="<?php echo GP_LOCATE; ?>lang/<?php echo LANG; ?>/lang.css?f4b7d" rel="stylesheet" type="text/css" />
<link href="<?php echo GP_LOCATE; ?>lang/<?php echo LANG; ?>/compact.css?v2" rel="stylesheet" type="text/css" />
<?php if($session->gpack == null || GP_ENABLE == false) {
    echo " <link href='".GP_LOCATE."travian.css?v2' rel='stylesheet' type='text/css' />";
    echo " <link href='".GP_LOCATE."lang/".LANG."/lang.css?v2' rel='stylesheet' type='text/css' />";
} else {
    echo " <link href='".$session->gpack."travian.css?v2' rel='stylesheet' type='text/css' />";
    echo " <link href='".$session->gpack."lang/".LANG."/lang.css?v2' rel='stylesheet' type='text/css' />";
} ?>
<script type="text/javascript">window.addEvent('domready', start);</script>
<link rel="stylesheet" type="text/css" href="mobile.css?v=6" />
</head>
<body class="v35 ie ie8">
<div class="wrapper">
<img style="filter:chroma();" src="img/x.gif" id="msfilter" alt="" />
<div id="dynamic_header"></div>
<?php include ("Templates/header.tpl"); ?>
<div id="mid">
<?php include ("Templates/menu.tpl"); ?>

<div id="content" class="player">
<h1><?php echo (defined('LANG') && LANG === 'ar') ? 'باحث الخريطة' : 'Map Finder'; ?></h1>
<div style="font-weight:bold; font-size:14px; margin-bottom:15px; text-align:center;">
    <a href="finder.php?mode=oasis" style="text-decoration:none; <?php echo ($mode == 'oasis') ? 'color:#000;' : 'color:#71D000;'; ?>">
        <?php echo (defined('LANG') && LANG === 'ar') ? 'البحث عن الواحات بإسم اللاعب' : 'Search for Occupied Oases'; ?>
    </a>
    | 
    <a href="finder.php" style="text-decoration:none; <?php echo ($mode == 'crop') ? 'color:#000;' : 'color:#71D000;'; ?>">
        <?php echo (defined('LANG') && LANG === 'ar') ? 'البحث عن القمحيات والواحات' : 'Search for Croppers'; ?>
    </a>
</div>

<?php if ($mode == 'crop') { ?>
<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post">
<table>
<tr>
  <td width="200"><?php echo (defined('LANG') && LANG === 'ar') ? 'نوع البحث:' : 'Search type:'; ?></td>
  <td>
    <select class="dropdown" name="s" style="padding: 5px; width: 250px;">
      <optgroup label="<?php echo (defined('LANG') && LANG === 'ar') ? 'القرى القمحية' : 'Croppers'; ?>">
          <option value="1" <?php if($selType==1) echo 'selected'; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'قمحية 15 حقل' : '15 Crop Village'; ?></option>
          <option value="2" <?php if($selType==2) echo 'selected'; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'قمحية 9 حقول' : '9 Crop Village'; ?></option>
      </optgroup>
      <optgroup label="<?php echo (defined('LANG') && LANG === 'ar') ? 'تبويب الواحات' : 'Oasis Bonus Villages'; ?>">
          <option value="3" <?php if($selType==3) echo 'selected'; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'واحات قمح 150%' : '150% Crop Bonus spot'; ?></option>
          <option value="4" <?php if($selType==4) echo 'selected'; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'واحات قمح 100%' : '100% Crop Bonus spot'; ?></option>
          <option value="5" <?php if($selType==5) echo 'selected'; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'واحات طين 100%' : '100% Clay Bonus spot'; ?></option>
          <option value="6" <?php if($selType==6) echo 'selected'; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'واحات حديد 100%' : '100% Iron Bonus spot'; ?></option>
          <option value="7" <?php if($selType==7) echo 'selected'; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'واحات خشب 100%' : '100% Wood Bonus spot'; ?></option>
          <option value="8" <?php if($selType==8) echo 'selected'; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'واحات طين 75% وقمح 75%' : '75% Clay & 75% Crop spot'; ?></option>
          <option value="9" <?php if($selType==9) echo 'selected'; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'واحات حديد 75% وقمح 75%' : '75% Iron & 75% Crop spot'; ?></option>
          <option value="10" <?php if($selType==10) echo 'selected'; ?>><?php echo (defined('LANG') && LANG === 'ar') ? 'واحات خشب 75% وقمح 75%' : '75% Wood & 75% Crop spot'; ?></option>
      </optgroup>
    </select>
  </td>
</tr>
<tr>
  <td colspan="2">
    <?php echo (defined('LANG') && LANG === 'ar') ? 'موقع البداية:' : 'Start position:'; ?> 
    x: <input type="text" name="x" value="<?php print $startX; ?>" size="4" />
    y: <input type="text" name="y" value="<?php print $startY; ?>" size="4" />
  </td>
</tr>
<tr>
  <td colspan="2">
    <label>
      <input type="checkbox" name="empty_only" value="1" <?php if(isset($_GET['empty_only']) && $_GET['empty_only']==1) echo 'checked'; ?> />
      <?php echo (defined('LANG') && LANG === 'ar') ? 'أظهر القرى الفارغة فقط' : 'Show unoccupied villages only'; ?>
    </label>
  </td>
</tr>
<tr>
  <td colspan="2"><button type="submit" class="trav_buttons" value="Search"><?php echo (defined('LANG') && LANG === 'ar') ? 'بحث' : 'Search'; ?></button></td>
</tr>
</table>
</form>

<?php if ($searchTriggered) { ?>
<table id="member">
<thead>
<tr>
  <td><?php echo (defined('LANG') && LANG === 'ar') ? 'النوع' : 'Type'; ?></td>
  <td><?php echo (defined('LANG') && LANG === 'ar') ? 'الإحداثيات' : 'Coordinates'; ?></td>
  <td><?php echo (defined('LANG') && LANG === 'ar') ? 'المالك' : 'Owner'; ?></td>
  <td><?php echo (defined('LANG') && LANG === 'ar') ? 'مشغولة' : 'Occupied'; ?></td>
  <td><?php echo (defined('LANG') && LANG === 'ar') ? 'المسافة' : 'Distance'; ?></td>
  <?php if ($selType >= 3) { ?>
    <td><?php echo (defined('LANG') && LANG === 'ar') ? 'مكافآت الواحات' : 'Oases Bonus'; ?></td>
  <?php } ?>
</tr>
</thead>
<tbody>
<?php
if (empty($out)) {
    echo "<tr><td colspan='6' style='text-align:center; padding:10px;'>
            <em style=\"color:#999;\">".(defined('LANG') && LANG === 'ar' ? 'لا توجد قرى تطابق الفلاتر المحددة.' : 'No spots found for the selected filters.')."</em>
          </td></tr>";
} else {
    foreach ($out as $row) {
        $field = '?';
        if ($row['fieldtype'] == 1) $field = '3-3-3-9'; // 9c
        elseif ($row['fieldtype'] == 2) $field = '3-4-5-6';
        elseif ($row['fieldtype'] == 3) $field = '4-4-4-6';
        elseif ($row['fieldtype'] == 4) $field = '4-5-3-6';
        elseif ($row['fieldtype'] == 5) $field = '5-3-4-6';
        elseif ($row['fieldtype'] == 6) $field = '1-1-1-15'; // 15c
        elseif ($row['fieldtype'] == 7) $field = '4-4-3-7';
        elseif ($row['fieldtype'] == 8) $field = '3-4-4-7';
        elseif ($row['fieldtype'] == 9) $field = '4-3-4-7';
        elseif ($row['fieldtype'] == 10) $field = '3-5-4-6';
        elseif ($row['fieldtype'] == 11) $field = '4-3-5-6';
        elseif ($row['fieldtype'] == 12) $field = '5-4-3-6';
        // Format based on type
        if ($selType <= 2) {
            $typeStr = ($row['fieldtype'] == 6) ? '15c' : '9c';
        } else {
            $typeStr = $field; // Show the field distribution
        }

        $x=(int)$row['x']; $y=(int)$row['y']; $id=(int)$row['wref'];
        $ov = $owners[$id] ?? null;
        $isOcc = ($row['occupied'] > 0); // or $ov !== null
        
        echo "<tr><td>$typeStr</td>";
        if (!$isOcc) {
            echo "<td><a href=\"karte.php?d=".$id."&c=".$generator->getMapCheck($id)."\">".ABANDVALLEY." ($x|$y)</a></td>";
            echo "<td>-</td>";
            echo "<td><b><font color=\"green\">".UNOCCUPIED."</font></b></td>";
        } else {
            $vname = htmlspecialchars($ov['vname'] ?? '', ENT_QUOTES, 'UTF-8');
            $owner = (int)($ov['owner_id'] ?? 0);
            $uname = htmlspecialchars($ov['username'] ?? '', ENT_QUOTES, 'UTF-8');
            echo "<td><a href=\"karte.php?d=".$id."&c=".$generator->getMapCheck($id)."\">".$vname." ($x|$y)</a></td>";
            echo "<td><a href=\"spieler.php?uid=".$owner."\">".$uname."</a></td>";
            echo "<td><b><font color=\"red\">".OCCUPIED."</font></b></td>";
        }
        echo "<td><div style=\"text-align: center\">".(int)$row['__dist']."</div></td>";
        
        if ($selType >= 3) {
            $bn = $row['__bonuses'];
            $bStr = [];
            if ($bn['wood'] > 0) $bStr[] = '<img src="img/x.gif" class="r1"> '.$bn['wood'].'%';
            if ($bn['clay'] > 0) $bStr[] = '<img src="img/x.gif" class="r2"> '.$bn['clay'].'%';
            if ($bn['iron'] > 0) $bStr[] = '<img src="img/x.gif" class="r3"> '.$bn['iron'].'%';
            if ($bn['crop'] > 0) $bStr[] = '<img src="img/x.gif" class="r4"> '.$bn['crop'].'%';
            echo "<td>".implode(' ', $bStr)."</td>";
        }
        
        echo "</tr>";
    }
}
?>
</tbody>

</table>
<?php } ?>

<?php } else { ?>
<!-- OASIS SEARCH MODE -->
<form action="<?php echo $_SERVER['PHP_SELF']; ?>?mode=oasis" method="post">
<input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>" />
<table>
<tr>
  <td width="200"><?php echo (defined('LANG') && LANG === 'ar') ? 'اسم اللاعب:' : 'Player Name:'; ?></td>
  <td>
    <input type="text" name="player_name" value="<?php echo htmlspecialchars($searched_player, ENT_QUOTES, 'UTF-8'); ?>" style="padding: 5px; width: 250px;" />
  </td>
</tr>
<tr>
  <td colspan="2">
    <?php echo (defined('LANG') && LANG === 'ar') ? 'موقع البداية:' : 'Start position:'; ?> 
    x: <input type="text" name="x" value="<?php print $startX; ?>" size="4" />
    y: <input type="text" name="y" value="<?php print $startY; ?>" size="4" />
  </td>
</tr>
<tr>
  <td colspan="2">
    <div style="color:red; font-size:11px; margin-top:5px; margin-bottom:5px;">
        <?php echo (defined('LANG') && LANG === 'ar') ? 'ملاحظة: تكلفة البحث 2000 ذهب.' : 'Note: The search costs 2000 gold.'; ?>
    </div>
    <button type="submit" name="oasis_search" class="trav_buttons" value="Search"><?php echo (defined('LANG') && LANG === 'ar') ? 'بحث' : 'Search'; ?></button>
    
    <?php if ($oasis_error) echo "<br/><br/><span style='color:red; font-weight:bold;'>$oasis_error</span>"; ?>
  </td>
</tr>
</table>
</form>

<?php if (is_array($oasis_results)) { ?>
<br />
<table id="member">
<thead>
<tr>
  <td><?php echo (defined('LANG') && LANG === 'ar') ? 'نوع الواحة' : 'Oasis Type'; ?></td>
  <td><?php echo (defined('LANG') && LANG === 'ar') ? 'الإحداثيات' : 'Coordinates'; ?></td>
  <td><?php echo (defined('LANG') && LANG === 'ar') ? 'المسافة' : 'Distance'; ?></td>
  <td><?php echo (defined('LANG') && LANG === 'ar') ? 'القرية المحتلة منها' : 'Occupied From'; ?></td>
</tr>
</thead>
<tbody>
<?php
if (empty($oasis_results)) {
    echo "<tr><td colspan='4' style='text-align:center; padding:10px;'>
            <em style=\"color:#999;\">".(defined('LANG') && LANG === 'ar' ? 'لا توجد واحات محتلة لهذا اللاعب.' : 'No occupied oases found for this player.')."</em>
          </td></tr>";
} else {
    foreach ($oasis_results as $row) {
        // Types strings
        $typeStr = '?';
        switch ($row['type']) {
            case 1: $typeStr = '<img src="img/x.gif" class="r1"> '.OASIS_BONUS_NORMAL.'%'; break;
            case 2: $typeStr = '<img src="img/x.gif" class="r1"> '.OASIS_BONUS_NORMAL.'%'; break;
            case 3: $typeStr = '<img src="img/x.gif" class="r1"> '.OASIS_BONUS_MIXED.'% <img src="img/x.gif" class="r4"> '.OASIS_BONUS_MIXED.'%'; break;
            case 4: $typeStr = '<img src="img/x.gif" class="r2"> '.OASIS_BONUS_NORMAL.'%'; break;
            case 5: $typeStr = '<img src="img/x.gif" class="r2"> '.OASIS_BONUS_NORMAL.'%'; break;
            case 6: $typeStr = '<img src="img/x.gif" class="r2"> '.OASIS_BONUS_MIXED.'% <img src="img/x.gif" class="r4"> '.OASIS_BONUS_MIXED.'%'; break;
            case 7: $typeStr = '<img src="img/x.gif" class="r3"> '.OASIS_BONUS_NORMAL.'%'; break;
            case 8: $typeStr = '<img src="img/x.gif" class="r3"> '.OASIS_BONUS_NORMAL.'%'; break;
            case 9: $typeStr = '<img src="img/x.gif" class="r3"> '.OASIS_BONUS_MIXED.'% <img src="img/x.gif" class="r4"> '.OASIS_BONUS_MIXED.'%'; break;
            case 10: $typeStr = '<img src="img/x.gif" class="r4"> '.OASIS_BONUS_NORMAL.'%'; break;
            case 11: $typeStr = '<img src="img/x.gif" class="r4"> '.OASIS_BONUS_NORMAL.'%'; break;
            case 12: $typeStr = '<img src="img/x.gif" class="r4"> '.OASIS_BONUS_STRONG.'%'; break;
        }

        $x = (int)$row['x']; $y = (int)$row['y']; $oid = (int)$row['oasis_id'];
        $vid = (int)$row['village_id'];
        $vname = htmlspecialchars($row['village_name'], ENT_QUOTES, 'UTF-8');
        
        echo "<tr>";
        echo "<td>$typeStr</td>";
        echo "<td><a href=\"karte.php?d=".$oid."&c=".$generator->getMapCheck($oid)."\">($x|$y)</a></td>";
        echo "<td><div style=\"text-align: center\">".(int)$row['dist']."</div></td>";
        echo "<td><a href=\"karte.php?d=".$vid."&c=".$generator->getMapCheck($vid)."\">".$vname."</a></td>";
        echo "</tr>";
    }
}
?>
</tbody>
</table>
<?php } ?>
<?php } ?>

</div>

<br /><br /><br /><br />
<div id="side_info">
<?php
include("Templates/multivillage.tpl");
include("Templates/quest.tpl");
include("Templates/news.tpl");
if(!NEW_FUNCTIONS_DISPLAY_LINKS) {
    echo "<br><br><br><br>";
    include("Templates/links.tpl");
}
?>
</div>
<div class="clear"></div>
</div>
<div class="footer-stopper"></div>
<div class="clear"></div>
<?php include ("Templates/footer.tpl"); include ("Templates/res.tpl"); ?>
<div id="stime">
<div id="ltime">
<div id="ltimeWrap">
<?php echo CALCULATED_IN;?> <b><?php echo round(($generator->pageLoadTimeEnd()-$start_timer)*1000); ?></b> ms
<br /><?php echo SERVER_TIME;?> <span id="tp1" class="b"><?php echo date('H:i:s'); ?></span>
</div>
</div>
</div>
<div id="ce"></div>
</div>
</body>
</html>
