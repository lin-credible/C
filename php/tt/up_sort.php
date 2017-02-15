<?php

$arr = [1, 3, 2, 10, 30, 25];

function sort_mp($arr) {
  $len = count($arr);

  for ($i = 1; $i < $len; $i++) {
    for ($j = 0; $j < $len - $i; $j++) {
      if ($arr[$j] > $arr[$j+1]) {
        $tmp = $arr[$j];
        $arr[$j] = $arr[$j+1];
        $arr[$j+1] = $tmp;
        #list($arr[$j], $arr[$j+1]) = array($arr[$j+1], $arr[$j]); 
      }
    }
  }

  return $arr;
}

$ret = sort_mp($arr);

print_r($ret);exit;

?>
