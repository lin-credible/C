<?php

$arr = [10, 20, 6, 18, 35, 60, 95];

function quick_sort($arr) {
  $length = count($arr);
  if ($length <= 1) {
    return $arr;
  }
  
  $base_num = $arr[0];
  
  $left_array = array();
  $right_array = array();

  for ($i = 1; $i < $length; $i++) {
    if ($base_num > $arr[$i]) {
      $left_array[] = $arr[$i];
    } else {
      $right_array[] = $arr[$i];
    }
  }

  $left_array = quick_sort($left_array);
  $right_array = quick_sort($right_array);
  
  return array_merge($left_array, array($base_num), $right_array);
}

$xxx = quick_sort($arr);
print_r($xxx);exit;

?>
