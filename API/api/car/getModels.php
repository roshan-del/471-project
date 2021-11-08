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

$car->make =  isset($_GET['make']) ? $_GET['make'] : die();

$result = $car->getModels();

$num = $result->rowCount();

if ($num > 0) {
    $models = array();
    $models['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $model_item = array(
            'model' => $model
        );

        // Push to 'data
        array_push($models['data'], $model_item);
    }

    //Turn to JSON & output
    echo json_encode($models);
} else {
    //No models
    echo json_encode(
        array('message' => 'No Models Found')
    );
}
