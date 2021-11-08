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

// Get Make, Model, Year
$car->make = isset($_GET['make']) ? $_GET['make'] : die();
$car->model = isset($_GET['model']) ? $_GET['model'] : die();
$car->year = isset($_GET['year']) ? $_GET['year'] : die();
$car->year = (int)$car->year;

$result = $car->read_single();

$num = $result->rowcount();

if ($num) {
    //Make JSON
    echo (json_encode($result));
} else {
    echo json_encode(
        array('message' => 'No Car Found')
    );
}
