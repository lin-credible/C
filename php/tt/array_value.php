<?php

$str = '{"颜色":"红色","尺寸":"S码"}';

$obj = json_decode($str);

$map = array('颜色', '尺寸');

print_r(implode('/', array_map(function($v){
	global $obj;
        return $obj->$v;
    }, $map)));

?>
