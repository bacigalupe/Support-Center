<?php

// Defining DB Connection parameters
define('DB_SERVER','localhost');
define('DB_NAME','support');
define('DB_USER','root');
define('DB_PASS','');

// Connect to the database
$db = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);

// Handle error
if(!$db) {
  $error = "Unable to connect to database.MySQL Error:".mysqli_error($db);
}

?>

