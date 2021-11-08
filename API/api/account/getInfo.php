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

$result = $account->getInfo();

$result1 = $result->fetch(PDO::FETCH_ASSOC);

if (!$result1) {
    echo json_encode(array('message' => "No account found"));
    return;
}

extract($result1);

$account->email = $email;
$account->password = $password;
$account->date_of_creation = $date_of_creation;

$account->address = $shipping_address;


$result->closeCursor();

$result = $account->getPurchases();

$num = $result->rowCount();

if ($num > 0) {
    $purchases = array();
    $purchases['Account'] = array();
    $purchases['data'] = array();

    $account_info = array(
        'username' => $account->id,
        'password' => $account->password,
        'email' => $account->email,
        'shipping address' => $account->address
    );

    array_push($purchases['Account'], $account_info);

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $transaction = array(
            'part_id' => $part_id,
            'retailer' => $retailer_name,
            'date' => $date,
            'transaction num' => $transaction_no
        );

        array_push($purchases['data'], $transaction);
    }

    //Turn to JSON & output
    echo json_encode($purchases);
} else {
    echo json_encode(
        array(
            'username' => $account->id,
            'password' => $account->password,
            'email' => $account->email,
            'shipping address' => $account->address,
            'data' => "No purchases found"
        )
    );
}
