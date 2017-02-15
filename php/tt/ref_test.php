<?php
/*
#e1:
error_reporting(E_ALL);
ini_set('display_errors', 1);
var_dump(&$a);
*/

#e2:
$arr = range(1, 3);
foreach ($arr as &$val) {
}
foreach ($arr as $val) {
}
var_dump($arr);


/*
#e3:
$arr = array(1, 3);
function test($item, $key, &$arr) {
  unset($arr[$key]);
}
var_dump(array_walk($arr, "test", &$arr));

#e4:
$arr = array(&$arr);
var_dump($arr === $arr);
*/

?>
