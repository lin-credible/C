<?php
$string = <<<XML
<?xml version='1.0'?> 
<config>
 <title>SayHello</title>
 <from>Colin</from>
 <to>Helen</to>
 <content>Hello, how's it going?</content>
</config>
XML;

#echo $string;

$xml = simplexml_load_string($string);
print_r($xml);

?>
