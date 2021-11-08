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

//Inputs
$account->id = isset($_GET['un']) ? $_GET['un'] : die();
$pass = isset($_GET['pass']) ? $_GET['pass'] : die();

$result = $account->login($pass);

if ($result) {
    echo json_encode(True);
} else {
    echo json_encode(False);
}


