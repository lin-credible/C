<?php

$size = "large";
$var_array = array("color" => "blue", "size" => "medium", "shape" => "sphere");
extract($var_array, EXTR_PREFIX_SAME, "wddx");

echo "$color, $size, $shape, $wddx_size\n";

?>
