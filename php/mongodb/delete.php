<?php
try {
        $conn = new Mongo('ip:port');
        $db = $conn->colin;
        $collection = $db->test2;

        $receiver_array = array(
                        "receiver" => array(
                            "to" => array("colin", "xxx", "yyy"),
                            "cc" => array("colin", "zzz"))
                        );

        // $receiver_array = array(
        //                 '_id' => new MongoId( 'find the _id firstly!' ),
        //                 );
        // $collection->remove( $receiver_array );

        $r = $collection->remove( $receiver_array, array( 'safe' => true ) );
        echo $r['n'] . " documents deleted \n";

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