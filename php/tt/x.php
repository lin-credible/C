<?php
    $namespace ='';
    static $guid = '';
    $uid = uniqid("", true);
    $data = $namespace;
    $data .= $_SERVER['REQUEST_TIME'];
    $data .= $_SERVER['REMOTE_ADDR'];
    $data .= $_SERVER['REMOTE_PORT'];
    $guid = strtolower(hash('ripemd128', $uid . $guid . md5($data)));

    echo $guid;
?>
