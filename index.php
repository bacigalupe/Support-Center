<!DOCTYPE html>
<html lang="en">
    <head>
		<meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <title>Support Center - Login</title>
        <link rel="shortcut icon" href="favicon.ico"> 
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
		<!--[if lte IE 7]><style>.main{display:none;} .support-note .note-ie{display:block;}</style><![endif]-->
    </head>
    <body>
    	<?php
			include 'inc/login.php'; // Includes Login Script
		?>	
		<div id="header"></div>
        <div id="container">
        
				<form class="login_form" method="post" autocomplete="off">
					<p class="field">
						<input type="text" name="username" placeholder="Username">
						<i class="fa fa-user"></i>
					</p>
					<p class="field">
						<input type="password" name="password" placeholder="Password">
						<i class="fa fa-lock"></i>
					</p>
					<p class="submit">
						<button type="submit" name="submit"><i class="fa fa-arrow-right fa-2x"></i></button>
					</p>
				</form>
		
		<div class="error_message" style="width:250px;margin:0 auto;color:red;font-weight:bold;font-style:italic;"><?php echo $error; ?></div>
        </div>
    </body>
</html>