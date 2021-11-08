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

$result = $part->getEvery();

$num = $result->rowCount();

if ($num > 0) {
    $parts = array();
    $parts['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $part_item = array(
            'part_id' => $id,
            'category' => $category,
            'name' => $name,
            'price' => $price,
            'rating' => $rating,
            'retailer' => $retailer
        );

        // Push to 'data
        array_push($parts['data'], $part_item);
    }

    //Turn to JSON & output
    echo json_encode($parts);
} else {
    //No parts
    echo json_encode(
        array('message' => 'No Parts Found')
    );
}
