<?php
class Account
{
    //Connection
    private $conn;

    //Table
    private $db_table = "account";

    //Columns
    public $id;
    public $email;
    public $password;
    public $date_of_creation;
    public $address;
    public $cert;
    public $shop_name;

    //Init
    public function __construct($db)
    {
        $this->conn = $db;
    }

    //Get All
    public function getUserAccounts()
    {
        $query = 'CALL get_all_accounts()';
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }
    //Get admin account id's
    public function getAdmins()
    {
        $query = 'CALL get_admins()';
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    //Create Account
    public function createAccount()
    {
        $query = 'CALL create_account(:name, :password, :email, :doc, :address, :cert, :shop)';
        $stmt = $this->conn->prepare($query);

        //Bind Params
        $stmt->bindParam(":name", $this->id);
        $stmt->bindParam(":password", $this->password);
        $stmt->bindParam(":email", $this->email);
        $stmt->bindParam(":doc", $this->date_of_creation);
        $stmt->bindParam(":address", $this->address);
        $stmt->bindParam(":cert", $this->cert);
        $stmt->bindParam(":shop", $this->shop_name);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    //Delete Account
    public function deleteAccount()
    {
        $query = 'CALL delete_account(?)';
        $stmt = $this->conn->prepare($query);

        //Bind params
        $stmt->bindParam(1, $this->id);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    //Get Account puchase history
    public function getPurchases()
    {
        $query = 'CALL get_purchases(?)';
        $stmt = $this->conn->prepare($query);

        //Bind params
        $stmt->bindParam(1, $this->id);

        $stmt->execute();

        return $stmt;
    }

    //Make Record a purchase
    public function makePurchase($retailer, $part_id)
    {
        $query = 'CALL make_purchase(?,?,?,?)';
        $stmt = $this->conn->prepare($query);

        $date = date("d-m-Y");
        $stmt->bindParam(3, $this->id);
        $stmt->bindParam(2, $retailer);
        $stmt->bindParam(1, $part_id);
        $stmt->bindParam(4, $date);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function getInfo()
    {
        $query = 'CALL get_acc_info(?)';
        $stmt = $this->conn->prepare($query);

        //Bind params
        $stmt->bindParam(1, $this->id);

        $stmt->execute();

        return $stmt;
    }
    public function login($pass)
    {
        $query = 'CALL get_acc_info(?)';

        $stmt = $this->conn->prepare($query);

        //Bind params
        $stmt->bindParam(1, $this->id);

        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$row) {
            return false;
        }

        extract($row);

        if ($password == $pass) {
            return true;
        } else {
            return false;
        }
    }

    public function loginAdmin($pass)
    {
        $query = 'CALL get_admin_info(?)';

        $stmt = $this->conn->prepare($query);

        //Bind params
        $stmt->bindParam(1, $this->id);

        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$row) {
            return false;
        }

        extract($row);

        if ($password == $pass) {
            return true;
        } else {
            return false;
        }
    }
}
