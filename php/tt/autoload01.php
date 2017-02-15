<?php
spl_autoload_extensions(".class.php");
set_include_path(get_include_path().PATH_SEPARATOR."libs/");
spl_autoload_register();

new Test();
?>
