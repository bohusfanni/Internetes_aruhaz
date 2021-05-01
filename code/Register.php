<?php

 ];
 if (isset($_POST["reg"])) {
 $Email = $_POST["Email"]; // beírt adatok lekérése
 $password = $_POST["pwd"];
 $name=$_POST["name"];
 $phonenumber=$_POST["phonenumber"];
 
 else
 
 foreach () {
 if (["Email"] === $Email) // már foglalt felhasználónév
 die("<b>HIBA:</b> A felhasználónév már foglalt!");
 }
 if (strlen($password) < 5) // 5 karakternél rövidebb jelszó
 die("<b>HIBA:</b> A jelszó túl rövid!");

 


 // sikeres regisztráció
 [] = ["username" => $username, "password" => $password];
 echo "Sikeres regisztráció! <br/>";
 }
 
    <form class="c-form two-column-layout right" method="post">


        <h3>Regisztráció</h3>



        <fieldset>
            <label for="reg_email">E-mail cím</label>
            <input type="email" name="email" id="reg_email" value="" required="required"> <br>
            <label for="reg_password">Jelszó</label>
            <input type="password" name="password" id="password" required="required"><br>
            <label for="name">Név</label>
            <input type="text" name="name" id="name" value="" required="required"> <br>
            <label for="number">Telefonszám</label>
            <input type="text" name="telephone" id="number" value="" required="required"> <br>


            <div><p>A személyes adatokat a weboldalon történõ vásárlási élmény fenntartásához, a fiókhoz való hozzáférés kezeléséhez és más célokra használjuk, melyeket a <a href="" class="woocommerce-privacy-policy-link" target="_blank">adatkezelési tájékoztató</a> tartalmaz.</p>
            </div>
            <p class="form-row validate-required">
                <label for="gdpr_accept">
                    <input type="checkbox" name="gdpr_accept" id="gdpr_accept" class="checkbox" required="required">
                    Elolvastam és elfogadom az <a href="">adatkezelési szabályzatot.</a>		<span class="required">*</span>
                </label>
            </p>
            <input type="Submit" name="signup" value="Regisztráció">
        </fieldset>
    </form>




<?php
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

        // A felhaszálóné már foglalt

        foreach ($accounts as $account){
            if ($account["email"]===$email){
                $errors[]="Az email cím már foglalt!";
            }

        }
        // A jelszó legalább 5 karakter
        if (strlen($pass)<5){
            $errors[]="A jelszó túl rövid!";

        }
        // Jelszónak tartalmaznia kell betût és számot is


        if (count($errors)===0){
            echo "Sikeres regisztáció! <br>";

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