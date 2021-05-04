<?php 
session_start();

if (isset($_SESSION['Felhanev'])) {
   session_destroy();
   session_unset();
   echo "<br> you are logged out successufuly!";
   header("Location: http://localhost/Internetes_aruhaz/code/main.php");
} 