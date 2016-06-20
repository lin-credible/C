<?php

$file = new SplFileInfo("EOF.php");
echo "File was created at: " . date("Y-m-d H:i:s", $file->getCTime()) . "\n";
echo "File was modified at: " . date("Y-m-d H:i:s", $file->getMTime()) . "\n";
echo "File size is: " . $file->getSize() . " Bytes\n";

$fileObj = $file->openFile("r");
while($fileObj->valid()){
    echo $fileObj->fgets();
}
$fileObj = null;
$file = null;
?>
