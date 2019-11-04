<?php

function generate_card($text, $description, $id, $alias, $type, $level, $atk, $def, $race, $attribute, $limit) {

// Initialize variables
include("config.php");
$image = new Imagick();

// Background
$image->newPseudoImage($resolution_x, $resolution_y, 'gradient:#000000-#ffffff');

// Border
$border = new ImagickDraw();
$border->setFillColor( 'none' );

for($i=0; $i<=$scale; $i++) {
$color = $i*20;
$border->setStrokeColor( new ImagickPixel('rgb('.$color.', '.$color.', '.$color.')') );
$border->setStrokeWidth('1');
$border->setStrokeAntialias( false );
$border->rectangle($i, $i, $resolution_x - 1 - $i, $resolution_y - 1 - $i);
$image->drawImage( $border );
}



$image->setImageFormat('png');
file_put_contents ("output.png", $image);
}

echo generate_card("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k");

?>