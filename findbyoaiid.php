<?php

$opt = getopt("d:i:f:");

$formats = array("line", "aleph");

if (isset($opt['d'])) $data_file = $opt['d'];
else die("-d: Input file is not set!\n");
if (isset($opt['i'])) $id_file = $opt['i'];
else die("-i: Input file is not set!\n");
if (isset($opt['f'])) {
    if (isset($opt['f'], $formats)) $format = $opt['f'];
    else {
        echo "-f: bad format. Options: ";
        print join(', ', $formats);
        echo "\n";
        die;
    }
} else $format = "line";


if (file_exists($data_file)) {
    $in = fopen($data_file, "r");
} else {
    echo "Soubor " . $data_file . " neexistuje\n";
    die();
}

$ids = array();
if (file_exists($id_file)) {
    $in2 = fopen($id_file, "r");
    while ($line = fgets($in2)) {
        $ids[trim($line)] = 1;
    }
} else {
    echo "Soubor " . $id_file . " neexistuje\n";
    die();
}

$record = "";
$b = false;
while ($line = fgets($in)) {
    $record .= $line;
    if (($format == "aleph" && preg_match('/^[^ ]* OAI {3}L \$\$a(.*)/', $line, $matcher))
        || ($format == "line" && preg_match('/^OAI {3}\$a(.*)/', $line, $matcher))) {
        if (array_key_exists(trim($matcher[1]), $ids)) $b = true;
    }
    if ($line == "\n") {
        if ($b) echo $record;
        $b = false;
        $record = "";
    }
}

