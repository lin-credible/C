<?
define('FW', true);
require_once './common.php';

//$user->checkLoginHeader();
//$template->assign("userName", $user->loginName);
//$template->assign("userId", $user->loginName);

$oTest = new Colin();

$all = $oTest->single_line_statistics();
/*
*   $sql ="select date,count from highstock_single_line where type='1' order by date";
*
*/

$sData = array(
    'ALL' => array(
        'name' => 'XXX',
        'data' => array()
    )
);
foreach ($all as $row) {
    $t = strtotime($row['date']) * 1000;
    //$t = strtotime($row['uptime']);

    $sData['ALL']['data'][] = array(
        $t,
        intval($row['count'])
    );
}

$Data = array_values($sData);

header('Content-Type: application/json');
echo json_encode($Data);
