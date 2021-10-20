<?php

// Find all decks and create a info to Bot script

function generate_deck() {

	$scan_decks = scandir('decks');
	$return = '[Deck(';
	for($i=2; $i<=count($scan_decks)-1; $i++) {
		$deck_name = str_replace('.ydk', '', $scan_decks[$i]);
		$return = $return . "\"$deck_name\" ";
	}
	
	$return = str_replace(' ', ', ', rtrim($return));
	$return = $return . ')]';

	return $return;
}