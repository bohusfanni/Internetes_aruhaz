<?php

$conn = oci_connect('ADMIN', 'webshop', 'localhost/XE','UTF8');
if (!$conn) {
	$e = oci_error();
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}

session_start();
var_dump($_SESSION['Felhnev']);

print ("Létrehoz tabla");
$stid = oci_parse($conn, "SELECT * FROM rendel WHERE FelhNev=:felhnev");

oci_bind_by_name($stid, ':felhnev', $_SESSION['Felhnev']);
if(!$stid) {
	$e = oci_error($conn);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
$r = oci_execute($stid);
if(!$r){
	$e = oci_error($stid);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
print "<table border='1'>\n";
while($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
	print "<tr>\n";
    foreach ($row as $item) {
        print "<td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
    }
    print "</tr>\n";
}
print "</table><br>\n";
oci_free_statement($stid);

oci_close($conn);
?>