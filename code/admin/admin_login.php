<?php session_start();?>
<?php
 include "dbconn.php";
$con = DBconnection::getInstance();//connection string 
if (!$con->getConnection()) {
$m = oci_error();
echo $m['message'], "\n";
}
//error fuction returns an oracle message. 
$query = "SELECT FelhaNev, Jelszo FROM RGAZDA WHERE FelhaNev = :username AND Jelszo = :pwd"; 
//query is sent to the db to fetch row id.
$stid = oci_parse($con->getConnection(), $query);

if (isset($_POST['Felhanev']) || isset($_POST['Jelszo'])){  
    echo $query;         
$name = $_POST['Felhanev'];
$pass = $_POST['Jelszo'];

oci_bind_by_name($stid, ':username', $name);
oci_bind_by_name($stid, ':pwd', $pass);

oci_execute($stid);

$row = oci_fetch_array($stid, OCI_ASSOC);
}
//oci_fetch_array returns a row from the db.

if ($row = 1) {
    $_SESSION["Felhanev"] = $_POST['Felhanev'];
    var_dump($_SESSION);
    echo $_POST['Felhanev'];
}
    else {
   echo("The person " . $name . " is not found .
   Please check the spelling and try again or check password");
   exit;
   } 
   oci_free_statement($stid);
   oci_close($con->getConnection());
   //header("Location: http://localhost/Internetes_aruhaz/code/main.php");
   //header function locates you to a welcome page saved s wel.php
    ?>