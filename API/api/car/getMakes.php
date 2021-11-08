<?php
//Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json'); //Maybe not json

include_once '../../config/database.php';
include_once '../../models/Car.php';

//Instantiate DB & Connect
$database = new Database();
$db = $database->connect();

//Instantiate car object
$car = new Car($db);

$result = $car->getMakes();

$num = $result->rowCount();

if ($num > 0) {
    $makes = array();
    $makes['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $make_item = array(
            'make' => $make
        );

        // Push to 'data
        array_push($makes['data'], $make_item);
    }

    //Turn to JSON & output
    echo json_encode($makes);
} else {
    //No makes
    echo json_encode(
        array('message' => 'No Makes Found')
    );
}
