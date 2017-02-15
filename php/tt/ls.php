<?php
$dir = "/Users/colintao";
$command = "ls {$dir}";
exec($command,$out);
print_r($out);
