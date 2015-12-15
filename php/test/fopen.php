<?php
$file = "./test.sh";
#$file = "./test2.sh";
$fp = fopen($file, "rb");
while (!feof($fp)) {
    //设置文件最长执行时间
    set_time_limit(0);
    print(fread($fp, 1024 * 8)); //输出文件
    flush(); //输出缓冲
    ob_flush();
}
fclose($fp);
?>
