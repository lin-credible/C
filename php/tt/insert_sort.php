<?php

$arr = [10, 20, 6, 18, 35, 60, 95];

function insert_sort($arr) {
  for ($i = 1, $len = count($arr); $i < $len; $i++) {
    $tmp = $arr[$i];
    for ($j = $i - 1; $j >= 0; $j--) {
      if ($tmp < $arr[$j]) {
        $arr[$j+1] = $arr[$j];
        $arr[$j] = $tmp;
      } else {
        break;
      }
    }
  }

  return $arr;
}

$xxx = insert_sort($arr);
print_r($xxx);exit;

?>
