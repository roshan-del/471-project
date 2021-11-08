<?php
//Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json'); //Maybe not json

include_once '../../config/database.php';
include_once '../../models/Part.php';

//Instantiate DB & Connect
$database = new Database();
$db = $database->connect();

//Instantiate part object
$part = new Part($db);

// Get Make, Model, Year
$part->id = isset($_GET['id']) ? $_GET['id'] : die();
$part->name = isset($_GET['name']) ? $_GET['name'] : die();

$result = $part->getOnePart();

$num = $result->rowCount();
if ($num = 0) {
    echo json_encode(
        array('message' => 'No Part Found')
    );
}

$row = $result->fetch(PDO::FETCH_ASSOC);
extract($row);

//Create array
$part_arr = array(
    'id' => $id,
    'name' => $name,
    'price' => $price,
    'rating' => $rating,
    'category' => $category,
    'retailer' => $retailer
);

//Make JSON
echo (json_encode($part_arr));
