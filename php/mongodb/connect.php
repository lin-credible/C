<?php
try {
    // $conn = new Mongo('ip:port');
    $conn = new MongoClient('ip:port');
    $db = $conn->colin;
    $collection = $db->test2;
    $cursor = $collection->find();
    $num_docs = $cursor->count();

    if( $num_docs > 0 )
    {
        foreach ($cursor as $obj)
        {
            print_r($obj['receiver']);
        }
    }
    else
    {
        echo "No receiver found \n";
    }
    $conn->close();
}
catch ( MongoConnectionException $e )
{
    echo $e->getMessage();
}
catch ( MongoException $e )
{
    echo $e->getMessage();
}
?>
