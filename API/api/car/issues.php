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

// Get args
$car->make = isset($_GET['make']) ? $_GET['make'] : die();
$car->model = isset($_GET['model']) ? $_GET['model'] : die();
$car->year = isset($_GET['year']) ? $_GET['year'] : die();
$car->year = (int)$car->year;

$result = $car->getIssues();


$num = $result->rowCount();

if ($num > 0) {
    $issues = array();
    $issues['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $issue_info = array(
            'name' => $issue_name,
            'description' => $description,
        );

        array_push($issues['data'], $issue_info);
    }

    //Turn to JSON & output
    echo json_encode($issues);
} else {
    echo json_encode(
        array(
            'message' => 'No issues found'
        )
    );
}

/*
            'commoness' => $commoness,
            'severity' => $severity,
            'difficulty' => $difficulty,
            'realted part' => $part_name
            */