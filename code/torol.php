<?php
session_start();
var_dump($_POST['id']);



include "dbconn.php";
$connection = DBconnection::getInstance();

if(isset($_POST['delete'])){ 

    echo"az if j�";

    $itemid =     $_POST['id'];
   
 $query = "DELETE FROM rendel WHERE Id=:itemid";

 $res = oci_parse($connection->getConnection(), $query);

    oci_bind_by_name($res, ':itemid', $itemid);
    
 
 if(oci_execute($res)===false){
     var_dump(oci_error($res));
 }else{
     //oci_commit($connection->getConnection());
     echo "Sikeres törlés";
     header("Location: http://localhost/Internetes_aruhaz/code/profil.php");
 }
}

?>


?>