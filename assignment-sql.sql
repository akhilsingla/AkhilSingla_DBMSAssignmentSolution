create database TravelOnTheGo;
USE TravelOnTheGo;

CREATE TABLE IF NOT EXISTS ROUTE_DETAILS(
Route_Code int NOT NULL AUTO_INCREMENT PRIMARY KEY,
Category varchar(50),
Boarding_City  varchar(50),
Destination_City varchar(50),
Distance int,
Bus_Type varchar(50)
); 
CREATE TABLE IF NOT EXISTS PASSENGER(
Passenger_name varchar(50),
Gender char(1),
Route_Code int(50),
FOREIGN KEY(Route_Code) REFERENCES ROUTE_DETAILS(Route_Code)
);

CREATE TABLE IF NOT EXISTS PRICE(
Bus_Type varchar(50),
Distance int,
Price int
); 

##INSERT INTO PASSENGER VALUES
##("Sejal", "AC", "F", "Bengaluru", "Chennai", 350, "Sleeper"),
##("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", 700, "Sitting"),
##("Pallavi", "AC", "F", "Panaji", "Bengaluru", 600, "Sleeper"),
##("Khusboo", "AC", "F", "Chennai", "Mumbai", 1500, "Sleeper"),
##("Udit", "Non-AC", "M", "Trivandrum", "panaji", 1000, "Sleeper"),
##("Ankur", "AC", "M", "Nagpur", "Hyderabad", 500, "Sitting"),
##("Hemant", "Non-AC", "M", "panaji", "Mumbai", 700, "Sleeper"),
##("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", 500, "Sitting"),
##("Piyush", "AC", "M", "Pune", "Nagpur", 700, "SittiPASSENGERPASSENGERng");

INSERT INTO ROUTE_DETAILS (Category, Boarding_City, Destination_City, Distance, Bus_Type) VALUES
("AC", "Bengaluru", "Chennai", 350, "Sleeper"),
("Non-AC", "Mumbai", "Hyderabad", 700, "Sitting"),
("AC", "Panaji", "Bengaluru", 600, "Sleeper"),
("AC", "Chennai", "Mumbai", 1500, "Sleeper"),
("Non-AC", "Trivandrum", "panaji", 1000, "Sleeper"),
("AC", "Nagpur", "Hyderabad", 500, "Sitting"),
("Non-AC", "panaji", "Mumbai", 700, "Sleeper"),
("Non-AC", "Hyderabad", "Bengaluru", 500, "Sitting"),
("AC", "Pune", "Nagpur", 700, "Sitting");

INSERT INTO PASSENGER VALUES
("Sejal", "F", 1),
("Anmol", "M", 2),
("Pallavi", "F", 3),
("Khusboo", "F", 4),
("Udit", "M", 5),
("Ankur", "M", 6),
("Hemant", "M", 7),
("Manish", "M", 8),
("Piyush", "M", 9);

INSERT INTO PRICE VALUES
("Sleeper", 350, 770),
("Sleeper", 500, 1100),
("Sleeper", 600, 1320),
("Sleeper", 700, 1540),
("Sleeper", 1000, 2200),
("Sleeper", 1200, 2640),
("Sleeper", 350, 434),
("Sitting", 500, 620),
("Sitting", 500, 620),
("Sitting", 600, 744),
("Sitting", 700, 868),
("Sitting", 1000, 1240),
("Sitting", 1200, 1488),
("Sitting", 1500, 1860);

## query 3
SELECT PASSENGER.Gender, COUNT(ROUTE_DETAILS.Distance) AS Distance_Travelled from Passenger INNER JOIN ROUTE_DETAILS ON 
PASSENGER.Route_Code = ROUTE_DETAILS.Route_Code WHERE ROUTE_DETAILS.Distance >= 600 GROUP BY PASSENGER.Gender;

##query 4
SELECT ROUTE_DETAILS.Boarding_City, ROUTE_DETAILS.Destination_City, PRICE.Bus_Type, PRICE.Distance, PRICE.Price as Minium_Sleeper_Price from ROUTE_DETAILS INNER JOIN PRICE ON
ROUTE_DETAILS.Bus_Type = PRICE.Bus_Type AND ROUTE_DETAILS.Distance = PRICE.Distance WHERE PRICE.Price = (Select MIN(Price) from PRICE);
	
##query 5
SELECT PASSENGER.Passenger_name AS "Passengers Having Names Starts with 'S'" from PASSENGER where PASSENGER.Passenger_name LIKE "S%";

##query 6


##query 7
SELECT PASSENGER.Passenger_name, ROUTE_DETAILS.Boarding_City, ROUTE_DETAILS.Destination_City, PRICE.Bus_Type, PRICE.Distance, PRICE.Price from( 
PASSENGER INNER JOIN ROUTE_DETAILS ON PASSENGER.Route_Code = ROUTE_DETAILS.Route_Code) 
INNER JOIN PRICE ON PRICE.Bus_Type = ROUTE_DETAILS.Bus_Type AND PRICE.Distance = ROUTE_DETAILS.Distance WHERE PRICE.Bus_Type = "Sitting" AND PRICE.Distance=1000;

##query 8
SELECT PASSENGER.Passenger_name, PRICE.Bus_Type, PRICE.Price from (
Passenger INNER JOIN ROUTE_DETAILS ON PASSENGER.Route_Code = ROUTE_DETAILS.Route_Code)
INNER JOIN PRICE ON ROUTE_DETAILS.Distance = PRICE.Distance WHERE PASSENGER.Passenger_name = "Pallavi" 
AND PRICE.Distance=
(SELECT Distance from ROUTE_DETAILS WHERE ROUTE_DETAILS.Boarding_City IN("Bengaluru", "Panaji") AND ROUTE_DETAILS.Destination_City IN("Bengaluru", "Panaji"));

##query 9
SELECT DISTINCT(Distance) from ROUTE_DETAILS ORDER BY DISTANCE DESC;

##query 10
Select PASSENGER.Passenger_name, (ROUTE_DETAILS.Distance/(Select SUM(P.Distance) from (Select ROUTE_DETAILS.Distance from PASSENGER INNER JOIN ROUTE_DETAILS ON 
PASSENGER.Route_Code = ROUTE_DETAILS.Route_Code) AS P))*100 AS "percentage of distance travelled by that passenger from the total distance travelled by all passengers" from 
PASSENGER INNER JOIN ROUTE_DETAILS ON 
PASSENGER.Route_Code = ROUTE_DETAILS.Route_Code;

##query 11
select Distance, Price,
CASE WHEN Price >= 1000 THEN "Expensive"
WHEN Price < 1000 AND Price >= 500 THEN "Average Cost"
ELSE "Cheap" END AS Category from PRICE;