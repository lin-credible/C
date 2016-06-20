<?php

#$string1 = "/abc/x";
#$string2 = "/x";
#$findme = "x";
#
#var_dump(strpos($string1, $findme));
#var_dump(strpos($string2, $findme));
#
#$ret1 = strpos($string1, $findme) !== false;
#$ret2 = strpos($string2, $findme) !== false;
#
#var_dump($ret1);
#var_dump($ret2);

$url = 'test?hahaha';
echo substr($url, 0, 4)."\n";exit;
#$url = 'testhahaha';
$index = strpos($url, '?');
#var_dump($index);exit;
$path = strtolower($index === false ? $url : substr($url, 0, $index));
echo $path;
echo "\n";

?>
