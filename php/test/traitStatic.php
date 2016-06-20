<?php

#class TestClass {
#    public static $_bar;
#}
#class Foo1 extends TestClass {}
#class Foo2 extends TestClass {}
#Foo1::$_bar = "Hello";
#Foo2::$_bar = "World";
#
#echo Foo1::$_bar . " " . Foo2::$_bar . "\n";

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
echo Foo1::$_bar . " " . Foo2::$_bar . "\n";

?>
