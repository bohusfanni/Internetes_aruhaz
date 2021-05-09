<!DOCTYPE html> 
<html>
<head>
    <meta charset="UTF-8">
    <title>Tecso</title>    
    <link rel="icon" href="icon.png" sizes="57x57" >
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="row">
    
            <div class="col">
                <img src="tecso.png" alt="logo" width="200">
            </div>
            <div class="btn btn-group">
                <button type="submit" class="btn btn-light"><a href="main.php">Vissza a Főoldalra</a></button>
                <button type="button" class="btn btn-info"><a href="logout.php">Kijelentkezés</a></button>
            </div>
        </div>
    
    </div>
    <div class="container" style="padding-top: 1cm;">
        <h1 class="text-center" style="color: rgb(99, 37, 153); font-family: 'Times New Roman', Times, serif;">Rendelés összekészítés</h1>
        <hr style="margin-top: 0;margin-bottom:2em;width: 50px; text-align: center;height:2px;color:rgb(255, 0, 98);background-color:rgb(255, 0, 98)">
    </div>
    <div class="container" style="padding-top: 0,5cm;">
    <?php
     include "dbconn.php";
     $conn = DBconnection::getInstance();

    $stid2 = oci_parse($conn->getConnection(), "SELECT Azon, nev, Osszeg, Idopont FROM megrendeles INNER JOIN felhasznalo ON felhasznalo.felhnev=megrendeles.felhnev WHERE Ready=0 ORDER BY Idopont");

    if(!$stid2) {
	    $e = oci_error($conn);
	    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }
    $t = oci_execute($stid2);
    if(!$t){
	    $w = oci_error($stid2);
	    trigger_error(htmlentities($w['message'], ENT_QUOTES), E_USER_ERROR);
    }
    print "<table border='1'>\n";

    $value = 0;
    //táblázat felső sora h mi is látható

    print "Összekészítendő rendelések: ";
    print "<tr><th>Megrendelés azonosító: </th><th>Megrendelő: </th><th>Fizetendő összeg: </th><th>Megrendelé időpontja: </th></tr>";
    while($row = oci_fetch_array($stid2, OCI_ASSOC+OCI_RETURN_NULLS)) {
        print "<form method='POST' action='set.php'>";
        print "<tr>\n";
        foreach ($row as $item) {
            print "<td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
        }
        
        
        print "<td><input type='submit' class='btn btn-info' name='set' value='Do'></td>";
        print "<input type='hidden' name='azon' value='$row[AZON]'/>";
        print "</form>";  
        print "</tr>\n";
    }
    ?>


        <hr>
    </div>
</body>