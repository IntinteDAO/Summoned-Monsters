<?php

// Find all decks and create a info to Bot script

function generate_deck($deck_name) {

	$return = '[Deck(';
		$return = $return . "\"$deck_name\" ";
	
	$return = str_replace(' ', ', ', rtrim($return));
	$return = $return . ')]';

	return $return;
}