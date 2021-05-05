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
              <p id="nev" class="card-text"><?php session_start(); echo $_SESSION["Felhnev"]?></p>
              <button onclick="document.getElementById('bejel').style.display='block'" type="button" class="btn btn-secondary" >Edit profil</button>
              <script>

    var modal = document.getElementById('bejel');


    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
            </div>
          </div>

</div>

</body>
</html>