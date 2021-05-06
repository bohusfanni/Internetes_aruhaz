<?php
session_start();
include "dbconn.php";
   $conn = DBconnection::getInstance();

        $email= $_POST['mail'];
        $pwd= $_POST['Jelszo'];
        $rname= $_POST['name'];
        //$uname= $_POST['uname'];
        $szdate= $_POST['szdate'];
        $cim= $_POST['cim'];
        var_dump($_POST);

    $query = "UPDATE FELHASZNALO SET NEV=:rname, EMAIL=:email , SZULDATUM=:szdate,LAKCIM=:cim,JELSZO=:pwd WHERE EMAIL=:email";
    $res = oci_parse($conn->getConnection(),$query);
    //oci_bind_by_name($res,":uname",$uname);
    oci_bind_by_name($res,":pwd",$pwd);
    oci_bind_by_name($res,":rname",$rname);
    oci_bind_by_name($res,":cim",$cim);
    oci_bind_by_name($res,":szdate",$szdate);
    oci_bind_by_name($res,":email",$email);

    if(oci_execute($res)===false){
        var_dump(oci_error($res));
    }else{
        //oci_commit($connection->getConnection());
        echo "Sikeres felvitel";
        header("Location: http://localhost/Internetes_aruhaz/code/profil.php");
    }