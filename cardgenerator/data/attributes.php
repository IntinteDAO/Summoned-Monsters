<?php

$load_attribute=1;

function attributes($attribute, $type) {

if($attribute==1) { return "Earth"; }
else if($attribute==2) { return "Water"; }
else if($attribute==4) { return "Fire"; }
else if($attribute==8) { return "Wind"; }
else if($attribute==16) { return "Light"; }
else if($attribute==32) { return "Dark"; }
else if($attribute==64) { return "Divine"; }
else if($type==2 || $type==130 || $type==65538 || $type==131074 || $type==262146 || $type==524290) { return "[SPELL CARD]"; }
else if($type==4 || $type==131076 || $type==1048580) { return "[TRAP CARD]"; }
else { return "ERROR"; }

}

function spell_type($type) {

if($type==65538)
return "Quick-Play";

if($type==131074 || $type==131076)
return "Continuous";

if($type==262146)
return "Equip";

if($type==524290)
return "Field";

if($type==65538)
return "Counter";
}