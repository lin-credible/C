<?php    
    
    $routes = array(
        'GET /api/search' => 'search',
        'POST /api/session' => 'signin',
    ); 
    
   foreach ($routes as $path => $method) {
	#var_dump($path);exit;
	var_dump($method);exit;
	#Flight::route($path, array($this, $method), strpos($path, '*') !== false);
   }

?>
