<?php
	include 'inc/header.php'; // Includes Header & Menu
?>

			<div id="content">
				<?php
					include_once 'inc/db.php'; // Includes DB Connection
				?>
				<div class="title_wrap"><div class="title">Create New Ticket</div></div>
				<form class="create_form" autocomplete="off" action="create_ticket.php" method="post">
				
					<div class="left">
					
					<div class="label">
					<div><label for="title">Title:</label></div>
					<div class="sp"><label for="description">Description:</label></div>
					<div><label for="ticket_num">Ticket #:</label></div>
					</div>
					<div class="input">
					<div><input type="text" name="title" required /></div>
					<div><textarea class="description" name="description"></textarea></div>
					<div><input type="text" name="ticket_num" /></div>
					</div>
					<div class="clear"></div>
					</div>
					
					<div class="right">
		
					<div class="label">
					<div><label for="user">User:</label></div>
					<div><label for="priority">Priority:</label></div>
					<div><label for="client">Client:</label></div>
					<div><label for="category">Category:</label></div>
					</div>
					<div class="select">
					<div>
					<?php 
						$result_users = mysqli_query($db,"SELECT user_id,username FROM users");
						echo '<select name="user" required><optgroup><option selected>Select User...</option>\n';
							while($row_user = mysqli_fetch_array($result_users)) {
								echo '<option value="'. $row_user['user_id'] . '">' . $row_user['username'] . "</option>\n";
							}
						echo '</optgroup></select>';
					?>
					</div>
					<div>
					<?php 
						$result_priorities = mysqli_query($db,"SELECT priority_id,priority_name FROM priority");
						echo '<select name="priority" required><option selected>Select Priority...</option>\n';
							while($row_priority = mysqli_fetch_array($result_priorities)) {
								echo '<option value="'. $row_priority['priority_id'] . '">' . $row_priority['priority_name'] . "</option>\n";
							}
						echo '</select>';
					?>
					</div>
					<div>
					<?php 
						$result_clients = mysqli_query($db,"SELECT client_id,firstname,lastname FROM clients");
						echo '<select name="client" required><option selected>Select Client...</option>\n';
							while($row_client = mysqli_fetch_array($result_clients)) {
								echo '<option value="'. $row_client['client_id'] . '">' . $row_client['firstname'] .' '. $row_client['lastname'] . "</option>\n";
							}
						echo '</select>';
					?>
					</div>
					<div>
					<?php 
						$result_categories=mysqli_query($db,"SELECT category_id,category_name FROM categories");
						echo '<select name="category" required><option selected>Select Category...</option>\n';
							while($row_category = mysqli_fetch_array($result_categories)) {
								echo '<option value="'. $row_category['category_id'] . '">' . $row_category['category_name'] . "</option>\n";
							}
						echo '</select>';
					?>	
					</div>
					</div>
					<div class="clear"></div>
					</div>
					<div class="clear"></div>					
					<div class="button_wrap"><button class="create" type="submit" name="submit">Create Ticket</button></div>

				</form>
			</div>
			<div class="clear"></div>
        </div>
    </body>
</html>