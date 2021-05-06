<?php
session_start();
   include "dbconn.php";
   $connection = DBconnection::getInstance();

   if(isset($_REQUEST['uname'])){ 
       echo"itt jó";
    $name = $_POST['uname'];
    $password = $_POST['pwd'];
    
    $email = $_POST['email'];
    $nev = $_POST['nev'];
    $cim = $_POST['cim'];
    $szdate = $_POST['szuldate'];
    
    
    $password = password_hash($password,PASSWORD_BCRYPT);
    $sql="UPDATE FELHASZNALO SET ";
$valtozottFelhasznalo=false;
if($uname!=""){
    $sql.="FelhNev='".$uname."', ";
    $valtozottFelhasznalo=true;
}
if($pwd!=""){
    $sql.="Jelszo='".$pwd."', ";
    $valtozottFelhasznalo=true;
}
if($nev!=null){
    $sql.="Nev=".$nev.", ";
    $valtozottFelhasznalo=true;
}
if($lakcim!=""){
    $sql.="Lakcim=".$cim.", ";
    $valtozottFelhasznalo=true;
}
if($szdate!=""){
    $sql.="SzulDate='".$szdate."', ";
    $valtozottFelhasznalo=true;
}
if($email!=""){
    $sql.="Email='".$email."', ";
    $valtozottFelhasznalo=true;
}
$sql=substr($sql, 0, -2);
$sql.=" WHERE FelhNev=".$_SESSION['FelhNev'];
if($valtozottFelhasznalo){
    $statement = $connection->parseQuery($sql);
    oci_execute($statement);
}

    if(oci_execute($res)===false){
        var_dump(oci_error($res));
    }else{
        //oci_commit($connection->getConnection());
        echo "Sikeres adatmodósítás!!! :D";
       // header("Location: http://localhost/Internetes_aruhaz/code/main.php");


    }
}
    ?>