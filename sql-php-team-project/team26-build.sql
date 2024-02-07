

/* Team 26: Thomas Burden, Josh Hatfield, Nick Maestri, Gavin Munson */
/* This script reflects Project Step 4, where we created and populated the tables with 25 records each. */

DROP TABLE IF EXISTS equipment CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS customer_email CASCADE;
DROP TABLE IF EXISTS incident_report CASCADE;
DROP TABLE IF EXISTS deposit CASCADE;
DROP TABLE IF EXISTS customer_phone CASCADE;
DROP TABLE IF EXISTS receivables CASCADE;
DROP TABLE IF EXISTS legal_action CASCADE;
DROP TABLE IF EXISTS employee_phone CASCADE;

CREATE TABLE equipment (
id INT auto_increment,
name VARCHAR(100) NOT NULL,
availability CHAR(1) NOT NULL,
type VARCHAR(30) NOT NULL,
rate DECIMAL(5,2) NOT NULL,
duration_type VARCHAR(10) NOT NULL,
rent_date DATETIME NOT NULL,
return_date DATETIME,
PRIMARY KEY (id)
) ENGINE = innodb;

CREATE TABLE employee (
id INT auto_increment,
fname VARCHAR(30) NOT NULL,
lname VARCHAR(30) NOT NULL,
email VARCHAR(100),
street VARCHAR(150),
city VARCHAR(100),
state CHAR(2),
zipcode VARCHAR(10),
dob DATE NOT NULL,
type VARCHAR(30) NOT NULL,
PRIMARY KEY (id)
) ENGINE = innodb;

CREATE TABLE employee_phone (
empid INT NOT NULL,
phone_num VARCHAR(20),
phone_type VARCHAR(20),
FOREIGN KEY (empid) REFERENCES employee(id)
) ENGINE = innodb;

CREATE TABLE customer (
id INT auto_increment,
fname VARCHAR(50) NOT NULL,
lname VARCHAR(50) NOT NULL,
email VARCHAR(100),
street VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
zipcode VARCHAR(50),
payment_info VARCHAR(50),
PRIMARY KEY (id)
) ENGINE = innodb;

CREATE TABLE customer_phone (
custid INT NOT NULL,
phone_num VARCHAR(20),
phone_type VARCHAR(20),
FOREIGN KEY (custid) REFERENCES customer(id)
) ENGINE = innodb;

CREATE TABLE incident_report  (
id INT auto_increment,
type_of_damage VARCHAR(200),
incident_date DATE,
custid INT NOT NULL,
equipid INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (custid) REFERENCES customer(id),
FOREIGN KEY (equipid) REFERENCES equipment(id)
) ENGINE = innodb;

CREATE TABLE legal_action (
empid INT NOT NULL,
custid INT NOT NULL,
incidentid INT NOT NULL,
required CHAR(1),
law_firm_name VARCHAR(50),
firm_phone VARCHAR(15),
FOREIGN KEY (empid) REFERENCES employee(id),
FOREIGN KEY (custid) REFERENCES customer(id),
FOREIGN KEY (incidentid) REFERENCES incident_report(id)
) ENGINE = innodb;

CREATE TABLE deposit (
amount_charged DECIMAL(4,2) NOT NULL,
deposit_charge_date DATE NOT NULL,
deposit_return_date DATE,
empid INT NOT NULL,
custid INT NOT NULL,
equipid INT NOT NULL,
FOREIGN KEY (empid) REFERENCES employee(id),
FOREIGN KEY (custid) REFERENCES customer(id),
FOREIGN KEY (equipid) REFERENCES equipment(id)
) ENGINE = innodb;

CREATE TABLE receivables (
empid INT NOT NULL,
custid INT NOT NULL,
equipid INT NOT NULL,
fee_type VARCHAR(30),
value_owed DECIMAL(5,2) NOT NULL,
date_received DATE,
FOREIGN KEY (empid) REFERENCES employee(id),
FOREIGN KEY (custid) REFERENCES customer(id),
FOREIGN KEY (equipid) REFERENCES equipment(id)
) ENGINE = innodb;

