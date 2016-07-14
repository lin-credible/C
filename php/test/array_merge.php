<?php

$array1 = $array2 = range(5, 10);
shuffle($array1);
shuffle($array2);

$array_all = array_merge($array1, $array2);
$array_all_unique = array_unique($array_all);
var_dump($array_all);
var_dump($array_all_unique);

#echo count($array1), "\n", count($array2), "\n", count($array_all), "\n";
echo count($array1), "\n", count($array2), "\n", count($array_all), "\n", count($array_all_unique), "\n";

?>
