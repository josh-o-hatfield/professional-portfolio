<?php
$con = mysqli_connect("db.luddy.indiana.edu","i308s22_jhatfie","my+sql=i308s22_jhatfie", "i308s22_jhatfie");

// Check connection
if (mysqli_connect_errno()) { 
	die("Failed to connect to MySQL: " . mysqli_connect_error()); 
	}
else { 
	echo "Established Database Connection"; 
	}

// Escape variables for security sql injection
$query1 = mysqli_real_escape_string($con, $_POST['form-query1']);
$query2a = mysqli_real_escape_string($con, $_POST['form-query2a']);
$query2b = mysqli_real_escape_string($con, $_POST['form-query2b']);
$query4a = mysqli_real_escape_string($con, $_POST['form-query4a']);
$query4b = mysqli_real_escape_string($con, $_POST['form-query4b']);
$query5 = mysqli_real_escape_string($con, $_POST['form-query5']);

// We did not need to sanitize any data since we did not include any text inputs for our SELECT queries

// Convert query4a, which specifies the year when fees were received, to a string value
$query4a = (string) $query4a;


// ---------------------------------------------------------------------------------------------------------------

// SELECT Query 1
$sql = "SELECT 
		CONCAT(c.fname,' ', c.lname) AS customer_name, 
		GROUP_CONCAT(
			'Incident ID ', i.id, ' - ', i.type_of_damage
			ORDER BY i.id
			SEPARATOR '<br>') AS incident_damage_from_reports, 
			COUNT(i.custid) AS num_reports
		FROM customer AS c
		JOIN incident_report AS i ON i.custid=c.id
		WHERE c.id=i.custid 
		GROUP BY i.custid
		HAVING COUNT(i.custid) >= $query1
		ORDER BY c.lname";
		
$result = mysqli_query($con, $sql);

// Code assistance from http://www.w3schools.com/php/php_mysql_select.asp, as referenced on the Assignment 10 page
echo "<br>";
echo "<h3>Query 1</h3>";

if ($result->num_rows > 0) {
	echo "<table border=1 style='width:100%'><tr><th style='text-align:left'>Customer Name</th><th style='text-align:left'>Incident Damage from Reports</th><th style='text-align:left'>Number of Reports</th></tr>";

// output data of each row
while($row = $result->fetch_assoc()) {
	echo "<tr><td>".$row["customer_name"]."</td><td>".$row["incident_damage_from_reports"]."</td><td> ".$row["num_reports"]."</td></tr>";
}
echo "</table>";
} else {
  echo "0 results";
  echo "<br>";
}

// ---------------------------------------------------------------------------------------------------------------

// SELECT Query 2
$sql = "SELECT CONCAT(c.fname, ' ',  c.lname) AS customer_name, e.name AS equipment_name, e.rate AS rate
		FROM equipment AS e
		JOIN receivables AS r ON r.equipid=e.id
		JOIN customer AS c ON c.id=r.custid
		WHERE (duration_type = '$query2a') AND rent_date NOT IN(
			SELECT e.rent_date
			FROM equipment AS e
			WHERE e.rent_date < '$query2b')
		ORDER BY rate";
		
$result = mysqli_query($con, $sql);

// Code assistance from http://www.w3schools.com/php/php_mysql_select.asp, as referenced on the Assignment 10 page
echo "<br><hr>";
echo "<h3>Query 2</h3>";

if ($result->num_rows > 0) {
	echo "<table border=1 style='width:100%'><tr><th style='text-align:left'>Customer Name</th><th style='text-align:left'>Equipment Name</th><th style='text-align:left'>$query2a Rate</th></tr>";

// output data of each row
while($row = $result->fetch_assoc()) {
	echo "<tr><td>".$row["customer_name"]."</td><td>".$row["equipment_name"]."</td><td> ".$row["rate"]."</td></tr>";
}
echo "</table>";
} else {
  echo "0 results";
  echo "<br>";
}

// ---------------------------------------------------------------------------------------------------------------

