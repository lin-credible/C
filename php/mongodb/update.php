<?php

try {
        $conn = new Mongo('ip:port');
        $db = $conn->colin;
        $collection = $db->test2;

        $receiver_array = array(
                        "receiver" => array(
                                "to" => array("colin", "x", "y"),
                                "cc" => array("colin", "z")
                                )
                        );

        $document = $collection->findOne( $receiver_array );
        $document['receiver']['to'] = array("fuck");
        $document['receiver']['cc'] = array("shit");

        $collection->save( $document );

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