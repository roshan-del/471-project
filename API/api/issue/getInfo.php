<?php
//Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json'); //Maybe not json

include_once '../../config/database.php';
include_once '../../models/Issue.php';

//Instantiate DB & Connect
$database = new Database();
$db = $database->connect();

$issue = new Issue($db);

$issue->name = isset($_GET['name']) ? $_GET['name'] : die();

$result = $issue->getInfo();
$title = 'NULL';
$row = $result->fetch(PDO::FETCH_ASSOC);
extract($row);



$ish = array(
    'name' => $issue->name,
    'description' => $description,
    'commoness' => $commoness,
    'severity' => $severity,
    'difficulty' => $difficulty,
    'related part' => $part_name,
    'guide' => $title,
    'dtc' => $code
);

echo (json_encode($ish));
