<?php

$str = 'A B C D   ? . * ';
$pattern = '/\s+/u';
$xxx = preg_split($pattern, $str);
$endStrArr = array();
foreach($xxx as $vv){
    $endStrArr[] = preg_quote($vv);
}
echo $endStr = "(" . implode('|', $endStrArr) . ")";
echo "\n";
exit;
$replacement = '|';
$endStr = '(' . preg_replace($pattern, $replacement, $str) . ')';
echo $endStr;
echo "\n";

#$reg = '(理财|管理|超市)';
#echo base64_encode($reg);
#echo "\n";
#echo 'KOS/oeaBr3znkIbotKJ86LZ85biCKQ==';
#echo "\n";
#echo base64_decode('KOS/oeaBr3znkIbotKJ86LZ85biCKQ==');
#echo "\n";
