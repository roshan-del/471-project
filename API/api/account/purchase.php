<?php
//Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');


include_once '../../config/database.php';
include_once '../../models/Account.php';


//Instantiate DB & Connect
$database = new Database();
$db = $database->connect();

//Instantiate acc object
$account = new Account($db);

//Sanitize inputs
$account->id = isset($_GET['un']) ? $_GET['un'] : die();
$retailer = isset($_GET['retailer']) ? $_GET['retailer'] : die();
$part_id = isset($_GET['part']) ? $_GET['part'] : die();

$result = $account->makePurchase($retailer, $part_id);

if ($result) {
    echo json_encode(array('Result' => 'True'));
} else {
    echo json_encode(array('Result' => 'False'));
}
