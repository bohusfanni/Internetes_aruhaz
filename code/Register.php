<?php
session_start();
   include "dbconn.php";
   $connection = DBconnection::getInstance();

   if(isset($_REQUEST['uname'])){ 
       echo"itt jó";
    $name = $_POST['uname'];
    $password = $_POST['pwd'];
    $passwordAgain = $_POST['rpwd'];
    $email = $_POST['email'];
    $nev = $_POST['nev'];
    $cim = $_POST['cim'];
    $szdate = $_POST['szuldate'];
    
    if($password!=$passwordAgain){
        die("nem ugyanaz a ket jelszo");
    }
    $password = password_hash($password,PASSWORD_BCRYPT);
     
    $query = "INSERT INTO FELHASZNALO(FelhNev, Jelszo, Nev, Lakcim, Szuldatum, Email) VALUES (:name, :password, :nev, :cim, TO_DATE(:szdate,'YYYY MM DD'),:email)";
    
    $res = oci_parse($connection->getConnection(), $query);

    oci_bind_by_name($res, ':name', $name);
    oci_bind_by_name($res, ':password', $_POST['pwd']);
    oci_bind_by_name($res, ':email', $_POST['email']);
    oci_bind_by_name($res, ':nev', $_POST['nev']);
    oci_bind_by_name($res, ':cim', $_POST['cim']);
    oci_bind_by_name($res, ':szdate', $_POST['szuldate']);

    if(oci_execute($res)===false){
        var_dump(oci_error($res));
    }else{
        //oci_commit($connection->getConnection());
        echo "Sikeres regisztrácio :D";
        header("Location: http://localhost/Internetes_aruhaz/code/main.php");


    }
}
    ?>