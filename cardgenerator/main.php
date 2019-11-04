<?php

function generate_card($text, $description, $id, $alias, $type, $level, $atk, $def, $race, $attribute, $limit) {

// Initialize variables
include("config.php");
$image = new Imagick();
$image->newPseudoImage($resolution_x, $resolution_y, 'gradient:#000000-#ffffff');




$image->setImageFormat('png');
file_put_contents ("output.png", $image);
}

echo generate_card("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k");

?>