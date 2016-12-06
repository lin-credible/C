<?php

function resize($newWidth, $targetFile, $originalFile, $xyz) {

    $info = getimagesize($originalFile);
    $mime = $info['mime'];

    switch ($mime) {
            case 'image/jpeg':
                    $image_create_func = 'imagecreatefromjpeg';
                    $image_save_func = 'imagejpeg';
                    $new_image_ext = 'jpg';
                    break;

            case 'image/png':
                    $image_create_func = 'imagecreatefrompng';
                    $image_save_func = 'imagepng';
                    $new_image_ext = 'png';
                    break;

            case 'image/gif':
                    $image_create_func = 'imagecreatefromgif';
                    $image_save_func = 'imagegif';
                    $new_image_ext = 'gif';
                    break;

            default: 
                    throw new Exception('Unknown image type.');
    }

    $img = $image_create_func($originalFile);
    list($width, $height) = getimagesize($originalFile);

    $newHeight = ($height / $width) * $newWidth;
    $tmp = imagecreatetruecolor($newWidth, $newHeight);

    imagecopyresampled($tmp, $img, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height);
    $image_save_func($tmp, "____tmp____.$new_image_ext");

    $img2 = $image_create_func("____tmp____.$new_image_ext");

    $tmp2 = imagecreatetruecolor(500, 238);

    imagecopyresampled($tmp2, $img2, 0, 0, $xyz[0], $xyz[1], 500, (238 + $xyz[1]), $newWidth, (238 + $xyz[1]));

    if (file_exists("____tmp____.$new_image_ext")) {
        unlink("____tmp____.$new_image_ext");
    }
 
    if (file_exists($targetFile)) {
        unlink($targetFile);
    }
    $image_save_func($tmp2, "$targetFile.$new_image_ext");
}

$originalFile = __DIR__ . "/test.png";
$targetFile = __DIR__ . "/xxx";

resize(500, $targetFile, $originalFile, array(0, 150)); 

