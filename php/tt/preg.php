<?php
$array = array("/a/b/c", "/a/b/");
#$fl_array = preg_grep("/^\/(([^\/]+)(\/[^\/]+)*)?$/", $array);
$fl_array = preg_grep("/^\/(([^\/]+)(\/[^\/]+)*)?(\/)?$/", $array);
print_r($fl_array);
?>
