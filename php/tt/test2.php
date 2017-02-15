<?php
$json =  array(
    'Sample' => array(
        'context' => '哈哈'
    )
);
var_dump(mb_convert_encoding(json_encode($json), "UTF-8"));
