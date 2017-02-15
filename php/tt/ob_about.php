<?php

#$level = ob_get_level();
#echo $level, "\n";

#What's the difference between ob_get_clean and ob_get_contents + ob_end_clean
#http://stackoverflow.com/questions/17792817/ob-get-contents-ob-end-clean-vs-ob-get-clean
ob_start();
echo "Hello, I'm Colin";
$result = new stdClass();
$result->userName = 'Colin';
$result->age = 24;
$result->msg = ob_get_clean();
#$result->msg = ob_get_contents();
#ob_end_clean();
print_r($result);


#What's the difference between ob_end_clean and ob_end_flush
#http://stackoverflow.com/questions/8770910/difference-between-ob-clean-and-ob-flush
ob_start();
echo "foo", "\n";
ob_end_clean();

ob_start();
echo "bar", "\n";
ob_end_flush();

?>
