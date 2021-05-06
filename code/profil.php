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

  
</style>
<body>
<div class="container">
    <div class="row">

        <div class="col">
            <img src="tecso.png" alt="logo" width="200">
        </div>
        <form>
            <button type="button" class="btn btn-secondary"><a href="main.php">Főoldal</a></button>
            <button type="button" class="btn btn-secondary"><a href="logout.php">Kijelentkezés</a></button>
        </form>
    </div>
</div>





<div class="container" style="padding-top: 1cm;">
        <h1 class="text-center" style="color: rgb(99, 37, 153); font-family: 'Times New Roman', Times, serif;">Profil</h1>
        <hr style="margin-top: 0;margin-bottom:2em;width: 50px; text-align: center;height:2px;color:rgb(255, 0, 98);background-color:rgb(255, 0, 98)">
        <div class="card" style="width:300px" style="align-items: center;">
            <img class="card-img-top" src="profil.jpg" alt="Card image">
            <div class="card-body">
              <h4 class="card-title">Legjobb Felhasználó</h4>
              <p id="nev" class="card-text"><?php session_start(); echo "Bejelentkezve: " . $_SESSION["Felhnev"]?></p>
            </div>
<form method="post" action="profilupdate.php">
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

                echo '<label for="mail">Email: </label>';
                echo "<input type='text' id='mail'  value='$email'><br>";
                echo '<label for="fistname">Jelszo: </label>';
                echo "<input type='text' id='Jelszo' value='$pwd' ><br>";
                echo '<label for="lastname">Név: </label>';
                echo "<input type='text' id='name' value='$name'  ><br>";
                echo  '<label for="bdate">Felhasznalo Név: </label>';
                echo "<input type='text' id='uname' value='$uname' ><br>";

                echo ' <label for="country">Születési dátum:  </label>';
                echo "<input type='text' id='szdate' value='$szdate' ><br>";

                echo '<label for="postcode">Lakcím: </label>';
                echo  "<input type='text' id='cim' name='postcode' value='$cim' required><br>";
    }
  }  
   ?>
   <input type='submit' name="changeuser" value="Adatok módosítása">
   </form>
          </div>

</div>
      

</body>
</html>
