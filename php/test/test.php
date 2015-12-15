<?php
date_default_timezone_set('Asia/Shanghai');

#echo date('YmdHis',time() - 5 * 60);
#echo "\n";
#echo strtotime('20150705143500');
#echo "\n";
#echo strtotime('20150705143600') + 60;
#echo "\n";
#echo strtotime(date('YmdHis',time() - 10800));
#echo "\n";
#echo strtotime('now');
#echo "\n";
#echo strtotime('now') - strtotime(date('YmdHis',time() - 24000));

#echo $x = mktime(date('H'), date('i'), date('s'), date('m'), date('d'), date('Y')) - 10800;
#echo "\n";
#echo $y = strtotime(date('YmdHis'), time() - 10800);

#echo strtotime(date('YmdHis',time() - 10800));
#$unixtime = 1440840721000;
$unixtime = 1440840721;
echo date('Y/m/d H:i:s A T', $unixtime);
#echo "\n";
#echo date('Y/m/d H:i:s A T', $x);
#echo "\n";
#echo date('Y/m/d H:i:s A T', $y);

#echo $y = strtotime(date('YmdHis'), time() - 10800);

?>
