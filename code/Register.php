<?php
   include "dbconn.php";
   $result=null;
   $row=null;
   $connection = DBconnection::getInstance();
   
   if(isset($_POST["submit-register"])){
    $statementN = $connection->parseQuery("SELECT FelhNev FROM FELHASZNALO WHERE FelhNev='".$_POST["username"]."'");
    $statementE = $connection->parseQuery("SELECT FelhNev FROM FELHASZNALO WHERE Jelszo='".$_POST["email"]."'");
    $resultN = oci_execute($statementN);
    $countN=0;
    while(oci_fetch_array($statementN)){
        $countN++;
    }
    if($countN>0){
        echo "<script type=\"text/javascript\">
                window.location.replace('register.php?error=username');
              </script>";
    }
    $resultE = oci_execute($statementE);
    $countE=0;
    while(oci_fetch_array($statementE)){
        $countE++;
    }
    if($countE>0){
        echo "<script type=\"text/javascript\">
                window.location.replace('register.php?error=email');
              </script>";
    }
    $res = $connection->insertInto("FELHASZNALO", array("Nev"=>$_POST["name"],"FelhNev"=>$_POST["username"], "Email"=>$_POST["email"], "Jelszo"=>hash("MD5", $_POST["password"]), "Lakcim"=>["lakcim"], "SzulDatum"=>$_POST["date"]));
    oci_commit($connection->conn);

}else{
    if(isset($_GET["error"])){
        if($_GET["error"]=="name"){
            $errorMessage="A felhasználónév már foglalt.";
        }elseif($_GET["error"]=="email") {
            $errorMessage = "Az e-mail cím már foglalt.";
        }
        echo "<div id=error>".$errorMessage."</div>";
    }


    }

?>