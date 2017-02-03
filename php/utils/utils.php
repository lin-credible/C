<?php

/*
 * Test
 *
 */

class Utils {

    /* 获取 某个月的最大天数（最后一天）*/
    function getMonthLastDay($month, $year) {
        switch ($month) {
            case 4 :
            case 6 :
            case 9 :
            case 11 :
                $days = 30;
                break;
            case 2 :
                if ($year % 4 == 0) {
                    if ($year % 100 == 0) {
                        $days = $year % 400 == 0 ? 29 : 28;
                    } else {
                        $days = 29;
                    }
                } else {
                    $days = 28;
                }
                break;

            default :
                $days = 31;
                break;
        }
        return $days;
    }
    
    /* 求最长公共子序列，返回LCS的长度 */
    function LCS($str1, $str2) {
        $len1 = strlen($str1);
        $len2 = strlen($str2);

        if ($len1 == 0 || $len2 == 0) {
            return 0;
        }

        $record = [];
        for ($i = 0; $i <= $len1; $i++) {
            $record[$i][0] = 0;
        }
        for ($j = 0; $j <= $len2; $j++) {
            $record[0][$j] = 0;
        }

        for ($i = 1; $i <= $len1; $i++) {
            for ($j = 1; $j <= $len2; $j++) {
                if ($str1[$i-1] == $str2[$j-1]) {
                    $record[$i][$j] = $record[$i-1][$j-1] + 1;
                } else {
                    $record[$i][$j] = max($record[$i-1][$j], $record[$i][$j-1]);
                }
            }
        }

        return $record[$len1][$len2];

    }
}

$utils = new Utils();

$lcs = $utils->LCS('abdc', 'adddhahhabheiheic');

print_r($lcs); exit;
