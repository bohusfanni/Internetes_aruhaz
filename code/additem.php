<?php
session_start();
   include "dbconn.php";
   $connection = DBconnection::getInstance();
   
   if(isset($_POST['itemid'])){ 
       echo"az if jó";
   $itemid = $_POST['itemid'];
    $price = $_POST['price'];
    $itemname = $_POST['itemname'];
    $what = $_POST['what'];
    $amount = $_POST['amount'];
    $cat = $_POST['cat'];
       
   
     
    $query = "INSERT INTO TERMEK(TermekKod, Ar, nev, Leiras, DarabSzam, Kategoria) VALUES ($itemid, $price, $itemname, $what, $amount, $cat)";
    
    $res = oci_parse($connection->getConnection(), $query);

    oci_bind_by_name($res, ':itemid', $itemid);
    oci_bind_by_name($res, ':price', $price);
     oci_bind_by_name($res, ':itemname', $itemname);
    oci_bind_by_name($res, ':what', $what);
     oci_bind_by_name($res, ':amount', $amount);
    oci_bind_by_name($res, ':cat', $cat);
    
    echo $itemid;
    if(oci_execute($res)===false){
        var_dump(oci_error($res));
    }else{
        //oci_commit($connection->getConnection());
        echo "Sikeres felvitel";
        header("Location: http://localhost/Internetes_aruhaz/code/add.php");
    }
}
?>