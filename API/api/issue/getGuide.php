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

$result = $issue->getGuide();

$row = $result->fetch(PDO::FETCH_ASSOC);

if (!$row) {
    echo json_encode(array('message' => "No Guide Found"));
}


extract($row);

$ish = array(
    'rating' => $avg_rate,
    'title' => $title,
    'article' => $article,
    'video' => $video,
    'prof_id' => $pro_id,
    'admin_id' => $admin_id,
    'issue name' => $issue_name
);

$steps = array();
$steps['guide'] = array();
$steps['steps'] = array();

array_push($steps['guide'], $ish);

$result->closeCursor();

$result = $issue->getSteps();

$num = $result->rowCount();

if ($num > 0) {

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $acc_item = array(
            'number' => $number,
            'title' => $title,
            'description' => $description
        );

        // Push to 'data
        array_push($steps['steps'], $acc_item);
    }

    //Turn to JSON & output
    echo json_encode($steps);
} else {

    $steps['steps'] = array('message' => "No Steps Found");

    echo json_encode($steps);
}
