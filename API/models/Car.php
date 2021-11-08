<?php
class Car
{
    //DB stuff
    private $conn;
    private $table = 'car';

    //Car Attributes
    public $id;
    public $make;
    public $model;
    public $year;
    public $drivetrain;
    public $transmission;
    public $engine;
    public $chassis;

    //Constructor
    public function __construct($db)
    {
        $this->conn = $db;
    }

    //Get Cars
    public function read()
    {
        $query = 'CALL read_all_cars()';

        //Prepare statment
        $stmt = $this->conn->prepare($query);

        //Execute query
        $stmt->execute();

        return $stmt;
    }

    //Get Makes
    public function getMakes()
    {
        $query = 'CALL get_makes()';
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    //Get Models of a Make
    public function getModels()
    {
        $query = 'CALL get_models(?)';

        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(1, $this->make);

        $stmt->execute();

        return $stmt;
    }

    //Get years of make and model
    public function getYears()
    {
        $query = 'CALL get_years(?,?)';

        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(1, $this->make);
        $stmt->bindParam(2, $this->model);

        $stmt->execute();

        return $stmt;
    }

    //Get Single car
    //Might not need at all, doesnt do anythin rn.
    public function read_single()
    {
        $query = 'CALL read_single_car(?,?,?)';

        //Prepare statment
        $stmt = $this->conn->prepare($query);

        //Bind inputs
        $stmt->bindParam(1, $this->make);
        $stmt->bindParam(2, $this->model);
        $stmt->bindParam(3, $this->year);

        //Execute query
        $stmt->execute();

        return $stmt;
    }


    //Insert car
    public function insertCar()
    {
        $query = 'CALL insert_car(?,?,?,?,?,?,?)';

        //Prepare statment
        $stmt = $this->conn->prepare($query);

        //Bind inputs
        $stmt->bindParam(1, $this->make);
        $stmt->bindParam(2, $this->model);
        $stmt->bindParam(3, $this->year);
        $stmt->bindParam(4, $this->transmission);
        $stmt->bindParam(5, $this->drivetrain);
        $stmt->bindParam(6, $this->engine);
        $stmt->bindParam(7, $this->chassis);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    //Delete car
    public function deleteCar()
    {
        $query = 'CALL delete_car(?,?,?)';

        //Prepare statment
        $stmt = $this->conn->prepare($query);

        //Bind inputs
        $stmt->bindParam(1, $this->make);
        $stmt->bindParam(2, $this->model);
        $stmt->bindParam(3, $this->year);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    //Get the issues of this car
    public function getIssues()
    {
        $query = 'CALL get_car_issues(?,?,?)';
        $stmt = $this->conn->prepare($query);

        //Bind inputs
        $stmt->bindParam(1, $this->make);
        $stmt->bindParam(2, $this->model);
        $stmt->bindParam(3, $this->year);

        $stmt->execute();

        return $stmt;
    }
}
