<?php
    $a = 2;
    $b = 'a';
    $c = 'abc';
    #print_r($GLOBALS);
    function foo() {
        global $a;  #$a = &$GLOBALS['a'];
        $a = 0;
        $a += 3;
    }
    foo();
    #echo $a, "\n";
    echo $GLOBALS['a'], "\n";
?>
