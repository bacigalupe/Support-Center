<?php
	include 'inc/header.php'; // Includes Header & Menu

// Define variables
/*
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
$category = "";
}

if (isset($_POST['user'])) {
$user = $_POST['user'];
} else {
$user = "";
}
*/

$title=$_POST['title'];
$description=$_POST['description']; 
$ticket_num=$_POST['ticket_num'];
$priority=$_POST['priority'];
$client=$_POST['client'];
$category=$_POST['category'];
$user=$_POST['user'];

$message=''; // Variable To Store Message

if (isset($_POST['submit'])) {
if (empty($title) || empty($description) || empty($user) || empty($priority) || empty($category) || empty($client)) {
$message = "Please fill all the fields. The only non required field is 'Ticket #'.";
}
else
{
// DB Connection
include 'inc/db.php'; 

// Insert record 
$sql_insert = "INSERT INTO tickets (title, description,ticket_client_id,ticket_user_id,ticket_category_id,ticket_priority_id,ticket_num)
VALUES ('$title','$description','$client','$user','$category','$priority','$ticket_num')";

if (mysqli_query($db, $sql_insert)) {
    $message = "New ticket created successfully";
} else {
    $message = "The new ticket couldn't be created. MySQL Error:".mysqli_error($db);
}

mysqli_close($db); // Closing DB Connection
}
}
?>

			<div id="content">
				<div style="width:300px;margin:0 auto;font-weight:bold;font-style:italic;padding-top:15px;"><?php echo $message; ?></div>
			</div>
			<div class="clear"></div>
        </div>
    </body>
</html>