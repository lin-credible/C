<?php

#private function w_redis($key){
	$key='haha';
	$redis_key = "COLIN_TEST{$key}";
	$redis = new Redis();
	$redis->connect('192.168.1.227', 6379);	
	$redis_rs = $redis->GET($redis_key);
	if ($redis_rs) {
		#return json_decode($redis_rs, true);
		var_dump($redis_rs);
	} else {
		$set_data = array('colin'=>$key);
		//使用redis做2分钟热点存储
		$time = @date("Y-m-d H:i:s");
		$set_data['time'] = $time;
		$redis_set = $redis->SETEX($redis_key, 60*2, json_encode($set_data));
		if (!$redis_set) {
			echo "set redix key error";#log
 		}
	}
#}

?>
