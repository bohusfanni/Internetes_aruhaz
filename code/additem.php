<?php

include_once('dbconn.php')


$itemid = $_POST['itemid'];
$price = $_POST['price'];
$itemname = $_POST['itemname'];
$what = $_POST['what'];
$amount = $_POST['amount'];
$cat = $_POST['cat'];

$add = 'INSERT INTO `TERMEK`(`TermekKod`, `Ar`, `nev`, `Leiras`, `DarabSzam`, `Kategoria`)
                           VALUES ('$itemid', '$price', '$itemname', '$what', '$amount', '$cat')';

mysqli_query($add);
?>