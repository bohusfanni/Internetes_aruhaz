<?php
session_start();
//var_dump($_SESSION);
include "dbconn.php";
   $conn = DBconnection::getInstance();
   //var_dump($_POST);
   echo "<h1>Statisztikák</h1>";
    $query="SELECT nev FROM felhasznalo INNER JOIN MEGRENDELES ON felhasznalo.felhnev=megrendeles.felhnev WHERE MEGRENDELES.Osszeg=(SELECT max(osszeg) FROM megrendeles)";
	$query2="select kategoria.kategoria, nev from termek inner join kategoria on termek.kategoria=kategoria.kategoria where termek.ar=(select max(ar) from termek);";
	$query3="select elado.felhasznev from elado inner join osszekeszit on elado.felhasznev=osszekeszit.felhasznev inner join megrendeles on megrendeles.azon=osszekeszit.azon where megrendeles.osszeg=(select max(osszeg) from megrendeles);";
	$query4="select termek.nev from termek inner join rendel on rendel.nev=termek.nev where darab=(select max(darab) from rendel);";
	$query5="select max(sum(termek.darabszam)) from termek inner join kategoria on kategoria.kategoria=termek.kategoria group by termek.kategoria;";
	$query6="select termek.kategoria, count(termek.nev) from kategoria inner join termek on kategoria.kategoria=termek.kategoria group by termek.kategoria";
	$query7="select max(count(velemeny.nev)) from termek inner join velemeny on velemeny.nev=termek.nev group by velemeny.nev";
	$query8="SELECT nev FROM felhasznalo INNER JOIN MEGRENDELES ON felhasznalo.felhnev=megrendeles.felhnev WHERE MEGRENDELES.Osszeg=(SELECT max(osszeg) FROM megrendeles  inner join torzsvasarlo on torzsvasarlo.felhnev=megrendeles.felhnev where torzsvasarlo.torzsve='0')";
$stid = oci_parse($conn->getConnection(),$query);

//oci_bind_by_name($stid, ':felhnev', $_SESSION['Felhnev']);
if(!$stid) {
	$e = oci_error($conn);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
$r = oci_execute($stid);
if(!$r){
	$e = oci_error($stid);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
print "Legnagyobb összegben rendelt: ";
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
	/*
	$res2 = oci_parse($connection->getConnection(), $query2);
	echo[$res2];
	$res3 = oci_parse($connection->getConnection(), $query3);
	echo[$res3];
	$res4 = oci_parse($connection->getConnection(), $query4);
	echo[$res4];
	$res5 = oci_parse($connection->getConnection(), $query5);
	echo[$res5];
	$res6 = oci_parse($connection->getConnection(), $query6);
	echo[$res6];
	$res7 = oci_parse($connection->getConnection(), $query7);
	echo[$res7];
	$res8 = oci_parse($connection->getConnection(), $query8);
	echo[$res8];
	

*/





?>