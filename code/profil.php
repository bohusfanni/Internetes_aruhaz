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
              <p id="nev" class="card-text"><?php session_start(); echo $_SESSION["Felhnev"]?></p>
              <a href="#" class="btn btn-primary"onclick="myFunction">Edit Profile</a>
              <script>
function myFunction() {
  document.getElementById("demo").innerHTML = "YOU CLICKED ME!";
}
</script>
            </div>
          </div>

</div>

</body>
</html>