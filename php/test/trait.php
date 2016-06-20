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


?>
