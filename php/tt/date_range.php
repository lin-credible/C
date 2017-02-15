<?php

$a = new stdClass();
$a->start = "2016-07-02";
$a->end = "2016-07-09";
$days = 5;
$days_ago = date("Y-m-d",strtotime("-1 month"));

echo strtotime($a->end), "\n", strtotime($a->start), "\n",  $days_ago, "\n";

#var_dump($a);exit;

?>
