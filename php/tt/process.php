#!/usr/bin/php
<?php

// 翻译进程信息
//

$data['proc_list'] = array(
    array('name'=>'nginx:conf/server.pid'),
    //array('name'=>'apache'),
    //array('name'=>'php-fpm:8'),
    //array('name'=>'php:1,10')
);

foreach ($data['proc_list'] as &$row) {
    if (!preg_match('/^([\w\d\-\.]+)(?:\:(\d+|[\w\d\-\.\/]+\.pid)(?:\,(\d+))?)?$/', $row['name'], $matches)) {
        ###
        echo $row['name'];
    }
    $matches = array_pad($matches, 5, null);
    if (preg_match('/^.*pid$/', $row['name'], $matchespid)) {
        list($all, $proc_name, $pid_file, $proc_num_min, $proc_num_max) = $matches;
    }else{
        list($all, $proc_name, $proc_num_min, $proc_num_max, $pid_file) = $matches;
    }
    $row = compact('proc_name', 'proc_num_min', 'proc_num_max', 'pid_file');
}
unset($row);

?>
