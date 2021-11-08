<?php
class Issue
{
    //Connection
    private $conn;
    private $table = 'issue';

    //Attributes
    public $name;
    public $description;
    public $commoness;
    public $severiry;
    public $difficulty;
    public $related_partid;


    //Init
    public function __construct($db)
    {
        $this->conn = $db;
    }

    //Get all issues
    /* I dont think we need this
    public function getIssues()
    {
        $query = 'CALL get_issues()';

        $stmt = $this->conn->prepare($query);

        $stmt->execute();

        return $stmt;
    }*/
    //get info of an issue
    public function getInfo()
    {
        $query = 'CALL get_issue_info(?)';

        $stmt = $this->conn->prepare($query);

        //Bind inputs
        $stmt->bindParam(1, $this->name);

        $stmt->execute();

        return $stmt;
    }
    public function getGuide() //Make this get the steps
    {
        $query = 'CALL get_guide(?)';

        $stmt = $this->conn->prepare($query);

        //Bind inputs
        $stmt->bindParam(1, $this->name);

        $stmt->execute();

        return $stmt;
    }
    public function getSteps() //Make this get the steps
    {
        $query = 'CALL get_steps(?)';

        $stmt = $this->conn->prepare($query);

        //Bind inputs
        $stmt->bindParam(1, $this->name);

        $stmt->execute();

        return $stmt;
    }
}
