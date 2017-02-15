<?php

class Human {
    public $_name;
    protected $_age;
    public function eat($food){
	echo "Eating " . $food . "\n";
   }
}

class Girl extends Human {
    function __construct($name, $age){
        $this->_name = $name;
        $this->_age = $age;
    }
}

$helen = new Girl('Helen', '18');
echo $helen->_name . "\n";

?>
