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

$car->make = isset($_GET['make']) ? $_GET['make'] : die();
$car->model = isset($_GET['model']) ? $_GET['model'] : die();

$result = $car->getYears();

$num = $result->rowCount();

if ($num > 0) {
    $years = array();
    $years['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $year_item = array(
            'year' => $year
        );

        // Push to 'data
        array_push($years['data'], $year_item);
    }

    //Turn to JSON & output
    echo json_encode($years);
} else {
    //No years
    echo json_encode(
        array('message' => 'No Years Found')
    );
}
