<?php

function foo($a, $b, $c, $_ = null) {
    $args = func_get_args();
    array_splice($args, 0, 2);
    print_r($args);
}

foo("Colin", "Helen", 3);

?>
