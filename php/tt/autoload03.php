<?php

function classLoader($className){
    echo "classLoader load class: " . $className . "\n";
    #spl_autoload_extensions(".class.php, .php");
    set_include_path("libs/");
    spl_autoload($className);
}
spl_autoload_register("classLoader");
new Test();
?>
