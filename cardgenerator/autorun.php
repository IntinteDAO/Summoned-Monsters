<?php

require('cardgen.php');
include_once("config.php");
include_once("data/attributes.php");

$files = scandir('cards/stats');
unset($files[0]);
unset($files[1]);
$files = array_values($files);

// Creating output data
if(!file_exists('output')) {
	mkdir('output');
	mkdir('output/scripts');
	mkdir('output/pics');
	mkdir('output/pics/thumbnail');
	$db = new SQLite3('output/cards.cdb');
	$db->query("

	CREATE TABLE 'datas' (
		'id'	integer,
		'ot'	integer,
		'alias'	integet,
		'setcode'	INT64,
		'type'	integer,
		'atk'	integer,
		'def'	integer,
		'level'	integer,
		'race'	integer,
		'attribute'	integer,
		'category'	integer,
		PRIMARY KEY(id)
	);

	CREATE TABLE 'texts' (
		'id'	integer,
		'name'	varchar(128),
		'desc'	varchar(1024),
		'str1'	varchar(256),
		'str2'	varchar(256),
		'str3'	varchar(256),
		'str4'	varchar(256),
		'str5'	varchar(256),
		'str6'	varchar(256),
		'str7'	varchar(256),
		'str8'	varchar(256),
		'str9'	varchar(256),
		'str10'	varchar(256),
		'str11'	varchar(256),
		'str12'	varchar(256),
		'str13'	varchar(256),
		'str14'	varchar(256),
		'str15'	varchar(256),
		'str16'	varchar(256),
		PRIMARY KEY(id)
	);

");


}

// Building cards

if(empty($db_ready)) { $db = new SQLite3('output/cards.cdb'); }
$limit_file = fopen('output/lflist.conf', 'w');
fwrite($limit_file, '#[OpenYGO]'.PHP_EOL);
fwrite($limit_file, '!OpenYGO'.PHP_EOL);

for($i=0; $i<=count($files)-1; $i++) {
	$filename = str_replace('.json', '', $files[$i]);
	$data = json_decode(file('cards/stats/'.$files[$i])[0], TRUE);
	$id = $data['id'];
	$name = $data['name'];
	$description = $data['description'];
	$alias = $data['alias'];
	$type = $data['type'];
	$atk = $data['atk'];
	$def = $data['def'];
	$level = $data['level'];
	$race = $data['race'];
	$attribute = $data['attribute'];
	$limit = $data['limit'];
	echo 'Compiling '.str_replace("''", "'", $name).PHP_EOL;
	if(file_exists('cards/sprites/'.$filename.'.png')) { $file = 'cards/sprites/'.$filename.'.png'; } else { $file = 'cards/sprites/'.$filename.'.webp'; }
	generate_card(str_replace("''", "'", $name), str_replace("''", "'", $description), $id, $alias, $type, $level, $atk, $def, $race, $attribute, $file);
	$db->query("INSERT INTO datas VALUES($id, 3, $alias, 0, $type, $atk, $def, $level, $race, $attribute, 0)");
	$db->query("INSERT INTO texts VALUES($id, '$name', '$description','','','','','','','','','','','','','','','','')");
	rename('output.jpg', 'output/pics/'.$id.'.jpg');
	rename('thumb.jpg', 'output/pics/thumbnail/'.$id.'.jpg');

	if(file_exists('cards/scripts/'.$filename.'.lua')) { copy('cards/scripts/'.$filename.'.lua', 'output/scripts/c'.$id.'.lua'); }

	if($limit < 3) {
		fwrite($limit_file, $id.' '.$limit.' -- '.$name.PHP_EOL);
	}

}

?>