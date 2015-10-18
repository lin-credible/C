<?php
try {
        $conn = new Mongo('ip:port');
        $db = $conn->colin;
        $collection = $db->test2;

        $receiver = array(
                        "receiver" => array(
                                "to" => array("colin", "xxx", "yyy"),
                                "cc" => array("colin", "zzz")
                                )
                        );
        $collection->insert( $receiver );

        echo 'Test2 inserted with ID: ' . $receiver['_id'] . "\n";

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