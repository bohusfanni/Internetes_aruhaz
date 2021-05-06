<?php
session_start();
include "dbconn.php";
   $conn = DBconnection::getInstance();

        $email= $POST['EMAIL'];
        $pwd= $POST['JELSZO'];
        $name= $POST['NEV'];
        $uname= $POST['FELHNEV'];
        $szdate= $POST['SZULDATUM'];
        $cim= $POST['LAKCIM'];

    $query = "UPDATE FELHASZNALO SET FELHNEV=:uname, EMAIL=:email , SZULDATE=:szdate,LAKCIM=:cim,JELSZO=:pwd WHERE EMAIL=:email";
    $query = oci_parse($connection,$query);
    oci_bind_by_name($query,":felhnev",$uname);
    oci_bind_by_name($query,":jelszo",$pwd);
    oci_bind_by_name($query,":nev",$name);
    oci_bind_by_name($query,":lakcim",$cim);
    oci_bind_by_name($query,":email",$email);

    if(oci_execute($query)){
        header('Location: /php/profil.php?id='.$email);
        return;
    }
    echo "Valami hiba lehet";
    var_dump($_POST);
}else{
    header("Location: /php/login.php");
}