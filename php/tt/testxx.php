<?php

$result = new stdClass();
$result['heihei'] = 'yy';
$haha = 'xx';
$result->$haha = "haha";
$retuls->heihei = intval('3');

var_dump($result);exit;

?>
