<?php

// Ugly Tab converter
function autotab($number) {
	$return = '';
	for($i=1; $i<=$number; $i++) {
		$return = $return.'	';
	}
	
	return $return;
}

?>