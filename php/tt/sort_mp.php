<?php

$arr = [1, 43, 54, 62, 21, 66, 33, 55, 88];
print_r($arr);

function getpao($arr) {
  $len = count($arr);
  for ($i = 1; $i < $len; $i++) {
    for ($k = 0; $k < $len - $i; $k++) {
      if ($arr[$k] > $arr[$k + 1]) {
        #$tmp = $arr[$k + 1];
        #$arr[$k + 1] = $arr[$k];
        #$arr[$k] = $tmp;
        list($arr[$k+1], $arr[$k]) = array($arr[$k], $arr[$k+1]);
      }
    }
  }
  return $arr;
}

$xxx = getpao($arr);

print_r($xxx);
echo "\n";

?>
