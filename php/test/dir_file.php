<?php

var_dump(dirname(__FILE__));
var_dump(__DIR__);

# __DIR__ only exists with PHP >= 5.3
# which is why dirname(__FILE__) is more widely used
# __DIR__ is evaluated at compile-time, while dirname(__FILE__) means a function-call and is evaluated at execution-time
# so, __DIR__ is (or, should be) faster.


?>
