<?php
    $a = 2;
    $b = 'a';
    $c = 'abc';
    #print_r($GLOBALS);
    function foo() {
        #global $a;  $a = &$GLOBALS['a'];
        $a = 0;
        $a += 2;
    }
    foo();
    echo $a."\n";
?>
