<?php

$a = 1;
$b = 2;

# method: 1
#$a=$a^$b;
#$b=$b^$a;
#$a=$a^$b;

# method: 2
#list($b, $a) = array($a, $b);

# method: 3
$a .= $b;
$b=str_replace($b, '', $a);
$a=str_replace($b, '', $a);

print_r($a);
echo "\n";
print_r($b);
echo "\n";

?>
