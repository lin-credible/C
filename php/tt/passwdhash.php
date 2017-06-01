<?php
/**
 * 我们想要使用默认算法哈希密码
 * 当前是 BCRYPT，并会产生 60 个字符的结果。
 *
 * 请注意，随时间推移，默认算法可能会有变化，
 * 所以需要储存的空间能够超过 60 字（255字不错）
 * 
 * echo password_hash("rasmuslerdorf", PASSWORD_DEFAULT)."\n";
 *
 */

$randomPassword = base64_encode(hash_hmac('sha256', 'chelun_passwd', openssl_random_pseudo_bytes(32)));

$hash = password_hash($randomPassword, PASSWORD_DEFAULT, ['cost' => 12]);

var_dump([
    $randomPassword,
    $hash
]);

if (password_verify($randomPassword, $hash)) {
    var_dump(['status' => 'success']);
} else {
    echo 'I can\'t let you do that, Dave!', "\n";
    exit(1);
}