/* INSERT INTO equipment */
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (1, 'Crawler', 'Y', 'Site Furnishings', 313.19, 'Day', '2021-01-05 20:44:15', '2021-01-08 20:44:15');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (2, 'Excavator', 'Y', 'Roofing (Metal)', 359.86, 'Day', '2021-02-10 19:37:02', '2021-02-17 19:37:02');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (3, 'Backhoe', 'Y', 'Painting & Vinyl Wall Covering', 670.12, 'Day', '2021-09-23 05:48:15', '2021-09-25 05:48:15');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (4, 'Crawler', 'N', 'Soft Flooring and Base', 158.54, 'Day', '2018-07-23 05:48:15', '2018-07-28 05:48:15');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (5, 'Dump Truck', 'Y', 'Roofing (Metal)', 674.71, 'Day', '2021-09-23 05:48:15', '2021-09-28 05:48:15');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (6, 'Dragline', 'N', 'Asphalt Paving', 104.44, 'Hour', '2021-09-23 05:48:15', '2021-09-23 09:12:15');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (7, 'Bulldozer', 'Y', 'Framing (Wood)', 871.24, 'Day', '2021-10-15 05:48:15', '2021-10-16 05:48:15');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (8, 'Scraper', 'N', 'Elevator', 129.98, 'Hour', '2021-02-05 10:20:15', '2021-02-11 16:53:22');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (9, 'Skid-Steer', 'Y', 'Electrical and Fire Alarm', 814.24, 'Day', '2017-12-10 11:20:20', '2017-12-30 11:20:20');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (10, 'Trencher', 'N', 'Hard Tile & Stone', 114.43, 'Hour', '2018-01-12 06:12:23', '2018-01-13 14:15:38');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (11, 'Backhoe', 'N', 'Rebar & Wire Mesh Install', 165.09, 'Hour', '2019-10-26 07:48:15', '2019-10-30 15:52:29');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (12, 'Dump Truck', 'Y', 'Electrical and Fire Alarm', 397.49, 'Day', '2022-03-13 09:41:11', '2022-03-17 09:41:11');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (13, 'Grader', 'N', 'Casework', 917.37, 'Day', '2021-09-23 04:18:20', '2021-09-25 04:18:20');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (14, 'Bulldozer', 'N', 'Electrical', 687.73, 'Day', '2021-10-23 07:48:15', '2021-10-26 07:48:15');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (15, 'Dragline', 'Y', 'Asphalt Paving', 13.13, 'Hour', '2021-08-16 12:16:15', '2021-08-21 17:58:19');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (16, 'Crawler', 'Y', 'Soft Flooring and Base', 304.0, 'Day', '2022-02-01 09:11:29', '2022-02-13 09:11:29');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (17, 'Skid-Steer', 'Y', 'Exterior Signage', 361.08, 'Day', '2020-01-12 19:01:12', '2020-01-12 19:01:12');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (18, 'Crawler', 'Y', 'Doors, Frames & Hardware', 568.21, 'Day', '2021-09-23 05:48:15', '2021-12-30 08:58:32');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (19, 'Grader', 'N', 'Electrical', 632.79, 'Day', '2021-12-28 05:58:32', '2021-12-30 05:58:32');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (20, 'Skid-Steer', 'N', 'Roofing (Metal)', 275.7, 'Hour', '2020-10-30 09:41:20', '2020-11-03 02:20:18');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (21, 'Backhoe', 'N', 'Soft Flooring and Base', 515.45, 'Day', '2020-11-01 11:19:18', '2020-11-20 11:19:18');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (22, 'Scraper', 'N', 'Fire Sprinkler System', 580.28, 'Day', '2021-04-01 08:58:17', '2021-04-02 08:58:17');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (23, 'Compactor', 'Y', 'Painting & Vinyl Wall Covering', 436.22, 'Day', '2019-01-20 01:17:24', '2019-01-25 01:17:24');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (24, 'Skid-Steer', 'Y', 'Drywall & Acoustical (MOB)', 839.71, 'Day', '2018-04-05 17:50:15', '2018-04-11 17:50:15');
INSERT INTO equipment (id, name, availability, type, rate, duration_type, rent_date, return_date) VALUES (25, 'Scraper', 'Y', 'Site Furnishings', 180.47, 'Hour', '2019-06-03 19:20:11', '2019-06-06 20:15:32');

