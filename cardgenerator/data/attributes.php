<?php

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

function monster_race($race) {

if($race == 1) { return "Warrior";}
else if($race == 2) { return "Spellcaster"; }
else if($race == 4) { return "Fairy"; }
else if($race == 8) { return "Fiend"; }
else if($race == 16) { return "Zombie"; }
else if($race == 32) { return "Machine"; }
else if($race == 64) { return "Aqua"; }
else if($race == 128) { return "Pyro"; }
else if($race == 256) { return "Rock"; }
else if($race == 512) { return "Winged Beast"; }
else if($race == 1024) { return "Plant"; }
else if($race == 2048) { return "Insect"; }
else if($race == 4096) { return "Thunder"; }
else if($race == 8192) { return "Dragon"; }
else if($race == 16384) { return "Beast"; }
else if($race == 32768) { return "Beast Warrior"; }
else if($race == 65536) { return "Dinosaur"; }
else if($race == 131072) { return "Fish"; }
else if($race == 262144) { return "Sea Serpent"; }
else if($race == 524288) { return "Reptile"; }
else if($race == 1048576) { return "Psychic"; }
else if($race == 2097152) { return "Divine Beast"; }
else if($race == 4194304) { return "Creator God"; }
else if($race == 8388608) { return "Wyrm"; }
}

function monster_type($type) {
if($type == 17) { return ""; }
else if($type == 33) { return "/ Effect"; }
else if($type == 65) { return "/ Fusion"; }
else if($type == 97) { return "/ Fusion / Effect"; }
else if($type == 129) { return "/ Ritual"; }
else if($type == 161) { return "/ Ritual / Effect"; }
else if($type == 545) { return "/ Spirit / Effect"; }
else if($type == 673) { return "/ Spirit / Ritual / Effect"; }
else if($type == 1057) { return "/ Union / Effect"; }
else if($type == 2081) { return "/ Gemini / Effect"; }
else if($type == 8193) { return "/ Synchro"; }
else if($type == 8225) { return "/ Synchro / Effect"; }
else if($type == 12321) { return "/ Tuner / Synchro / Effect"; }
else if($type == 16385 || $type == 16401) { return "/ Token"; }
else if($type == 2097185) { return "/ Flip / Effect"; }
else if($type == 2101281) { return "/ Tuner / Flip / Effect"; }
else if($type == 4194337) { return "/ Toon / Effect"; }
else if($type == 6388609) { return "/ XYZ"; }
else if($type == 8388641) { return "/ XYZ / Effect"; }
else if($type == 16777233) { return "/ Pendulum"; }
else if($type == 16777249) { return "/ Pendulum / Effect"; }
else if($type == 16777313) { return "/ Fusion / Pendulum / Effect"; }
else if($type == 16781345) { return "/ Tuner / Pendulum / Effect"; }
else if($type == 16785441) { return "/ Synchro / Pendulum / Effect"; }
else if($type == 18874401) { return "/ Flip / Pendulum / Effect"; }
else if($type == 25165857) { return "/ XYZ / Pendulum / Effect"; }
}