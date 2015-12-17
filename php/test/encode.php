<?php
$test = array('a'=>'\w');
var_dump(json_encode($test, JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES));
var_dump(json_encode($test));
?>
