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
$account->id = isset($_GET['id']) ? $_GET['id'] : die();

$result = $account->deleteAccount();

if ($result) {
    echo json_encode(array('Result' => 'True'));
} else {
    echo json_encode(array('Result' => 'False'));
}
