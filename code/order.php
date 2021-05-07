<?php
session_start();
//var_dump($_POST);
//var_dump($_SESSION);

include "dbconn.php";
$connection = DBconnection::getInstance();

if(isset($_POST['name'])){ 

    echo"az if j�";

    $itemname =     $_POST['name'];
    $price =        $_POST['ar'];
    $quantity =     $_POST['amount'];
    $felhasznalo =  $_SESSION['Felhnev'];
 
  
 $query = "INSERT INTO RENDEL(nev, FelhNev, Darab, Ar) VALUES (:itemname, :felhasznalo, :quantity, :price)";

 $res = oci_parse($connection->getConnection(), $query);

    oci_bind_by_name($res, ':itemname', $itemname);
    oci_bind_by_name($res, ':felhasznalo', $felhasznalo);
    oci_bind_by_name($res, ':quantity', $quantity);
    oci_bind_by_name($res, ':price', $price);
 
 if(oci_execute($res)===false){
     var_dump(oci_error($res));
 }else{
     //oci_commit($connection->getConnection());
     echo "Sikeres felvitel";
     header("Location: http://localhost/Internetes_aruhaz/code/main.php");
 }
}

?>
