#!/usr/bin/php
<?php

class Abc{
    private $path='/data/easyops/rsyncData/install/asfsd-asdfasd';
    private $rsyncData='\/data\/easyops\/rsyncData\/';

    public function  test()
    {
        #preg_match_all('/^\/data\/(.*)$/', $path, $matches);
        preg_match_all("/^$this->rsyncData(.*)$/", $this->path, $matches);
        #preg_match_all("/^\/data\/easyops\/rsyncData\/(.*)$/", $path, $matches);
        if (!empty($matches)) {
            #var_dump($matches);
            $this->path = "easyops/".$matches[1][0];
            var_dump($this->path);
        } else {
            echo "xx";
        }
    }
}

#$abc = new Abc;
#$abc->test();

$str="/data/easyops";
#var_dump(addcslashes($str, '"\\/'));
var_dump(addcslashes($str, '/'));
