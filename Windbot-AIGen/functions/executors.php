<?php

function executor($type, $name, $executor) {
	return "AddExecutor(ExecutorType.$type, _CardId.$name, $executor);";
}

?>

