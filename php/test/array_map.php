<?php

#$a = array(1, 2, 3, 4, 5);
#$b = array("uno", "dos", "tres", "cuatro", "cinco");

#$a = '1/2';
#$b = 'a/b';

$a = '';
var_dump(explode('/', $a));exit;
$b = '';

$d = implode(',', array_map(function($k, $v){
    if (!empty($k)){
        return $k . ':' . $v;
    }
    return '';
}, explode('/', $a) , explode('/', $b)));

print_r($d);

?>
