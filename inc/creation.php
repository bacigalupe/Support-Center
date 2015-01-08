<?php

// DB Connection
include 'inc/db.php'; 

// Define variables
if (isset($_POST['title'])) {
$title = $_POST['title'];
} else {
$title = "";
}

if (isset($_POST['description'])) {
$description = $_POST['description'];
} else {
$description = "";
}

if (isset($_POST['ticket_num'])) {
$ticket_num = $_POST['ticket_num'];
} else {
$ticket_num = "";
}

if (isset($_POST['priority'])) {
$priority = $_POST['priority'];
} else {
$priority = "";
}

if (isset($_POST['client'])) {
$client = $_POST['client'];
} else {
$client = "";
}

if (isset($_POST['category'])) {
$category = $_POST['category'];
} else {
$title = "";
}

if (isset($_POST['user'])) {
$user = $_POST['user'];
} else {
$title = "";
}

/*
$title=$_POST['title'];
$description=$_POST['description']; 
$ticket_num=$_POST['ticket_num'];
$priority=$_POST['priority'];
$client=$_POST['client'];
$category=$_POST['category'];
*/

//$user = mysqli_query($db,"select user_id from users where username='$_SESSION['username']'");

// Insert record 
$sql_insert = "INSERT INTO tickets (title, description,ticket_client_id,ticket_user_id,ticket_category_id,ticket_priority_id,ticket_num)
VALUES ('$title','$description','$client','$user','$category','$priority','$ticket_num')";

if (mysqli_query($db, $sql_insert)) {
    echo "New record created successfully";
} else {
    echo "MySQL Error:".mysqli_error($db);
}

mysqli_close($db); // Closing DB Connection
?>