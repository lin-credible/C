<?php
try {
    // $conn = new Mongo('ip:port');
    //$conn = new MongoClient('ip:port');
    #$db = $conn->colin;
    #$collection = $db->test2;

    $uri = "mongodb://192.168.1.254:27021/";
    $options = array('connect' => FALSE);
    $conn = new MongoClient($uri, $options);
    $db = $conn->iworker_attach;
    $tmp = 'attachments.files';
    $collection = $db->$tmp;
    $cursor = $collection->find();
    $num_docs = $cursor->count();

    if( $num_docs > 0 )
    {
        foreach ($cursor as $obj)
        {
            echo $obj['company_id'], "\n";
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
