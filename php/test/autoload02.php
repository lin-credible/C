<?php
function __autoload($className){
    echo "__autoload class " . $className . "\n";
    require_once('libs/' . $className . '.php');
}

###
function classLoader($className){
    echo "classLoader class " . $className . "\n";
    require_once('libs/' . $className . '.php');
}
spl_autoload_register('classLoader');
###
new Test();
?>
