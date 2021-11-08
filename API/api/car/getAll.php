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

$result = $car->read();

$num = $result->rowCount();

if ($num > 0) {
    $cars = array();
    $cars['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $car_item = array(
            'make' => $make,
            'model' => $model,
            'year' => $year
        );

        // Push to 'data
        array_push($cars['data'], $car_item);
    }

    //Turn to JSON & output
    echo json_encode($cars);
} else {
    //No cars
    echo json_encode(
        array('message' => 'No Cars Found')
    );
}
