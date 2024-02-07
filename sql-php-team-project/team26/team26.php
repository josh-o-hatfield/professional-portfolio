<!DOCTYPE html>
<html>
	<body>
		<p>INFO-I 308, Team 26 - Thomas Burden, Josh Hatfield, Nick Maestri, Gavin Munson</p>
		<p>PROJECT | Step 6: Presenting the Information on the Web</p>
		<hr>
		<h2>Five SELECT Queries</h2>
		<p>Sample input suggestions that demonstrate the queries work:</p>
		<ul>
			<li>Query 1: 2</li>
			<li>Query 2a: Day</li>
			<li>Query 2b: 01/01/2021</li>
			<li>Query 4a: 2020</li>
			<li>Query 4b: Asphalt Paving</li>
			<li>Query 5: Y</li>
		</ul>
		
		<form action="selectqueries.php" method="post">
			<h3>Query 1</h3>
			<p>Select customer names, types of damages collectively for each customer, and counts of total incident reports 
			filed for customers with more than ____ incident reports.</p>
			Specify the number of incident reports: <input type="number" name="form-query1" min=1 max=10><br>
			
			<br><hr>
			<h3>Query 2</h3>
			<p>Select customer names, equipment names, and daily OR hourly rates of equipment that was rented on or after ______.</p>
			Specify the type of rent rate for equipment: <select name="form-query2a">
				<option disabled selected value>-- Choose duration type --</option>
				<option value="Day">Day</option>
				<option value="Hour">Hour</option>
			</select><br>
			Specify the rent date for equipment rented on or after this date: <input type="date" name="form-query2b" min="2015-01-01" max="2050-01-01"><br>
			
			<br><hr>
			<h3>Query 3</h3>
			<p>Select equipment types and number of reports filed for equipment in descending order.</p>
			
			<br><hr>
			<h3>Query 4</h3>
			<p>Select fee types and total values owed where the fees were received during the year ____.</p>
			<p>*Note: We added a functionality to view only specific equipment types based on the second drop-down below. 
			This is not required as an input but fulfills a dynamic drop-down example using PHP.</p>
			Specify the year for fees received: <input type="number" name= "form-query4a" min=2015 max=2050><br>
			(Optional) Specify the equipment type to view fees only associated with that type: <select name="form-query4b">
				<option disabled selected value>-- Choose (optional) equipment type --</option>
				<?php>
				$con = mysqli_connect("db.luddy.indiana.edu","i308s22_jhatfie","my+sql=i308s22_jhatfie", "i308s22_jhatfie");

				// Check connection
				if (mysqli_connect_errno()) { 
					die("Failed to connect to MySQL: " . mysqli_connect_error()); 
				}
				else { 
					$result = mysqli_query($con, "SELECT distinct type FROM equipment ORDER BY type");
					while ($row = mysqli_fetch_assoc($result)) {
						unset($id, $type);
						$id = $row['type'];
						$type = $row['type'];
						echo '<option value="'.$id.'">'.$type.'</option>';
					}
				}
				?>
			</select><br>
			
			<br><hr>
			<h3>Query 5</h3>
			<p>Select customer names, incident IDs linked with customers, law firm names, and law firm phones for incidents 
			that do OR do not require legal action.</p>
			Specify whether legal action is required or not: <select name="form-query5">
				<option disabled selected value>-- Choose legal action requirement --</option>
				<option value="Y">Y</option>
				<option value="N">N</option>
			</select><br><br>
			
			<input type="submit" value="Display Queries">
		</form>
		<br>
	</body>
</html>