<?php
    #$a = array_fill(0, 10, array_fill(0, 10, 0));
    #var_dump($a);
    $idArray = explode(';', '10;20;23');
    print_r($idArray);
    #print_r(array_fill(0, count($idArray), '?'));
    $inQuery = implode(',', array_fill(0, count($idArray), '?'));
    print_r($inQuery);
    #$where[] = 'id IN(' . $inQuery . ')';
    #$values = $idArray;
?>
