<?php

$arr = [3, 100, 60, 58, 30, 21];

function select_sort($arr) {
  for ($i = 0, $len = count($arr); $i < $len - 1; $i++) {
    $p = $i;
    for ($j = $i + 1; $j < $len; $j++) {
      if ($arr[$p] < $arr[$j]) {
        $p = $j;
      }
    }
    
    if ($p != $i) {
      $tmp = $arr[$p];
      $arr[$p] = $arr[$i];
      $arr[$i] = $tmp;
    }
  }
  return $arr;
}

$xxx = select_sort($arr);
print_r($xxx); exit;

?>