// SELECT Query 3
$sql = "SELECT e.type AS equipment_type, COUNT(e.type) AS num_reports_filed
		FROM equipment AS e
		JOIN incident_report AS i ON i.equipid=e.id
		GROUP BY e.type
		ORDER BY num_reports_filed DESC";
		
$result = mysqli_query($con, $sql);

// Code assistance from http://www.w3schools.com/php/php_mysql_select.asp, as referenced on the Assignment 10 page
echo "<br><hr>";
echo "<h3>Query 3</h3>";

if ($result->num_rows > 0) {
	echo "<table border=1 style='width:100%'><tr><th style='text-align:left'>Equipment Type</th><th style='text-align:left'>Number of Reports</th></tr>";

// output data of each row
while($row = $result->fetch_assoc()) {
	echo "<tr><td>".$row["equipment_type"]."</td><td>".$row["num_reports_filed"]."</td></tr>";
}
echo "</table>";
} else {
  echo "0 results";
  echo "<br>";
}

// ---------------------------------------------------------------------------------------------------------------

// SELECT Query 4
$sql = "SELECT e.type AS equip_type, r.fee_type AS fee_type, SUM(r.value_owed) AS total_value_owed
		FROM receivables AS r
		JOIN equipment AS e
		WHERE (e.type = '$query4b') AND (r.date_received BETWEEN '$query4a-01-01' AND '$query4a-12-31')
		GROUP BY e.type, r.fee_type
		ORDER BY e.type";
		
$sql2 = "SELECT e.type AS equip_type, r.fee_type AS fee_type, SUM(r.value_owed) AS total_value_owed
		FROM receivables AS r
		JOIN equipment AS e
		WHERE r.date_received BETWEEN '$query4a-01-01' AND '$query4a-12-31'
		GROUP BY e.type, r.fee_type
		ORDER BY e.type";

if ($query4b != '') {		
	$result = mysqli_query($con, $sql);
} else {
	$result = mysqli_query($con, $sql2);
}

// Code assistance from http://www.w3schools.com/php/php_mysql_select.asp, as referenced on the Assignment 10 page
echo "<br><hr>";
echo "<h3>Query 4</h3>";

if ($result->num_rows > 0) {
	echo "<table border=1 style='width:100%'><tr><th style='text-align:left'>Equipment Type</th><th style='text-align:left'>Fee Type</th><th style='text-align:left'>Total Value Owed</th></tr>";

// output data of each row
while($row = $result->fetch_assoc()) {
	echo "<tr><td>".$row["equip_type"]."</td><td>".$row["fee_type"]."</td><td> ".$row["total_value_owed"]."</td></tr>";
}
echo "</table>";
} else {
  echo "0 results";
  echo "<br>";
}

// ---------------------------------------------------------------------------------------------------------------

// SELECT Query 5
$sql = "SELECT CONCAT(c.fname, ' ', c.lname) AS customer_name, i.id AS incident_id, l.law_firm_name, l.firm_phone
		FROM customer as c
		JOIN legal_action AS l ON l.custid=c.id
		JOIN incident_report AS i ON i.id=l.incidentid
		WHERE l.required = '$query5'
		ORDER BY c.lname";
		
$result = mysqli_query($con, $sql);

// Code assistance from http://www.w3schools.com/php/php_mysql_select.asp, as referenced on the Assignment 10 page
echo "<br><hr>";
echo "<h3>Query 5</h3>";

if ($result->num_rows > 0) {
	echo "<table border=1 style='width:100%'><tr><th style='text-align:left'>Customer Name</th><th style='text-align:left'>Incident ID</th><th style='text-align:left'>Law Firm Name</th><th style='text-align:left'>Law Firm Phone</th></tr>";

// output data of each row
while($row = $result->fetch_assoc()) {
	echo "<tr><td>".$row["customer_name"]."</td><td>".$row["incident_id"]."</td><td>".$row["law_firm_name"]."</td><td>".$row["firm_phone"]."</td></tr>";
}
echo "</table>";
} else {
  echo "0 results";
  echo "<br>";
}

echo "<br>";
mysqli_close($con);
?>