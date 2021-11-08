<?php
//Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

include_once '../../config/database.php';
include_once '../../models/Part.php';

//Instantiate DB & Connect
$database = new Database();
$db = $database->connect();

//Instantiate part object
$part = new Part($db);

$result = $part->getRetailers();

$num = $result->rowCount();

if ($num > 0) {
    $retailers = array();
    $retailers['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $retailer = array(
            'name' => $name,
            'phone_no' => $phone_no,
            'rating' => $rating,
            'warehouse_location' => $warehouse_location
        );

        // Push to 'data
        array_push($retailers['data'], $retailer);
    }

    //Turn to JSON & output
    echo json_encode($retailers);
} else {
    //No retailers
    echo json_encode(
        array('message' => 'No retailers found')
    );
}
