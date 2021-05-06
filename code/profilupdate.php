<?php
session_start();
if(isset($_POST['changeuser'])){
    include 'dbconn.php';

    $connection = DBconnection::getInstance();
    if($connection->getConnection()){
        exit(420);
    }

    $email = $_POST['user_email'];
    $postcode = $_POST['postcode'];
    $city = $_POST['city'];
    $address = $_POST['address'];
    $phone = $_POST['phonenum'];

    $query = "UPDATE USERS SET POST_CODE=:pcode , CITY=:city , HOME_ADDRESS=:addr,PHONE_NUM=:pnum WHERE EMAIL=:mail";
    $query = oci_parse($connection,$query);
    oci_bind_by_name($query,":pcode",$postcode);
    oci_bind_by_name($query,":city",$city);
    oci_bind_by_name($query,":addr",$address);
    oci_bind_by_name($query,":pnum",$phone);
    oci_bind_by_name($query,":mail",$email);

    if(oci_execute($query)){
        header('Location: /php/userinfo.php?id='.$email);
        return;
    }
    echo "Valami hiba lehet";
    var_dump($_POST);
}else{
    header("Location: /php/login.php");
}