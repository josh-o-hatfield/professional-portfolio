

/* Team 26: Thomas Burden, Josh Hatfield, Nick Maestri, Gavin Munson */
/* This script reflects Project Step 5b, where we decided upon 5 SELECT queries for our HTML/PHP pages. */
/* *NOTE: We added input suggestions on the HTML/PHP main page itself. */

/* 
Query 1:

NAME OF QUERY: Number of Incidents and List of Damages for Customers with More Than 2 Incident Reports

SHOW customer names, types of damages collectively for each customer, and counts of total incident reports filed for customers with more than 2 incident reports

FOR [customer]

QUERY WILL USE: JOIN yes SUBQUERY no AGGREGATION yes
*/

SELECT 
	CONCAT(c.fname,' ', c.lname) AS customer_name, 
	GROUP_CONCAT(
	i.type_of_damage
	ORDER BY i.type_of_damage
	SEPARATOR '; ') AS incident_damage_from_reports, 
	COUNT(i.custid) AS num_reports
FROM customer AS c
JOIN incident_report AS i ON i.custid=c.id
WHERE c.id=i.custid 
GROUP BY i.custid
/* This COUNT is currently hard coded in. We want to be able to give users the option to change this on the PHP form */
HAVING COUNT(i.custid) >= 2
ORDER BY c.lname;

/* —----------------------------------------------------------------------- */

/*
Query 2:

NAME OF QUERY: Equipment Rented by the Day after 2020 and Their Ordered Rates 

SHOW customer names, equipment names, and day rates of equipment that was rented daily on or after 1/1/2021

FOR [equipment]

QUERY WILL USE: JOIN yes SUBQUERY yes AGGREGATION yes
*/

SELECT CONCAT(c.fname, ' ',  c.lname) AS customer_name,  e.name AS equipment_name, e.rate AS day_rate
FROM equipment AS e
JOIN receivables AS r ON r.equipid=e.id
JOIN customer AS c ON c.id=r.custid
/* The duration type is currently hard coded in. We want to be able to give users the option to change this on the PHP form */
WHERE (duration_type = "Day") AND rent_date NOT IN(
	SELECT e.rent_date
	FROM equipment AS e
	/* The rent date condition is currently hard coded in. We want to be able to give users the option to change this on the PHP form */
	WHERE e.rent_date < '2021-01-01' )
ORDER BY day_rate;

/* —----------------------------------------------------------------------- */

/*
Query 3:

NAME OF QUERY Equipment Damaged the Most Given Incident Reports

SHOW equipment types and number of reports filed for equipment in descending order

FOR [equipment]

QUERY WILL USE: JOIN yes SUBQUERY no AGGREGATION yes
*/

SELECT e.type AS equipment_type, COUNT(e.type) AS num_reports_filed
FROM equipment AS e
JOIN incident_report AS i ON i.equipid=e.id
GROUP BY e.type
ORDER BY num_reports_filed DESC;

/* —----------------------------------------------------------------------- */

/*
Query 4:

NAME OF QUERY: Sum of Total Fees Based on Fee Types Received During 2020

SHOW fee types and total values owed where the fees were received during the year 2020

FOR [receivables]

QUERY WILL USE: JOIN yes SUBQUERY no AGGREGATION yes
*/

SELECT e.type, r.fee_type, SUM(r.value_owed) AS total_value_owed
FROM receivables AS r
JOIN equipment AS e
/* The receive date for receivables is currently hard coded in. We want to be able to give users the option to change this on the PHP form */
WHERE r.date_received BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY e.type, r.fee_type
ORDER BY e.type;

/* —----------------------------------------------------------------------- */

/*
Query 5:

NAME OF QUERY: Law Firm Contacts for Customers Regarding Incident Reports

SHOW customer names, incident IDs linked with customers, law firm names, and law firm phones for incidents that DO require legal action

FOR [customer]

QUERY WILL USE: JOIN yes SUBQUERY no AGGREGATION no
*/

SELECT CONCAT(c.fname, ' ', c.lname) AS customer_name, i.id AS incident_id, l.law_firm_name, l.firm_phone
FROM customer as c
JOIN legal_action AS l ON l.custid=c.id
JOIN incident_report AS i ON i.id=l.incidentid
/* The requirement condition for legal action is currently hard coded in. We want to be able to give users the option to change this on the PHP form */
WHERE l.required = 'Y'
ORDER BY c.lname;


