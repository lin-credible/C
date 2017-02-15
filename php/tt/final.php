<?php
final class BaseClass {
    public function bar(){
       echo "Base bar ...\n";
    }
    final public function foo(){
       echo "Base foo ...\n";
    }
}

class ChildClass extends BaseClass {
    public function bar(){
       echo "child bar ...\n";
       $this->foo();
    }
}

$obj = new ChildClass();
$obj->bar();
#$obj->foo();

?>
