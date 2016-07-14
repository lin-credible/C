<?php

define('PATH', __DIR__);
$config = yaml_parse_file(PATH . "/config.yaml");
var_dump($config);

?>
