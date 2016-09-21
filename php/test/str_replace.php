<?php

#$class = 'Controller\\Colin';
#$class = 'Controller_Colin';
#$class_file = str_replace(array('\\', '_'), '/', $class).'.php';
#var_dump($class_file);

// Provides: You should eat pizza, beer, and ice cream every day
# $phrase  = "You should eat fruits, vegetables, and fiber every day.";
# $healthy = array("fruits", "vegetables", "fiber");
# $yummy   = array("pizza", "beer", "ice cream");
# 
# $newphrase = str_replace($healthy, $yummy, $phrase);
# echo $newphrase . "\n";

$content = "<!-- iWorker Config Will Be Here -->";

$jsConfigString = json_encode(array('a', 'b'));

$jsConfigScript = <<<EOT
<script>(function(root){root.Config={$jsConfigString};root.Config.timeOffset=iWorkerConfig.serverTime-(new Date());})(window);</script>
EOT;

echo str_replace('<!-- iWorker Config Will Be Here -->', $jsConfigScript, $content);

?>
