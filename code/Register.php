<?php
    $conn = oci_connect('ADMIN', 'webshop', 'localhost/XE','UTF8');
    if (!$conn) {
        $e = oci_error();
        trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
    }

 if (isset($_POST["Registration"])) {
     $Usename = $_POST["FelhNev"];
     $password = $_POST["Jelszo"];
     $Email = $_POST["Email"];
     $Name = $_POST["Nev"];
     $Lakcim=$_POST["Lakcim"];
     $Szul_datum = $_POST["SzulDatum"];
 
 }
    $accounts = loadUser("");
    $name="";
    $email="";
    $pass="";
    $tel="";

    $errors=[];

    if (isset($_POST["signup"])){


        $name=$_POST["name"];
        $email=$_POST["email"];
        $pass=$_POST["password"];
        $tel=$_POST["telephone"];

        // A felhasz�l�n� m�r foglalt

        foreach ($accounts as $account){
            if ($account["email"]===$email){
                $errors[]="Az email c�m m�r foglalt!";
            }

        }
        // A jelsz� legal�bb 5 karakter
        if (strlen($pass)<5){
            $errors[]="A jelsz� t�l r�vid!";

        }
        // Jelsz�nak tartalmaznia kell bet�t �s sz�mot is


        if (count($errors)===0){
            echo "Sikeres regiszt�ci�! <br>";

            $data =[
                    "name"=>$name,
                    "email"=>$email,
                    "password"=>$pass,
                    "telephone number"=>$tel
                    ];

            saveUser("adatok.txt",$data);


        }
        else{

            foreach ($errors as $error){
                echo $error . "<br>";


            }

        }





    }

?>