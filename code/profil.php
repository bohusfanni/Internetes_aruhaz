<!DOCTYPE html>
<html lang="en">
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
</head>
<style>
 a, a:hover{
     color: black;
     text-decoration: none;
 }
 .column {
  float: left;
  width: 33.3%;
  padding: 10px;
  height: 300px; /* Should be removed. Only for demonstration */
}
  
</style>
<body>
<div class="container">
    <div class="row">

        <div class="col">
            <img src="tecso.png" alt="logo" width="200">
        </div>
        <form>
            <button type="button" class="btn btn-info"><a href="main.php">Főoldal</a></button>
            <button type="button" class="btn btn-info"><a href="logout.php">Kijelentkezés</a></button>
        </form>
    </div>
</div>





<div class="container" style="padding-top: 1cm;">
        <h1 class="text-center" style="color: rgb(99, 37, 153); font-family: 'Times New Roman', Times, serif;">Profil</h1>
        <hr style="margin-top: 0;margin-bottom:2em;width: 50px; text-align: center;height:2px;color:rgb(255, 0, 98);background-color:rgb(255, 0, 98)">
       
            <div class="column" style="width:300px" style="align-items: center;">
                <img class="card-img-top" src="profil.jpg" alt="Card image">
                <div class="card-body">
                <h4 class="card-title">Legjobb Felhasználó</h4>
                <p id="nev" class="card-text"><?php session_start(); echo "Bejelentkezve: " . $_SESSION["Felhnev"]?></p>
                </div>
            </div>
    <div class="column">
        <form method="POST" action="profilupdate.php">
        <?php 

        include "dbconn.php";
        $conn = DBconnection::getInstance();
        $query="SELECT * FROM FELHASZNALO WHERE FelhNev=:felh";
        $parsed=oci_parse($conn->getConnection(),$query);
        oci_bind_by_name($parsed, ":felh", $_SESSION['Felhnev']);
        if(oci_execute($parsed)){
            while($row=oci_fetch_array($parsed)){
                $email= $row['EMAIL'];
                $pwd= $row['JELSZO'];
                $name= $row['NEV'];
                $uname= $row['FELHNEV'];
                $szdate= $row['SZULDATUM'];
                $cim= $row['LAKCIM'];
                    echo "<div class='container'>";
                    echo '<label for="mail">Email: </label>';
                    echo "<input type='text' name='mail'  value='$email'><br>";
                    echo '<label for="fistname">Jelszo: </label>';
                    echo "<input type='text' name='Jelszo' value='$pwd' ><br>";
                    echo '<label for="lastname">Név: </label>';
                    echo "<input type='text' name='name' value='$name'  ><br>";
                    echo  '<label for="bdate">Felhasznalo Név: </label>';
                    echo "<input type='text' name='uname' value='$uname' disabled><br>";
                    echo ' <label for="country">Születési dátum:  </label>';
                    echo "<input type='text' name='szdate' value='$szdate' ><br>";
                    echo '<label for="postcode">Lakcím: </label>';
                    echo  "<input type='text' id='cim' name='cim' value='$cim'><br>";
                    echo "</div>";
            }
        }  
        ?>
    
    <input type='submit' class="btn btn-info" name="changeuser" value="Adatok módosítása">
    </form>
    </div>
    <div class="column">
    <form method="POST" action="megrendel.php">
    
    <?php
    $stid = oci_parse($conn->getConnection(), "SELECT nev, Darab, Ar FROM rendel WHERE FelhNev=:felhnev and megrendelt=0");

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
    $value = 0;
    while($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
	    print "<tr>\n";
        $value += $row['AR'] * $row['DARAB'];
        foreach ($row as $item) {
            
            print "<td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
        }
        print "<input type='hidden' name='name' value='$_SESSION[Felhnev]'/>";
        print "<input type='hidden' name='vegosszeg' value='$value'/>";
        print "</tr>\n";
    }
   
    print "</table><br>\n";
    print "Fizetendő összeg: " . $value . " Ft";
    oci_free_statement($stid);
    ?>
    <input type='submit' class="btn btn-info" name="finish" value="Megrendel">
    </form>
    </div>
</div>
</body>
</html>
