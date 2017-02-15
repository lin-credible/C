<?php

#class Base {
#    public function sayHello() {
#        echo "Hello ";
#    }
#}
#
#trait SayWorld {
#    public function sayHello() {
#        #parent::sayHello();
#        echo "World! \n";
#    }
#}
#
#class MyHelloWorld extends Base {
#    use SayWorld;
#}
#
#$o = new MyHelloWorld();
#$o->sayHello();

####
#trait A {
#    public function smallTalk() {
#    	echo "a \n";
#    }
#    public function bigTalk() {
#    	echo "A \n";
#    }
#}
#
#trait B {
#    public function smallTalk() {
#    	echo "b \n";
#    }
#    public function bigTalk() {
#    	echo "B \n";
#    }
#}
#
#class Talker {
#    use A, B {
#        B::smallTalk insteadof A;
#    	A::bigTalk insteadof B;
#    }
#}
#
#class Aliased_Talker {
#    use A, B {
#        B::smallTalk insteadof A;
#    	A::bigTalk insteadof B;
#        B::bigTalk as talk;
#    }
#}
#
#$o = new Talker();
#$o->smallTalk();
#$o->bigTalk();
#
#$o = new Aliased_Talker();
#$o->talk();

###
#trait Hello {
#    public function sayHelloWorld() {
#	echo "Hello " . $this->getWorld() . "\n";
#    }
#    
#    abstract public function getWorld();
#}
#
#class MyHelloWorld {
#    private $world;
#    use Hello;
#    public function getWorld() {
#        return $this->world;
#    }
#    public function setWorld($val) {
#        $this->world = $val;
#    }
#}
#
#$o = new MyHelloWorld();
#$o->setWorld('Colin');
#$o->sayHelloWorld();

# trait Counter {
#     public function inc() {
#         static $c = 0;
# 	$c = $c + 1;
# 	echo "$c \n";
#     }
# }
# 
# class C1 {
#     use Counter;
# }
# 
# class C2 {
#     use Counter;
# }
# 
# $o = new C1();
# $o->inc();
# $p = new C1();
# $p->inc();
# $q = new C2();
# $q->inc();

# class TestClass {
#     public static $_bar;
# }
# class Foo1 extends TestClass {}
# class Foo2 extends TestClass {}
# Foo1::$_bar = "Hello";
# Foo2::$_bar = "World";
# 
# echo Foo1::$_bar,  " ", Foo2::$_bar, "\n";  // World World

trait TestTrait {
    public static $_bar;
}
class Foo1 {
    use TestTrait;
}
class Foo2 {
    use TestTrait;
}
Foo1::$_bar = "Hello";
Foo2::$_bar = "World";
echo Foo1::$_bar, " ", Foo2::$_bar, "\n"; //Hello World

?>
