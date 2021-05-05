<?php

$conn = oci_connect('ADMIN', 'webshop', 'localhost/XE','UTF8');
if (!$conn) {
	$e = oci_error();
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}

			/*<table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th class="font-weight-light"></th>
                    </tr>
                </thead>
                <tbody class="table-borderless">
                    <tr>
                        <th></th>
                    </tr>
                    <tr>
                        <th></th>
                    </tr>
                </tbody>
            </table>
*/

print ("Elado tabla");
$fej = oci_parse($conn, 'SELECT FelhaszNev FROM elado');
$test = oci_parse($conn, 'SELECT Jelszo FROM elado');
if(!$fej || !$test) {
	$e = oci_error($conn);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
$r = oci_execute($fej);
$t = oci_execute($test);
if(!$r || !$t){
	$e = oci_error($stid);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
print "<table class='table' border = '1'>\n";
while($row = oci_fetch_array($fej, OCI_ASSOC+OCI_RETURN_NULLS)) {
	print "<thead><tr>\n";
    foreach ($row as $item) {
        print "<td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>";
    }
    print "</tr></thead>\n";
}
print "</table><br>\n";
oci_free_statement($r, $t);








print ("felhasznalo tabla");

$stid2 = oci_parse($conn, 'SELECT szuldatum FROM felhasznalo');
if(!$stid2) {
	$e = oci_error($conn);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
$r = oci_execute($stid2);
if(!$r){
	$e = oci_error($stid2);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
print "<table border='1'>\n";
while($row = oci_fetch_array($stid2, OCI_ASSOC+OCI_RETURN_NULLS)) {
	print "<tr>\n";
    foreach ($row as $item) {
        print "<td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
    }
    print "</tr>\n";
}
print "</table><br> \n";
oci_free_statement($stid2);


print ("Kategoria tabla");
$stid = oci_parse($conn, 'SELECT * FROM kategoria');
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


print ("Termék tabla");
$stid = oci_parse($conn, 'SELECT * FROM termek');
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

print ("Rendszergazda tabla");
$stid = oci_parse($conn, 'SELECT * FROM rgazda');
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


print ("Létrehoz tabla");
$stid = oci_parse($conn, 'SELECT * FROM letrehoz');
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

print ("Megrendelés tabla");
$stid = oci_parse($conn, 'SELECT * FROM megrendeles');
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

print ("Összekészít tabla");
$stid = oci_parse($conn, 'SELECT * FROM osszekeszit');
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

print ("Rendel tabla");
$stid = oci_parse($conn, 'SELECT * FROM rendel');
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

print ("Törzsvásárló tabla");
$stid = oci_parse($conn, 'SELECT * FROM torzsvasarlo');
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

print ("Vélemény tabla");
$stid = oci_parse($conn, 'SELECT * FROM velemeny');
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