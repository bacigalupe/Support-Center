<?php
$error=''; // Variable To Store Error Message
if (isset($_POST['submit'])) {
if (empty($_POST['username']) || empty($_POST['password'])) {
$error = "Username or Password is invalid";
}
else
{
// Define $username and $password
$username=$_POST['username'];
$password=$_POST['password']; 
// DB Connection
include_once 'inc/db.php';
// To protect MySQL injection for Security purpose
$username = stripslashes($username);
$password = stripslashes($password);
$username = mysqli_real_escape_string($db,$username);
$password = mysqli_real_escape_string($db,$password);
// SQL query to fetch information of registerd users and finds user match.
$query = mysqli_query($db,"select * from users where passwd='$password' AND username='$username'"); 
$rows = mysqli_num_rows($query);
if ($rows == 1) {
session_start(); // Starting Session
$_SESSION['username']=$username; // Initializing Session
$_SESSION['login']= true;
header('location: home.php'); // Redirecting to Home Page
} else {
$error = "Username or Password is invalid";
}
mysqli_free_result($query);
mysqli_close($db); // Closing DB Connection
}
}
?>