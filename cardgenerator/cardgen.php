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

// Calculate max height of the text
$font = new ImagickDraw();
$font->setFont("data/font.ttf");
$font->setFontSize($font_size);
$font_height = $image->queryFontMetrics($font,  "QWERTYUIOPASDFGHJKLZXCVBNM1234567890qwertyuiopasdfghjklzxcvbnm[];'\,./")["textHeight"];

// Draw border - Title
$border = new ImagickDraw();
$border->setFillColor( 'none' );

for($i=0; $i<=($scale-1); $i++) {
$color = 255 - ($i*20);
$border->setStrokeColor( new ImagickPixel('rgb('.$color.', '.$color.', '.$color.')') );
$border->setStrokeWidth('1');
$border->setStrokeAntialias( false );
$border->rectangle($X1_rail+$i, ($scale*2)+$i, $X2_rail-$i, ($scale*4)+$i+$font_height);
$image->drawImage( $border );
}

$image->setImageFormat('png');
file_put_contents ("output.png", $image);
}

echo generate_card("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k");

?>