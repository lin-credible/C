#!/usr/bin/php
<?php
$abc='abc';
$aa='';
$bb='bb';
$cc='0';

$results = compact(
    $abc ? 'abc' : '',
    $aa ? 'aa' : '',
    $bb ? 'bb' : '',
    $cc != null ? 'cc' : ''
);

print_r($results);

?>
