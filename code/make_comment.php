<?php
session_start();
var_dump($_SESSION);
include "dbconn.php";
   $connection = DBconnection::getInstance();
   var_dump($_POST);
   if(isset($_POST['make_comment'])){ 

    echo"az if j�";

    $item = $_POST['item'];
    $what = $_POST['comment'];
    $felhnev = $_SESSION['Felhnev'];   

    $query = "INSERT INTO VELEMENY(Azon, nev, Ertekeles, FelhNev) VALUES (dbms_random.value(100000,999999), :item, :what, :felhnev)";

    $res = oci_parse($connection->getConnection(), $query);

    oci_bind_by_name($res, ':item', $item);
    oci_bind_by_name($res, ':what', $what);
    oci_bind_by_name($res, ':felhnev', $felhnev);

    //echo $itemid;
    if(oci_execute($res)===false){
        var_dump(oci_error($res));
    }else{
        //oci_commit($connection->getConnection());
        echo "Sikeres felvitel";
        header("Location: http://localhost/Internetes_aruhaz/code/comment.php");
    }
}
?>