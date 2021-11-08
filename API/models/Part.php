<?php
class Part
{
    //DB stuff
    private $conn;
    private $table = 'part';

    //Attributes
    public $id;
    public $name;
    public $price;
    public $rating;
    public $cat_title;
    public $retailer;

    //Constructor
    public function __construct($db)
    {
        $this->conn = $db;
    }

    //Get all for a make model year
    public function getParts($make, $model, $year)
    {
        $query = 'CALL read_all_parts(?,?,?)';

        //Prepare statment
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(1, $make);
        $stmt->bindParam(2, $model);
        $stmt->bindParam(3, $year);


        //Execute query
        $stmt->execute();

        return $stmt;
    }
    //Get all
    public function getEvery()
    {
        $query = 'CALL get_every_part()';

        //Prepare statment
        $stmt = $this->conn->prepare($query);

        //Execute query
        $stmt->execute();

        return $stmt;
    }

    //Get one part
    public function getOnePart()
    {
        $query = 'CALL read_one_part(?,?)';

        //Prepare statment
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(1, $this->id);
        $stmt->bindParam(2, $this->name);

        //Execute query
        $stmt->execute();

        return $stmt;
    }
    public function insertPart()
    {
        $query = 'CALL insert_part(?,?,?,?,?,?)';


        //Prepare statment
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(1, $this->id);
        $stmt->bindParam(2, $this->name);
        $stmt->bindParam(3, $this->price);
        $stmt->bindParam(4, $this->cat_title);
        $stmt->bindParam(5, $this->retailer);
        $stmt->bindParam(6, $this->rating);

        //Execute query
        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function deletePart()
    {
        $query = 'CALL delete_part(?,?)';

        //Prepare statment
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(1, $this->id);
        $stmt->bindParam(2, $this->name);


        //Execute query
        $result = $stmt->execute();

        return $result;
    }

    public function getRetailers()
    {
        $query = 'call get_retailers()';
        $stmt = $this->conn->prepare($query);

        //Execute query
        $result = $stmt->execute();

        return $stmt;
    }

    public function getCategories()
    {
        $query = 'call get_categories()';
        $stmt = $this->conn->prepare($query);

        //Execute query
        $result = $stmt->execute();

        return $stmt;
    }
}
