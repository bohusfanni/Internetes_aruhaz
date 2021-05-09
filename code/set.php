<?php
session_start();
var_dump($_POST['azon']);
var_dump($_SESSION['Felhasznev']);

include "dbconn.php";
$connection = DBconnection::getInstance();

if(isset($_POST['set'])){ 
    echo"az if j�";
    $id =     $_POST['azon'];
    $felhasznalo =  $_SESSION['Felhasznev'];
    $query = "INSERT INTO osszekeszit(FelhaszNev, Azon) VALUES (:felhasznalo, :id)";
 $res = oci_parse($connection->getConnection(), $query);
    oci_bind_by_name($res, ':id', $id);
    oci_bind_by_name($res, ':felhasznalo', $felhasznalo);   
 if(oci_execute($res)===false){
     var_dump(oci_error($res));
 }else{
     //oci_commit($connection->getConnection());
     echo "Sikeres felvitel";
    header("Location: http://localhost/Internetes_aruhaz/code/osszek.php");
 }
}
?>
