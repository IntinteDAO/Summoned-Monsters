#!/usr/bin/php

<?php

// I have no idea if this code works properly, lol.
// Disable bot spawning

chdir('PATH TO WINDBOT DIRECTORY');
$is_mono_run = shell_exec("ps -A | grep mono | awk '{print $1}'");

if(empty($is_mono_run)) {
	shell_exec("screen -dmSL windbot ./start.sh");
}


