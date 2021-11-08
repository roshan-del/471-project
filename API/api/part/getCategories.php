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

$result = $part->getCategories();

$num = $result->rowCount();

if ($num > 0) {
    $categories = array();
    $categories['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $category = array(
            'title' => $title,
            'parent title' => $parent_title
        );

        // Push to 'data
        array_push($categories['data'], $category);
    }

    //Turn to JSON & output
    echo json_encode($categories);
} else {
    //No categories
    echo json_encode(
        array('message' => 'No categories found')
    );
}
