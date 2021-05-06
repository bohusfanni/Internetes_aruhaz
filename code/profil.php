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
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}


.open-button {
  background-color: Blue;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  opacity: 0.8;
  position: fixed;
  bottom: 23px;
  right: 28px;
  width: 280px;
}


.form-popup {
  display: none;
  position: fixed;
  bottom: 0;
  right: 15px;
  border: 3px solid #f1f1f1;
  z-index: 9;
}


.form-container {
  max-width: 300px;
  padding: 10px;
  background-color: white;
}


.form-container input[type=text], .form-container input[type=password] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  border: none;
  background: #f1f1f1;
}


.form-container input[type=text]:focus, .form-container input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}


.form-container .btn {
  background-color: #04AA6D;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  width: 100%;
  margin-bottom:10px;
  opacity: 0.8;
}


.form-container .cancel {
  background-color: Red;
}


.form-container .btn:hover, .open-button:hover {
  opacity: 1;
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
              
              <button class="open-button" onclick="openForm()">Profil szerkesztése</button>

<div class="form-popup" id="myForm">
  <form action="profilupdate.php" class="form-container">
    <h1>Szerkesztés</h1>

    <label for="email"><b>Email</b></label>
    <input type="text" placeholder="Adja meg az új email címét" name="email" >

    <label for="pwd"><b>Jelszó</b></label>
    <input type="password" placeholder="Adja meg az új jelszavát" name="pwd" >
    <label for="name"><b>Név</b></label>
    <input type="text" placeholder="Adja meg az új nevét" name="name" >

    <label for="uname"><b>Felhasználónév</b></label>
    <input type="text" placeholder="Adja meg az új Felhasználónevét" name="uname" >
    <label for="szuldate"><b>Születési év</b></label>
    <input type="date" placeholder="Adja meg az új születési évét" name="szuldate" >

    <label for="cim"><b>Lakcím</b></label>
    <input type="text" placeholder="Adja meg az új lakcímét" name="cim" ><label for="email"><b>Email</b></label>


   

    <button type="submit" class="btn">Frissít</button>
    <button type="button" class="btn cancel" onclick="closeForm()">Mégse</button>
  </form>
</div>
              <script>
               function openForm() {
                 document.getElementById("myForm").style.display = "block";
                    }

                    function closeForm() {
                         document.getElementById("myForm").style.display = "none";
                                          }
              </script>
     
              

            </div>
          </div>

</div>

</body>
</html>
