<?php

class Test {
    public $default;

    public function __toString(){
        return "Use class: '" . __CLASS__ . "' as a string";
    }

    public function __invoke($params){
        echo "Use class: '" . __CLASS__ . "' as a function\n";
	var_dump($params);
    }

    public function __call($name, $params){
        echo "Calling Test->" . $name . " with params: " . implode(', ', $params) . "\n";
    }
    
    public function __get($key){
        echo "Getting Test->" . $key . "\n";
    }

    public function __set($key, $value){
        echo "Setting Test->" . $key . " = " . $value . "\n";
    }
}

$o = new Test();
#echo $o . "\n";
$o('hahaheihei');
#$o->call('a', 'b');
#echo $o->abc;
#$o->name = 'Colin';

?>
