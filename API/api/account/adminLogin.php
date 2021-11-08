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

$result = $account->getAdmins();

$num = $result->rowCount();

if ($num > 0) {
    $accs = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        // Push to 'data
        array_push($accs, $id);
    }

    if (in_array($account->id, $accs)) {
        $result->closeCursor();

        $result = $account->loginAdmin($pass);

        if ($result) {
            echo json_encode(True);
        } else {
            echo json_encode(False);
        }
    } else {
        echo json_encode(False);
    }
} else {
    echo json_encode(False);
}
