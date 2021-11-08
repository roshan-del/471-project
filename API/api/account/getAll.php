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

$result = $account->getUserAccounts();

$num = $result->rowCount();

if ($num > 0) {
    $accs = array();
    $accs['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $acc_item = array(
            'username' => $id,
            'email' => $email
        );

        // Push to 'data
        array_push($accs['data'], $acc_item);
    }

    //Turn to JSON & output
    echo json_encode($accs);
} else {
    echo json_encode(
        array('message' => 'No Accounts Found')
    );
}
