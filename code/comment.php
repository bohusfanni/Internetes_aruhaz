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
<style>
    a, a:hover{
        color: black;
        text-decoration: none;
        
    }
    body {background-color: rgb(242, 250, 250);}
    [class*="col-"]{
        width: 100%;
    }
    .table {
        border: 1px solid darkgrey;
        text-align: center;
        box-shadow: 5px 5px 10px lightgrey ;

    }
    button.btn{
        vertical-align: bottom;
    }
    a#nav-link {
        color: black;
    }

    th{
        font-weight: lighter;
    }
    div#linkek {
        padding-top: 1cm;
    }
    input[type=text], input[type=password],input[type=email] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button:hover {
            opacity: 0.8;
        }

        .cancelbtn {
            width: auto;
            padding: 10px 18px;
            background-color: #f44336;
        }
        .container {
            padding: 16px;
        }
        .col-sm-8 {
            align: right;
        }

        span.psw {
            float: right;
            padding-top: 16px;
        }


        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }


        .modal-content {
            background-color: #fefefe;
            margin: 5% auto 15% auto;
            border: 1px solid #888;
            width: 80%;
        }


        .close {
            position: absolute;
            right: 25px;
            top: 0;
            color: #000;
            font-size: 35px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: red;
            border-color: red;
            cursor: pointer;
        }


        .animate {
            -webkit-animation: animatezoom 0.6s;
            animation: animatezoom 0.6s
        }

        @-webkit-keyframes animatezoom {
            from {-webkit-transform: scale(0)}
            to {-webkit-transform: scale(1)}
        }

        @keyframes animatezoom {
            from {transform: scale(0)}
            to {transform: scale(1)}
        }


        @media screen and (max-width: 300px) {
            span.psw {
                display: block;
                float: none;
            }
            .cancelbtn {
                width: 100%;
            }
        }
</style>
<body>
<div class="container">
    
    <div class="row">
  
        <div class="col">
            <img src="tecso.png" alt="logo" width="200">
        </div>
        <form>
            <div class="col">
           <?php 
           session_start();
           if(isset($_SESSION['Felhanev'])){ // Rgazda
               echo "Logged in as: ", $_SESSION['Felhanev'], ", role: ", $_SESSION['Role'];
               echo "<br/><i class='material-icons' ><a href='logout.php'>logout</a></i>";
            } 
            if(isset($_SESSION['Felhasznev'])){ // Elado
                echo "you logged in as: ", $_SESSION['Felhasznev'], ", mint ", $_SESSION['Role'];
                echo "<br/><i class='material-icons' ><a href='logout.php' stlye='align: left'>logout</a></i>";
            } 
          
           if(isset($_SESSION['Felhnev'])){ // Felhasznalo
               echo "you logged in as: ", $_SESSION['Felhnev'], ", mint ", $_SESSION['Role'];
               echo "<br/><i class='material-icons'><a href='logout.php'>logout</a></i>";
            } 
           ?>
            
            <?php
            if(!isset($_SESSION['Felhnev']) && !isset($_SESSION['Felhasznev']) && !isset($_SESSION['Felhanev'])){
                echo "<div class='btn btn-group'>";
                echo "<button type='button' class='btn btn-info' ><a href='admin_login.html'>Admin Login</a></button>";
                echo "<button type='button' class='btn btn-info' ><a href='elado_login.html'>Eladó Login</a></button>";
                echo "<button type='button' class='btn btn-info' ><a href='registration.html'>Belépés</a></button>";
                echo "</div>";
            }
            ?>
            </div>
        </form>
<!--EZ ITT A LOGIN RÉSZ-->

            
    </div>

</div>
<?php
   include "dbconn.php";
   $conn = DBconnection::getInstance();
    $stid2 = oci_parse($conn->getConnection(), 'SELECT * FROM termek');
if(!$stid2) {
	$e = oci_error($conn->getConnection(), $query);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
$r = oci_execute($stid2);
if(!$r){
	$e = oci_error($stid2);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
?>
    <div class="container" id="linkek">
    <h1 class="text-center" style="color: rgb(99, 37, 153); font-family: 'Times New Roman', Times, serif;">Nekünk számít az Ön véleménye!</h1>
        <hr style="margin-top: 0;margin-bottom:2em;width: 50px; text-align: center;height:2px;color:rgb(255, 0, 98);background-color:rgb(255, 0, 98)">
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link" href="main.php">Termékek</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="comment.php">Comment</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="kapcs.php">Kapcsolat</a>
            </li>
            <?php 
                if(isset($_SESSION['Felhnev'])){
                    echo "<li class='nav-item'>";
                    echo "<a class='nav-link' href='profil.php'>Profil</a>";
                    echo "</li>";
                    }
            ?>
    </div>
    <form method="POST" action="make_comment.php" accept-charset="utf-8">
    <div class="container">
    <label for="item">Termék kiválsztás:</label><br>
    <?php
        echo "<select name='item'>";
        while($row = oci_fetch_array($stid2)) 
        {
            echo "'<option name='item' id='item'> $row[NEV] </option>'";
        }
        echo "</select>";
        oci_free_statement($stid2);
        ?>                
        <div class="form-group">
            <textarea class="form-control" rows="5" name="comment" id="comment"></textarea>
        </div>
        <?php
        if(isset($_SESSION['Felhnev'])){
        print "<div class='text-center'>";
        print "<input type='submit' class='btn btn-outline-dark' name='make_comment' value='Mentés'></input>";
        }


$velemeny = oci_parse($conn->getConnection(), "SELECT nev, Ertekeles, FelhNev FROM velemeny ORDER BY nev");

//oci_bind_by_name($stid, ':felhnev', $_SESSION['Felhnev']);
if(!$velemeny) {
	$e = oci_error($conn);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
$r = oci_execute($velemeny);
if(!$r){
	$e = oci_error($velemeny);
	trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}

while($row = oci_fetch_array($velemeny, OCI_ASSOC+OCI_RETURN_NULLS)) {
    print "<table border='1'>\n";
	print "<tr>\n";
    print "<tr><th>Termék Neve: </th><th>A Komment: </th><th>Kommentelő Neve: </th></tr>";
    foreach ($row as $item) {
        print "<td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
    }
    print "</tr>\n";
    print "</table><br>\n";
}

oci_free_statement($velemeny);
        ?>
        </form>
    </div>
    </div>
</body>
</html>