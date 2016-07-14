<?php

#echo strcmp("hello", "Hello") . "\n";

$class = "Foo\\Bar\\Baz\\Qux";

$prefix = "Foo\\Bar\\";

$base_dir = __DIR__ . "/src/";

$len = strlen($prefix);

echo strncmp($prefix, $class, $len) . "\n";

$relative_class = substr($class, $len);

echo $relative_class . "\n";

echo $base_dir . str_replace("\\", "/", $relative_class) . ".php" . "\n";

# if (strncmp($prefix, $class, $len) !== 0) {
#     return;
# }

?>
