<?php
session_start();
   include "dbconn.php";
   $connection = DBconnection::getInstance();
   
   if(isset($_POST['uname'])){ 
       echo"az if jó";
    $uname = $_POST['uname'];
    $pwd = $_POST['pwd'];
    $passwordAgain = $_POST['rpwd'];
       
    if($pwd!=$passwordAgain){
        die("nem ugyanaz a ket jelszo");
    }
    $pwd = password_hash($pwd,PASSWORD_BCRYPT);
     
    $query = "INSERT INTO ELADO(FelhaszNev, Jelszo) VALUES (:uname, :pwd)";
    
    $res = oci_parse($connection->getConnection(), $query);

    oci_bind_by_name($res, ':uname', $uname);
    oci_bind_by_name($res, ':pwd', $pwd);
    
    echo $uname. $pwd;
    if(oci_execute($res)===false){
        var_dump(oci_error($res));
    }else{
        //oci_commit($connection->getConnection());
        echo "Sikeres regisztrácio :D";
        header("Location: http://localhost/Internetes_aruhaz/code/eladoreg.html");
    }
}

?>