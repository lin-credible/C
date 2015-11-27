<?php

define('APP_ROOT', dirname(__FILE__).'/');

class Log {
    public function _write($messages){
        if(!$messages){
            return false;
        }
        error_log($messages, 3, "/var/tmp/colin-test-errors.log");
    }

    public function write($message, $level = 'Error', $log_file_name = null) {

        if (!$message) {
           return false;
        }

        if (is_null($log_file_name)) {
           $log_file_name = APP_ROOT . 'logs/' . date('Y_m_d', $_SERVER['REQUEST_TIME']) . '.log';
        }

        if (is_file($log_file_name) && filesize($log_file_name) >= 2097152) {
           rename($log_file_name, APP_ROOT . 'logs/' . $_SERVER['REQUEST_TIME'] . '-' . basename($log_file_name));
        }

        error_log(date('[Y-m-d H:i:s]', time()) . " {$level}: {$message}\r\n", 3, $log_file_name);
    }
}

$test = new Log();

for($i = 0; $i < 10; $i++){
    $test->write($i." --- \n");
}

?>
