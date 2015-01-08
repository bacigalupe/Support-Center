<?php
	include 'inc/header.php'; // Includes Header & Menu
?>
			
			<div id="content">
				<div class="title_wrap"><div class="title">My Tickets</div></div>
				<?php
					include_once 'inc/db.php'; // Includes DB Connection
					$mytickets = "SELECT ticket_id,title,status_name,priority_name,category_name,username
								FROM users inner join tickets on user_id = ticket_user_id
								inner join tickets_status on ticket_id = ts_ticket_id
								inner join status on ts_status_id = status_id
								inner join priority on ticket_priority_id = priority_id
								inner join categories on ticket_category_id = category_id
								where status_name <> 'Closed' 
								and username ='".$_SESSION['username']."'";
					$mytickets_result = mysqli_query($db,$mytickets);
					
					if(mysqli_num_rows($mytickets_result) > 0) {
						echo "<table class='table_tickets'><tr class='table_header'><th>TICKET ID</th><th>TITLE</th><th>STATUS</th><th>PRIORITY</th><th>CATEGORY</th><th>USER</th></tr>";
						while ($row = mysqli_fetch_assoc($mytickets_result)) {
							echo "<tr><td><a href=\"ticket.php?ticket_id=".$row['ticket_id']."\">".$row['ticket_id']."</a></td><td>".$row['title']."</td><td>".$row['status_name']."</td><td>".$row['priority_name']."</td><td>".$row['category_name']."</td><td>".$row['username']."</td></tr>";
						}
						echo "</table>";
					} else {
						echo "<div style='width:300px;margin:0 auto;font-weight:bold;font-style:italic;padding-top:15px;'>Currently there are no tickets assigned to you</div>";
					}
				mysqli_free_result($mytickets_result);
				mysqli_close($db);
				?>
			</div>
			<div class="clear"></div>
        </div>
    </body>
</html>

