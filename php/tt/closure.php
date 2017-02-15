<?php
#111111
# echo preg_replace_callback('~-([a-z])~', function ($match){
#     return strtoupper($match[1]);
# }, 'hello-world');

#222222
#$greet = function($name)
#{
#    printf("Hello %s\r\n", $name);
#};
#$greet('World');
#$greet('PHP');

#333333
$message = 'hello';

# no 'use'
$example = function() {
    var_dump($message);
};
echo __LINE__;
echo $example();

# inherit $message
$example = function() use ($message) {
    var_dump($message);
};
echo __LINE__;
echo $example();

$message = 'world';
echo __LINE__;
echo $example();

#reset message
$message = 'hello';

$example = function() use (&$message) {
    var_dump($message);
};
echo __LINE__;
echo $example();

$message = 'world';
echo __LINE__;
echo $example();

$example = function($arg) use ($message) {
    var_dump($arg . ' ' . $message);
};
echo __LINE__;
$example("hello");

?>
