<?php

$it = new FileSystemIterator(".");
foreach($it as $finfo){
    printf("%s\t%s\t%8s\t%s\n",
	date("Y-m-d H:i:s", $finfo->getMtime()),
	$finfo->isDir()?"<dir>":"",
	number_format($finfo->getSize()),
	$finfo->getFileName());
    #echo date("Y-m-d H:i:s", $finfo->getMtime())."\n";
}
?>