/* INSERT INTO employee */
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (1, 'Clemens', 'Sicely', 'csicely0@newyorker.com', '706 Maryland Alley', 'El Paso', 'TX', '79994', '1993-05-05', 'Computer Systems Analyst I');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (2, 'Merralee', 'Heavy', 'mheavy1@blogtalkradio.com', '91257 Schlimgen Drive', 'Saginaw', 'MI', '48609', '1984-03-25', 'Geologist III');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (3, 'Halsey', 'Rutledge', 'hrutledge2@boston.com', '4272 Texas Road', 'Spartanburg', 'SC', '29319', '1980-03-31', 'Analyst Programmer');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (4, 'Humfrid', 'Lilleyman', 'hlilleyman3@about.me', '88056 Grasskamp Drive', 'Raleigh', 'NC', '27626', '1976-09-10', 'Automation Specialist I');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (5, 'Catlaina', 'Huey', 'chuey4@ibm.com', '0722 Red Cloud Street', 'Whittier', 'CA', '90610', '1991-06-26', 'Civil Engineer');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (6, 'Roselin', 'Wooton', 'rwooton5@telegraph.co.uk', '84968 Starling Way', 'Sacramento', 'CA', '94257', '1976-02-05', 'Help Desk Operator');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (7, 'Myrtice', 'Finnigan', 'mfinnigan6@walmart.com', '9097 Buhler Drive', 'Portland', 'OR', '97211', '1999-11-26', 'Software Consultant');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (8, 'Arabel', 'Andor', 'aandor7@aol.com', '31119 Kensington Crossing', 'Champaign', 'IL', '61825', '1979-03-03', 'Research Assistant I');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (9, 'Francene', 'Wordesworth', 'fwordesworth8@kickstarter.com', '1883 Stone Corner Place', 'Pittsburgh', 'PA', '15240', '1981-10-28', 'Financial Analyst');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (10, 'Carma', 'Bristowe', 'cbristowe9@tinyurl.com', '2 Farwell Center', 'New Orleans', 'LA', '70154', '1974-05-14', 'Speech Pathologist');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (11, 'Beitris', 'Silly', 'bsillya@furl.net', '5 Raven Plaza', 'Sacramento', 'CA', '95813', '1997-07-15', 'Programmer IV');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (12, 'Beale', 'Gaymer', 'bgaymerb@intel.com', '0833 Sloan Street', 'Provo', 'UT', '84605', '1962-09-27', 'Financial Analyst');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (13, 'Beatrice', 'Ropkes', 'bropkesc@eventbrite.com', '237 Bowman Drive', 'Arlington', 'TX', '76004', '1998-08-31', 'Product Engineer');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (14, 'Franzen', 'Bensusan', 'fbensusand@upenn.edu', '96 Canary Lane', 'Atlanta', 'GA', '30375', '1960-04-13', 'Web Designer IV');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (15, 'Barnabas', 'Lacheze', 'blachezee@goo.ne.jp', '44800 Commercial Center', 'San Antonio', 'TX', '78260', '1984-03-17', 'VP Product Management');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (16, 'Blair', 'Ughelli', 'bughellif@ebay.com', '0 Waubesa Crossing', 'Grand Rapids', 'MI', '49505', '1968-04-07', 'VP Product Management');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (17, 'Marcello', 'Batalle', 'mbatalleg@arstechnica.com', '934 Hudson Avenue', 'Columbia', 'SC', '29240', '1963-04-11', 'Environmental Tech');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (18, 'Borg', 'McDonell', 'bmcdonellh@freewebs.com', '76113 Kings Lane', 'Denver', 'CO', '80223', '1971-10-05', 'Marketing Assistant');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (19, 'James', 'Chumley', 'jchumleyi@engadget.com', '44 Northridge Lane', 'Orlando', 'FL', '32813', '1966-10-29', 'Operator');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (20, 'Sonni', 'Hardwin', 'shardwinj@360.cn', '4 Eagle Crest Lane', 'Garden Grove', 'CA', '92844', '1993-04-08', 'Senior Developer');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (21, 'Miran', 'McGrudder', 'mmcgrudderk@ehow.com', '51205 Mallory Alley', 'San Jose', 'CA', '95113', '1984-05-30', 'Quality Engineer');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (22, 'Bayard', 'Whorf', 'bwhorfl@phpbb.com', '3143 Grover Terrace', 'San Diego', 'CA', '92105', '1970-06-27', 'Environmental Specialist');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (23, 'Giffy', 'Kofax', 'gkofaxm@dmoz.org', '6174 Evergreen Circle', 'South Lake Tahoe', 'CA', '96154', '1963-04-28', 'Payment Adjustment Coordinator');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (24, 'Derick', 'Likly', 'dliklyn@cbsnews.com', '9 Lighthouse Bay Trail', 'Salt Lake City', 'UT', '84152', '1984-11-26', 'Operator');
INSERT INTO employee (id, fname, lname, email, street, city, state, zipcode, dob, type) VALUES (25, 'Johnette', 'Goult', 'jgoulto@disqus.com', '92648 American Ash Street', 'Philadelphia', 'PA', '19160', '1970-08-23', 'Junior Executive');

