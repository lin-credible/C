<?php

$input = array(
    'a'  => 'A',
    'b'  => 'B',
    'c' => 'C'
);

$output = implode(',', array_map(
    function ($v, $k) {
        if (is_array($v)){
            return $k.'[]:'.implode('&'.$k.'[]:', $v);
        } else {
            return $k.':'.$v;
        }
    }, 
    $input, 
    array_keys($input)
));

print_r($output);exit;

