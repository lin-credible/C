<?php

$int1 = 0;
$string1 = '0abc';
$string2 = '03abc';
var_dump($int1 == $string1);
var_dump($int1 === $string1);
var_dump($int1 === $string2);

?>
