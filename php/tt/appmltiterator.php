<?php

$array_id = new ArrayIterator(array('1', '2', '3'));
$array_name = new ArrayIterator(array('a', 'b', 'c'));
$it = new AppendIterator();
$it->append($array_id);
$it->append($array_name);

foreach($it as $key => $value){
    echo "Value: " . $value . "\n";
}

$mit = new MultipleIterator(MultipleIterator::MIT_KEYS_ASSOC);
$mit->attachIterator($array_id, "ID"); 
$mit->attachIterator($array_name, "NAME"); 

foreach($mit as $value){
    print_r($value);
}

?>
