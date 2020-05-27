<?php

function generate_card($text, $description, $id, $alias, $type, $level, $atk, $def, $race, $attribute, $limit) {

// Initialize variables
include("config.php");
include("data/attributes.php");
$image = new Imagick();

// Background
if($type==17) { $color1 = 'rgb(176, 176, 83)'; $color2 = 'rgb(165, 132, 51)'; } // Normal
else if($type==33 || $type==545 || $type==1057 || $type==2081 || $type==2097185 || $type==4194337) { $color1 = 'rgb(184, 133, 93)'; $color2 = 'rgb(168, 85, 51)'; } // Effect
else if($type==2 || $type==130 || $type==65538 || $type==131074 || $type==262146 || $type==524290) { $color1 = 'rgb(93, 161, 140)'; $color2 = 'rgb(64, 85, 70)'; } // Magic
else if($type==4 || $type==131076 || $type==1048580) { $color1 = 'rgb(205, 140, 170)'; $color2 = 'rgb(124, 66, 107)'; } // Trap
else if($type==65 || $type==97) { $color1 = 'rgb(123, 76, 154)'; $color2 = 'rgb(103, 80, 122)'; } // Fusion
else if($type==129 || $type==161 || $type==673) { $color1 = 'rgb(107, 117, 170)'; $color2 = 'rgb(65, 74, 91)'; } // Ritual
else { die("Unknown type"); }

$image->newPseudoImage($resolution_x, $resolution_y, 'gradient:'.$color1.'-'.$color2.'');

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

// Draw text - Title
$title = new ImagickDraw();
$title->setFillColor("white");
$title->setFont("data/font.ttf");
$title->setFontSize($font_size);
$title->annotation($X1_rail+$i, $scale+$font_height, $text);
$image->drawImage($title);

// Draw text - Attribute
$attr = new ImagickDraw();
$attr->setFillColor("white");
$attr->setFont("data/font.ttf");
$attr->setFontSize($font_size);
$attr->annotation($X1_rail+$i, ($scale*4)+$i+$font_height+$font_height, attributes($attribute, $type));
$image->drawImage($attr);

// Draw sprite - Star
if($type!=0 && $attribute > 0) {
$star = new Imagick("data/star.png");
$star->scaleImage($font_size, $font_size, true);
$image->setImageVirtualPixelMethod(Imagick::VIRTUALPIXELMETHOD_TRANSPARENT);
$image->setImageArtifact('compose:args', "1,0,-0.5,0.5");
$image->compositeImage($star, Imagick::COMPOSITE_MATHEMATICS, $X2_rail - $font_size, ($scale*4)+$i+$font_size+$scale);
}

// Draw text - Level
if($type!=0 && $attribute > 0) {
$star = new ImagickDraw();
$star->setFillColor("white");
$star->setFont("data/font.ttf");
$star->setFontSize($font_size);
$star_width = $image->queryFontMetrics($font,  $level.'x')["textWidth"];
$star->annotation($X2_rail - $font_size - $star_width, ($scale*4)+$i+$font_size+$font_height, $level.'x');
$image->drawImage($star);
}

if($attribute==0) {
$spell_attr = new ImagickDraw();
$spell_attr->setFillColor("white");
$spell_attr->setFont("data/font.ttf");
$spell_attr->setFontSize($font_size);
$spell_attr_width = $image->queryFontMetrics($font, spell_type($type))["textWidth"];
$spell_attr->annotation($X2_rail - $spell_attr_width, ($scale*4)+$i+$font_size+$font_height, spell_type($type));
$image->drawImage($spell_attr);
}

// Sprite border
$border = new ImagickDraw();
$border->setFillColor( 'none' );

for($i=0; $i<=$scale; $i++) {
$color = 255 - $i*20;

$border->setStrokeColor( new ImagickPixel('rgb('.$color.', '.$color.', '.$color.')') );
$border->setStrokeWidth('1');
$border->setStrokeAntialias( false );
$vertical = $X2_rail - $X1_rail - ($scale*2);
$border->rectangle($X1_rail + $i, ($scale*8)+$i+$font_size+$font_height, $X2_rail - $i, ($scale*8)+$i+$font_size+$font_height + $vertical);
$image->drawImage( $border );
}

// Draw sprite
$star = new Imagick("ItsATrap.png");
$star->scaleImage($vertical, $vertical, true);
$image->compositeImage($star, Imagick::COMPOSITE_DEFAULT, $X1_rail + $i, ($scale*8)+$i+$font_size+$font_height);


$image->setImageFormat('png');
file_put_contents ("output.png", $image);
}

echo generate_card("a", "b", "c", "d", 17, 6, "g", "h", "i", 16, "k");

?>