/* INSERT INTO employee_phone */
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (24, '(215) 757-5602', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (11, '(291) 721-1703', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (21, '(183) 444-5185', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (3, '(157) 682-3603', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (10, '(378) 578-0552', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (25, '(511) 634-7740', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (4, '(686) 555-1266', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (12, '(904) 861-4681', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (17, '(970) 343-7809', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (16, '(901) 814-7472', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (10, '(839) 316-8997', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (19, '(354) 730-7742', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (11, '(554) 562-7475', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (12, '(461) 588-8729', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (14, '(688) 555-5304', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (12, '(160) 284-1888', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (10, '(276) 391-0916', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (25, '(579) 332-1772', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (16, '(346) 834-3903', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (11, '(903) 428-0824', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (2, '(183) 495-3227', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (18, '(419) 184-8853', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (11, '(972) 224-1066', 'home');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (15, '(205) 340-5477', 'cell');
INSERT INTO employee_phone (empid, phone_num, phone_type) VALUES (19, '(783) 396-1951', 'cell');

/* INSERT INTO customer */
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (1, 'Bobbye', 'Minette', 'bminette0@whitehouse.gov', '82 Sommers Park', 'Richmond', 'VA', '23285', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (2, 'Alfred', 'Bartlomiejczyk', 'abartlomiejczyk1@buzzfeed.com', '2 Kipling Alley', 'Staten Island', 'NY', '10310', 'solo');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (3, 'Gabi', 'Clery', 'gclery2@shareasale.com', '20867 Dennis Court', 'North Hollywood', 'CA', '91606', 'americanexpress');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (4, 'Erminie', 'Offill', 'eoffill3@printfriendly.com', '46461 Charing Cross Pass', 'San Francisco', 'CA', '94116', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (5, 'Isidor', 'Looby', 'ilooby4@aol.com', '7 Brown Crossing', 'Evansville', 'IN', '47732', 'diners-club-international');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (6, 'Genvieve', 'Ceillier', 'gceillier5@businessinsider.com', '02 Ridgeview Trail', 'Amarillo', 'TX', '79171', 'mastercard');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (7, 'Nester', 'Sewter', 'nsewter6@icq.com', '27 Waubesa Drive', 'Detroit', 'MI', '48258', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (8, 'Marianne', 'Mabon', 'mmabon7@technorati.com', '1772 Arrowood Avenue', 'Washington', 'DC', '20546', 'maestro');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (9, 'Mame', 'Garside', 'mgarside8@blogspot.com', '21216 Spohn Road', 'Houston', 'TX', '77060', 'china-unionpay');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (10, 'Tremayne', 'Polotti', 'tpolotti9@dailymail.co.uk', '7855 Algoma Road', 'Anaheim', 'CA', '92825', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (11, 'Blondie', 'Nan Carrow', 'bnancarrowa@pagesperso-orange.fr', '8017 Fordem Hill', 'Long Beach', 'CA', '90840', 'bankcard');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (12, 'Caralie', 'Ickovicz', 'cickoviczb@cafepress.com', '0287 Pond Point', 'Miami', 'FL', '33142', 'diners-club-carte-blanche');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (13, 'Maurise', 'Somerset', 'msomersetc@unc.edu', '016 Fair Oaks Street', 'Cincinnati', 'OH', '45213', 'mastercard');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (14, 'Torrie', 'Garrard', 'tgarrardd@cdc.gov', '6547 Cascade Hill', 'Charleston', 'WV', '25336', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (15, 'Tanitansy', 'McQuillin', 'tmcquilline@mediafire.com', '09863 Judy Court', 'Newark', 'NJ', '07188', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (16, 'Barby', 'Pelz', 'bpelzf@imdb.com', '75 Forest Center', 'Newark', 'NJ', '07188', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (17, 'Ravid', 'Mathieson', 'rmathiesong@slashdot.org', '7097 Sage Plaza', 'Olympia', 'WA', '98516', 'visa-electron');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (18, 'Rogers', 'Chelsom', 'rchelsomh@pagesperso-orange.fr', '1187 Duke Park', 'Rockford', 'IL', '61110', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (19, 'Iggy', 'Evert', 'ieverti@themeforest.net', '335 Towne Circle', 'Honolulu', 'HI', '96840', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (20, 'Mirabelle', 'Hadden', 'mhaddenj@flickr.com', '4047 Graedel Trail', 'Arlington', 'TX', '76004', 'diners-club-carte-blanche');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (21, 'Derk', 'Le Houx', 'dlehouxk@toplist.cz', '81 Vidon Street', 'Montgomery', 'AL', '36119', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (22, 'Sally', 'Domke', 'sdomkel@fda.gov', '7024 Sunnyside Park', 'Oklahoma City', 'OK', '73119', 'americanexpress');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (23, 'Elizabeth', 'Pietrowicz', 'epietrowiczm@patch.com', '371 Lillian Circle', 'Tampa', 'FL', '33620', 'jcb');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (24, 'Annabelle', 'Najara', 'anajaran@shop-pro.jp', '7035 6th Alley', 'Albany', 'NY', '12262', 'maestro');
INSERT INTO customer (id, fname, lname, email, street, city, state, zipcode, payment_info) VALUES (25, 'Karlie', 'Izzard', 'kizzardo@usnews.com', '4899 Gerald Alley', 'Albany', 'NY', '12205', 'diners-club-international');

/* INSERT INTO customer_phone */
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (24, '(223) 281-2491', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (2, '(726) 399-7170', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (12, '(295) 354-0390', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (3, '(468) 728-7528', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (2, '(227) 604-0775', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (13, '(563) 227-7302', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (18, '(624) 769-8761', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (1, '(850) 250-4858', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (20, '(588) 909-8850', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (9, '(891) 751-1107', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (15, '(819) 600-5508', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (5, '(509) 751-4422', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (19, '(506) 720-3075', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (14, '(199) 147-5753', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (19, '(223) 557-5951', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (15, '(434) 469-8632', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (13, '(532) 927-9962', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (4, '(816) 837-1545', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (21, '(737) 314-7896', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (13, '(486) 883-1602', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (22, '(749) 181-0782', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (15, '(307) 738-9410', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (3, '(934) 595-6839', 'home');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (16, '(449) 385-9126', 'cell');
INSERT INTO customer_phone (custid, phone_num, phone_type) VALUES (23, '(931) 215-2142', 'home');

/* INSERT INTO incident_report */
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (1, 'Aluminum chipped on side, rendering the equipment unusable', '2021-11-09', 1, 4);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (2, 'Plexiglass protruding through swivel', '2022-03-03', 8, 18);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (3, 'Wood broken and splintered along sides of handle', '2022-01-10', 10, 15);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (4, 'Glass shattered on vacuum side', '2021-07-15', 18, 15);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (5, 'Dent found on bottom of machinery', '2021-04-09', 22, 5);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (6, 'Multiple scratches along plastic engraving', '2019-10-26', 16, 20);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (7, 'Vinyl torn and stretched', '2019-10-05', 8, 17);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (8, 'Rotating swivel damaged along concave rotation', '2021-03-24', 20, 17);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (9, 'Glass protrusion and shattered pieces', '2020-12-06', 3, 14);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (10, 'Vinyl scratched', '2019-11-12', 23, 10);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (11, 'Granite is chipped severely in particular place of the underside', '2021-12-16', 23, 13);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (12, 'Stone cracked and unusable', '2021-11-15', 14, 7);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (13, 'Stone cracked along the edge meeting the metal', '2019-12-01', 12, 7);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (14, 'Stone degradation', '2020-04-30', 13, 14);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (15, 'Brass is worn and bent', '2019-09-03', 12, 21);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (16, 'Granite chipping and degradation', '2021-02-07', 22, 10);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (17, 'Brass is scratched heavily along the side, leading to the handle', '2021-12-26', 18, 4);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (18, 'Aluminum broken when meeting microprocessor chip inlay', '2020-11-30', 18, 19);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (19, 'Broken and bent aluminum found on valve', '2020-07-05', 11, 7);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (20, 'Granite completely removed from copper pipe lining', '2019-09-24', 18, 5);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (21, 'Steel is clearly worn and saturated with gray coloring', '2021-06-10', 4, 16);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (22, 'Steel integrity weakened', '2020-09-29', 1, 20);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (23, 'Cracked stone below cutting handle', '2021-07-24', 9, 17);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (24, 'Plexiglass punctured external to valves', '2019-01-25', 8, 3);
INSERT INTO incident_report (id, type_of_damage, incident_date, custid, equipid) VALUES (25, 'Glass shattered on right window', '2021-07-10', 11, 3);

/* INSERT INTO legal_action */
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (18, 13, 22, 'Y', 'Yarvin-Bailey', '(172) 581-5665');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (6, 8, 12, 'N', 'Dickinson Group', '(719) 959-4227');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (8, 22, 10, 'N', 'Bruen Inc', '(669) 594-7729');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (20, 20, 4, 'N', 'Neil Inc', '(171) 876-0934');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (2, 19, 19, 'N', 'Hilll, Tillman and Orn', '(677) 382-1639');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (22, 19, 22, 'N', 'Nadel, Hauck and Reichert', '(545) 897-7152');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (4, 20, 18, 'Y', 'Schimmel Group', '(728) 186-5581');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (5, 15, 8, 'Y', 'Dach and Sons', '(909) 810-3264');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (25, 6, 9, 'N', 'Williamson and Sons', '(345) 906-1907');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (8, 7, 18, 'N', 'Bernhard-Kshlerin', '(804) 119-6655');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (1, 14, 5, 'Y', 'Stokes LLC', '(542) 150-3705');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (2, 5, 7, 'N', 'Brown-Ruecker', '(190) 687-8601');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (4, 6, 6, 'Y', 'Yills, Howell and Turcotte', '(525) 454-9871');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (5, 9, 5, 'Y', 'Crist, Huels and Bednar', '(701) 285-2938');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (18, 10, 25, 'Y', 'Witting-Nisher', '(517) 291-1923');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (19, 5, 5, 'Y', 'Jerde, Block and Yohr', '(716) 732-6267');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (24, 18, 17, 'N', 'Green-Beahan', '(619) 187-9158');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (16, 3, 1, 'Y', 'Hegmann, Rath and Haag', '(407) 147-6214');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (23, 13, 9, 'Y', 'Blick Inc', '(162) 171-9543');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (3, 15, 6, 'Y', 'Kilback LLC', '(738) 632-8747');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (12, 22, 20, 'Y', 'Stroman, Howell and Hermiston', '(571) 934-3102');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (4, 13, 2, 'N', 'Brown, Yueller and Torphy', '(589) 990-4904');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (23, 2, 18, 'Y', 'Schowalter-Yuller', '(141) 293-2670');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (25, 25, 24, 'Y', 'Thiel-Lebsack', '(782) 933-3663');
INSERT INTO legal_action (empid, custid, incidentid, required, law_firm_name, firm_phone) VALUES (15, 21, 21, 'Y', 'Kessler, Hand and Bradtke', '(487) 922-6669');


/* INSERT INTO deposit */
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (65.31, '2021-04-27', '2022-01-31', 20, 9, 8);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (70.05, '2022-01-28', '2022-02-22', 5, 7, 11);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (59.12, '2021-10-21', '2021-11-21', 9, 7, 8);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (36.21, '2020-08-18', '2022-02-18', 23, 23, 9);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (80.46, '2019-07-20', '2021-06-19', 14, 5, 20);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (62.49, '2022-01-29', '2022-03-27', 13, 3, 23);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (19.82, '2019-06-26', '2020-11-12', 8, 16, 17);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (87.57, '2021-12-27', null, 9, 6, 13);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (13.27, '2019-03-05', '2019-03-14', 13, 4, 6);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (22.55, '2020-03-13', '2020-07-24', 12, 15, 22);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (13.78, '2021-11-29', '2021-12-10', 9, 19, 18);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (52.31, '2021-04-18', '2021-04-20', 1, 9, 20);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (97.18, '2021-06-28', '2022-02-06', 25, 24, 14);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (35.61, '2018-11-26', '2020-11-16', 20, 14, 2);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (16.59, '2021-01-18', '2021-05-08', 9, 1, 23);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (25.41, '2021-09-14', '2022-12-26', 6, 9, 24);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (17.63, '2019-05-26', '2021-04-24', 14, 1, 21);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (22.67, '2021-09-11', '2022-01-01', 15, 1, 11);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (33.3, '2019-04-15', '2019-12-29', 5, 14, 8);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (5.79, '2021-12-15', '2021-12-20', 6, 5, 22);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (70.52, '2021-04-11', '2021-07-28', 11, 24, 19);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (34.7, '2019-04-03', '2019-04-08', 18, 8, 7);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (15.77, '2020-07-30', '2021-10-23', 6, 14, 20);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (39.15, '2020-05-06', null, 7, 11, 11);
INSERT INTO deposit (amount_charged, deposit_charge_date, deposit_return_date, empid, custid, equipid) VALUES (57.84, '2020-12-08', '2021-03-25', 17, 22, 9);


/* INSERT INTO receivables */
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (8, 19, 16, 'late', 954.98, '2021-09-25');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (25, 15, 6, 'damage', 860.25, '2021-11-14');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (6, 5, 4, 'late', 765.0, '2020-02-01');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (10, 21, 23, 'late', 526.37, '2022-03-20');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (24, 18, 5, 'late', 656.74, '2021-02-07');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (2, 10, 5, 'damage', 674.34, '2018-12-11');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (3, 25, 12, 'late', 276.31, '2021-12-04');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (5, 12, 21, 'late', 271.02, '2021-07-24');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (21, 1, 20, 'damage', 870.05, '2020-03-15');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (23, 4, 4, 'damage', 709.55, '2019-10-16');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (25, 25, 17, 'late', 599.03, '2021-07-24');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (18, 15, 24, 'late', 433.86, '2019-04-22');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (6, 20, 19, 'late', 920.03, '2020-12-08');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (6, 9, 9, 'damage', 572.07, '2019-02-18');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (12, 2, 15, 'late', 51.35, '2019-01-07');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (14, 4, 21, 'damage', 571.73, '2019-11-07');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (4, 2, 3, 'damage', 431.31, '2021-06-17');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (25, 15, 14, 'late', 201.35, '2019-01-27');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (24, 6, 22, 'damage', 765.3, '2019-05-24');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (19, 14, 14, 'late', 498.5, '2021-07-26');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (18, 18, 11, 'damage', 215.33, '2020-03-29');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (13, 3, 2, 'late', 139.13, '2022-04-01');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (18, 11, 6, 'damage', 924.07, '2020-09-08');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (11, 5, 10, 'damage', 730.73, '2019-01-10');
INSERT INTO receivables (empid, custid, equipid, fee_type, value_owed, date_received) VALUES (25, 7, 22, 'late', 171.9, '2021-11-13');
