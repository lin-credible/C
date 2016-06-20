<?php

#$class = 'Controller\\Colin';
#$class = 'Controller_Colin';
#$class_file = str_replace(array('\\', '_'), '/', $class).'.php';
#var_dump($class_file);

// Provides: You should eat pizza, beer, and ice cream every day
$phrase  = "You should eat fruits, vegetables, and fiber every day.";
$healthy = array("fruits", "vegetables", "fiber");
$yummy   = array("pizza", "beer", "ice cream");

$newphrase = str_replace($healthy, $yummy, $phrase);
echo $newphrase . "\n";

?>
