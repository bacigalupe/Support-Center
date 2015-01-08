<!DOCTYPE html>
<html lang="en">
    <head>
		<meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<meta http-equiv="refresh" content="5; url=index.php">
		<?php
		$page = $_SERVER['PHP_SELF'];
		//$title = 'Support Center - Home';
		if(isset($page)) {
		switch($page) {
		case "/SC/home.php";
		$title = "Support Center - Home";
		break;
		case "/SC/new_ticket.php";
		$title = "Support Center - New Ticket";
		break;
		case "/SC/my_tickets.php":
		$title = "Support Center - My Tickets";
		break;
		case "/SC/open_tickets.php":
		$title = "Support Center - Open Tickets";
		break;
		case "/SC/search.php":
		$title = "Support Center - Search";
		break;
		case "/SC/settings.php":
		$title = "Support Center - Settings";
		break;
		}
		}else{
		$title = "Support Center";
		}
		?>
		
		<title><?php echo $title; ?></title>
        <link rel="icon" type="image/x-icon" href="favicon.ico" /> 
        <link rel="stylesheet" type="text/css" href="css/reset.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script type="text/javascript" src="js/menu.js"></script>
		<!--[if lte IE 7]><style>.main{display:none;} .support-note .note-ie{display:block;}</style><![endif]-->
    </head>
    <body>
    	<?php 
    	session_start(); // Starting Session
    	// Check if user is logged in, if not, redirect to login page
    	if(!isset($_SESSION['login'])) {
   			header('location: index.php');
   			exit;
		} 
		?>
		<div id="header"></div>
        <div id="container">
			<div id="menu">
			
				<div class="menu-item">
				<a href="home.php">	
				<div class="menu-title">Home</div><div class="menu-icon"><i class="fa fa-home fa-2x pull-right"></i></div><div class="clear"></div>
				</a>
				</div>
				
				<div class="menu-item">
				<a href="new_ticket.php">
				<div class="menu-title">New Ticket</div><div class="menu-icon"><i class="fa fa-edit fa-2x pull-right"></i></div><div class="clear"></div>
				</a>
				</div>
				
				<div class="menu-item">
				<a href="my_tickets.php">
				<div class="menu-title">My Tickets</div><div class="menu-icon"><i class="fa fa-file-text-o fa-2x pull-right"></i></div><div class="clear"></div>
				</a>
				</div>
				
				<div class="menu-item">
				<a href="open_tickets.php">
				<div class="menu-title">Open Tickets</div><div class="menu-icon"><i class="fa fa-files-o fa-2x pull-right"></i></div><div class="clear"></div>
				</a>
				</div>
				
				<div class="menu-item">
				<a href="search.php">
				<div class="menu-title">Search</div><div class="menu-icon"><i class="fa fa-search fa-2x pull-right"></i></div><div class="clear"></div>
				</a>
				</div>
				
				<div class="menu-item">
				<a href="settings.php">
				<div class="menu-title">Settings</div><div class="menu-icon"><i class="fa fa-cog fa-2x pull-right"></i></div><div class="clear"></div>
				</a>
				</div>
				
				<div class="menu-item">
				<a href="logout.php">
				<div class="menu-title">Log Out</div><div class="menu-icon"><i class="fa fa-sign-out fa-2x pull-right"></i></div><div class="clear"></div>
				</a>
				</div>
			</div>

<?php
	session_destroy();
?>
			
			<div id="content">
				<div style="width:300px;margin:0 auto;color:red;font-weight:bold;font-style:italic;padding-top:15px;">You are now logged out!</div>
			</div>
			<div class="clear"></div>
        </div>
    </body>
</html>