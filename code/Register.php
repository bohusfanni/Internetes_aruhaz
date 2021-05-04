<?php
   include "dbconn.php";
   $connection = DBconnection::getInstance();

   
    $name = $_POST['uname'];
    $password = $_POST['pwd'];
    $email = $_POST['email'];
    $nev = $_POST['nev'];
    $cim = $_POST['cim'];
    $szdate = $_POST['szuldate'];

   if(isset($_POST["submit"])){
    $statementN = $connection->parseQuery("SELECT * FROM FELHASZNALO WHERE FelhNev= :username");
  
    $query = "INSERT INTO FELHASZNALO(FelhNev, Jelszo, Nev, Lakcim, Szuldatum, Email) VALUES (:username, :pwd, :email, :nev, :cim, :szdate)";

    $res = oci_parse($connection, $query);

    oci_bind_by_name($res, ':username', $_POST['uname']);
    oci_bind_by_name($res, ':pwd', $_POST['pwd']);
    oci_bind_by_name($res, ':email', $_POST['email']);
    oci_bind_by_name($res, ':nev', $_POST['nev']);
    oci_bind_by_name($res, ':cim', $_POST['cim']);
    oci_bind_by_name($res, ':szdate', $_POST['szuldate']);

    oci_commit($connection->conn);

}else{
    if(isset($_GET["error"])){
        if($_GET["error"]=="name"){
            $errorMessage="A felhasználónév már foglalt.";
        }elseif($_GET["error"]=="email") {
            $errorMessage = "Az e-mail cím már foglalt.";
        }
        echo "<div id=error>".$errorMessage."</div>";
    }
    }
    //header("Location: http://localhost/Internetes_aruhaz/code/main.php");
?>