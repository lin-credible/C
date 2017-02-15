<?php

class OuterImpl extends IteratorIterator {
    public function current(){
	return Parent::current() . "__end";
    }
    public function key(){
	return "Start__" . Parent::key();
    }
}

$array = ['a', 'b', 'c', 'd'];
$it = new OuterImpl(new ArrayIterator($array));
foreach($it as $key => $value){
    echo "Key: " . $key . ", Value: " . $value . "\n";
}

?>
