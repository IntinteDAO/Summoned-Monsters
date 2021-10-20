#!/usr/bin/php

<?php

require_once('functions/autotab.php');
require_once('functions/generate_deck.php');
require_once('functions/cardid.php');
require_once('functions/executors.php');

// If file exists - remove it
if(file_exists('AIOutput.cs')) {
	unlink('AIOutput.cs');
}
$autotab = 0;

// Create file
$output = fopen('AIOutput.cs', 'a+');

// Save includes (includes.cs)
$temp_file = file('functions/includes.cs');
for($i=0; $i<=count($temp_file)-1; $i++) {
	fwrite($output, autotab($autotab).trim($temp_file[$i]).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Save header (header.cs)
$autotab = 1;
$temp_file = file('functions/header.cs');
for($i=0; $i<=count($temp_file)-1; $i++) {
	fwrite($output, autotab($autotab).trim($temp_file[$i]).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Add decks
$decks = generate_deck();
fwrite($output, autotab($autotab).trim($decks).PHP_EOL);
fwrite($output, PHP_EOL);

// Save Script header (script_header.cs)
$autotab = 1;
$temp_file = file('functions/script_header.cs');
for($i=0; $i<=count($temp_file)-1; $i++) {
	fwrite($output, autotab($autotab).trim($temp_file[$i]).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Save CardID header (cardid_header.cs)
$autotab = 2;
$temp_file = file('functions/cardid_header.cs');
for($i=0; $i<=count($temp_file)-1; $i++) {
	fwrite($output, autotab($autotab).trim($temp_file[$i]).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Generate CardID values
$autotab = 3;
$temp_file = file('functions/lists/cardid_list.txt');
for($i=0; $i<=count($temp_file)-1; $i++) {
	$explode = explode(',', $temp_file[$i]);
	fwrite($output, autotab($autotab).trim(cardid(trim($explode[0]), trim($explode[1]))).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Close CardID header (cardid_header.cs -> footer.cs)
$autotab = 2;
$temp_file = file('functions/footer.cs');
for($i=0; $i<=count($temp_file)-1; $i++) {
	fwrite($output, autotab($autotab).trim($temp_file[$i]).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Save Executor header (executor_header.cs)
$autotab = 2;
$temp_file = file('functions/executor_header.cs');
for($i=0; $i<=count($temp_file)-1; $i++) {
	fwrite($output, autotab($autotab).trim($temp_file[$i]).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Save Default Executors
$autotab = 3;
$temp_file = file('functions/default_executors.cs');
for($i=0; $i<=count($temp_file)-1; $i++) {
	fwrite($output, autotab($autotab).trim($temp_file[$i]).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Generate Executor values
$autotab = 3;
$temp_file = file('functions/lists/executors_list.txt');
for($i=0; $i<=count($temp_file)-1; $i++) {
	$explode = explode(',', $temp_file[$i]);
	fwrite($output, autotab($autotab).trim(executor(trim($explode[0]), trim($explode[1]), trim($explode[2]))).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Close Executor header (executor_header.cs -> footer.cs)
$autotab = 2;
$temp_file = file('functions/footer.cs');
for($i=0; $i<=count($temp_file)-1; $i++) {
	fwrite($output, autotab($autotab).trim($temp_file[$i]).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Merge Events
$autotab = 2;
$executors = scandir('functions/events');

for($j=2; $j<=count($executors)-1; $j++) {
	$temp_file = file('functions/events/'.$executors[$j]);
	for($i=0; $i<=count($temp_file)-1; $i++) {
		fwrite($output, autotab($autotab).rtrim($temp_file[$i]).PHP_EOL);
	}
	fwrite($output, PHP_EOL);
}


// Close Script header (script_header.cs -> footer.cs)
$autotab = 1;
$temp_file = file('functions/footer.cs');
for($i=0; $i<=count($temp_file)-1; $i++) {
	fwrite($output, autotab($autotab).trim($temp_file[$i]).PHP_EOL);
}
fwrite($output, PHP_EOL);

// Close header (header.cs -> footer.cs)
$autotab = 1;
$temp_file = file('functions/footer.cs');
for($i=0; $i<=count($temp_file)-1; $i++) {
	fwrite($output, autotab($autotab).trim($temp_file[$i]).PHP_EOL);
}
fwrite($output, PHP_EOL);

fclose($output);

?>