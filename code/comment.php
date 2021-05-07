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
                <a class="nav-link" href="kapcs.html">Kapcsolat</a>
            </li>
    </div>
    <div class="container">
        
                <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown">
                    Termékek 
                </button>
                <div class="dropdown-menu">
                <a class="dropdown-item" >Csoki</a>
                <a class="dropdown-item" >Alma</a>
                <a class="dropdown-item" >Paradicsom</a>
                </div>
        <div class="form-group">
            <textarea class="form-control" rows="5" id="comment"></textarea>
        </div>
    </div>
</body>
</html>