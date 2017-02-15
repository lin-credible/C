<?php
$arr = array(
    'helen' => 'helen value',
    'colin' => 'colin value',
    'sb' => 'sb value'
);

$arrObj = new ArrayObject($arr);
$it = $arrObj->getiterator();

$it->rewind();
while($it->valid()){
    echo "Key: " . $it->key() . " , Value: " . $it->current() . "\n";
    $it->next();
}

echo "***\n";
$it->rewind();
if($it->valid()){
    $it->seek(1);
    while($it->valid()){
        echo "Key: " . $it->key() . " , Value: " . $it->current() . "\n";
        $it->next();
    }
}

echo "***\n";
$it->ksort();
foreach($it as $key => $value){
    echo "Key: " . $key . " , Value: " . $value . "\n";
}

echo "***\n";
$it->asort();
foreach($it as $key => $value){
    echo "Key: " . $key . " , Value: " . $value . "\n";
}
?>
