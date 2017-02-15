<?php

class CountMe implements Countable{
    protected $_count = 3;
    public function count(){
	return $this->_count;
    }
}

$obj = new CountMe();
#echo $obj->count() . "\n";
echo count($obj) . "\n";


?>
