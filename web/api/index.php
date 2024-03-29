<?php
require 'Slim/Slim.php';
\Slim\Slim::registerAutoloader();
$app = new \Slim\Slim(); //using the slim API


$app->post('/getRun', 'getRun');
$app->post('/getAllRuns', 'getAllRuns');
$app->post('/newUser', 'newUser');
$app->post('/newRun', 'newRun');
$app->post('/addSteps', 'addSteps');

$app->run();

//get DB connection, default root access.
function getConnection($user = 'root', $pw = 'root', $host = 'localhost') 
{
    $dbConnection = new mysqli($host, $user, $pw, 'RunSense');
    
    // Check mysqli connection
    if ($dbConnection->connect_error) 
    {
        //echo '{"did it work?" : "nah"}';
        printf("Connect failed: %s\n", mysqli_connect_error());
    }
    return $dbConnection;
}



function newUser(){
	
	
    $app = \Slim\Slim::getInstance();
    $request = $app->request()->getBody();

    $con = getConnection();
    $name = $_POST['name'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    $sql_query = "INSERT INTO User (name, email, password) VALUES ('$name', '$email', '$password');";
    if ($con->query($sql_query) === TRUE) {
        echo "{UserID: $newUserID}";
    } else {
        echo "Error querying database ".$sql_query;
    }
    
    $con->close();

}

function newRun(){
    
    $app = \Slim\Slim::getInstance();
    //$request = $app->request()->getBody();

    $con = getConnection();
    $UserID = intval($_POST['UserID']);

    $sql_query = "INSERT INTO UserRun (UserID) VALUES ($UserID);";
    if ($con->query($sql_query) === TRUE) {
        echo "{RunID: $newRunID}";
    } else {
        echo "Error querying database ".$sql_query;
    }

    $con->close();

}

function addSteps(){

    $app = \Slim\Slim::getInstance();
    $con = getConnection();

    $RunID = $_POST['RunID'];
    $stepList = $_POST['stepList'];

    foreach($stepList as $step){
        $stepNumber = $step['stepNumber'];
        $StepType = $step['StepType'];
        $Pronation = $step['Pronation'];
        $metrics = $step['metrics'];

        $sql_query = "INSERT INTO Run (RunID, StepNumber, StepType, Pronation, Metrics) VALUES ('$RunID', '$stepNumber', '$StepType', '$Pronation', '$metrics');";
            if ($con->query($sql_query) === TRUE) {
                echo "{result: 'success'}";
            } else {
                echo "{result: 'failure'}";
            }   
    }
}

function getRun(){
    $app = \Slim\Slim::getInstance();
    $request= $app->request()->getBody();

    $con=getConnection();
    $userID = $_POST["UserID"];

    $sql = "SELECT * FROM Run WHERE RunID IN (SELECT MAX(RunID) as latest_run FROM UserRun WHERE UserID = $userID GROUP BY RunID);";
    //echo $sql;
    $result = $con->query($sql);
    $rows = array();

    if($result->num_rows > 0){
        while($row = mysqli_fetch_assoc($result)){
            $rows[] = $row;
        }
        echo json_encode($rows);
    }
    else{
        echo "No Step Data";
    }
}

function getAllRuns(){
    $app = \Slim\Slim::getInstance();
    $request= $app->request()->getBody();

    $con=getConnection();

    $userID = $_POST["UserID"];

    $sql = "SELECT UserID, UserRun.RunID, StepNumber, StepType, Pronation, Metrics FROM UserRun JOIN Run ON UserRun.RunID = Run.RunID HAVING UserID = $userID;";
    //echo $sql;

    //$result = $con->query($sql);
    $rows = array();
    if($con->query($sql)->num_rows > 0){
        $result = $con->query($sql);
        while($row = mysqli_fetch_assoc($result)){
            $rows[] = $row;
        }
        echo json_encode($rows);
    }
    else{
        echo "no data";
    }
}

?>