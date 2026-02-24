CREATE DATABASE ola;
USE ola;

CREATE TABLE ola_rides (
    date_time DATETIME,
    ride_time TIME,
    booking_id VARCHAR(20),
    booking_status VARCHAR(50),
    customer_id VARCHAR(20),
    vehicle_type VARCHAR(30),
    pickup_location VARCHAR(100),
    drop_location VARCHAR(100),
    v_tat INT,
    c_tat INT,
    canceled_rides_by_customer VARCHAR(255),
    canceled_rides_by_driver VARCHAR(255),
    incomplete_rides VARCHAR(10),
    incomplete_rides_reason VARCHAR(255),
    booking_value INT,
    payment_method VARCHAR(30),
    ride_distance INT,
    driver_ratings DECIMAL(3,1),
    customer_rating DECIMAL(3,1),
    vehicle_images VARCHAR(255)
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/OLA_Bookings.csv'
INTO TABLE ola_rides
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- ---------------------------------------------------------------------------------------------------------------------------------------------
 -- Business questions
-- 1. Retrieve all successful bookings:
CREATE view successful_Bookings AS
SELECT *
FROM ola_rides
where booking_status ='success';

-- 2. Find the average ride distance for each vehicle type:
CREATE VIEW rides_distance_each_vehical AS
SELECT vehicle_type, ROUND(AVG(ride_distance),2) AS Avg_distance
FROM ola_rides
GROUP BY vehicle_type;

-- 3. Get the total number of cancelled rides by customers:
CREATE VIEW canceled_rides_by_customers AS
SELECT COUNT(*)FROM ola_rides
WHERE booking_status='Canceled by customer';

-- 4. List the top 5 customers who booked the highest number of rides:
CREATE VIEW top_5_customers AS
SELECT customer_id, COUNT(booking_id) AS total_rides
FROM ola_rides
GROUP BY customer_id
ORDER BY total_rides DESC 
LIMIT 5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
CREATE VIEW cancelled_by_drivers_P_C_issues AS
SELECT Count(*) FROM ola_rides 
WHERE canceled_rides_by_driver = 'Personal & Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
CREATE VIEW max_min_Driver_ratings AS
SELECT MAX(driver_ratings) AS max_rating,
MIN(driver_ratings) AS min_rating
FROM ola_rides
WHERE vehicle_type = 'Prime Sedan'
AND driver_ratings > 0;


-- 7. Retrieve all rides where payment was made using UPI:
CREATE VIEW UPI_payments AS
SELECT *
FROM ola_rides
WHERE payment_method ='UPI';


-- 8. Find the average customer rating per vehicle type:
CREATE VIEW Avg_customer_ratings AS
SELECT vehicle_type,ROUND(AVG(customer_rating),2) AS Avg_customer_rating
FROM ola_rides
GROUP BY vehicle_type;


-- 9. Calculate the total booking value of rides completed successfully:
CREATE VIEW total_successful_Ride_values AS
SELECT SUM(booking_value) AS total_successful_Ride_values
FROM ola_rides
WHERE booking_status='success';


-- 10. List all incomplete rides along with the reason:
CREATE VIEW incomplete_rides_reason AS 
SELECT booking_id,incomplete_rides_reason
FROM ola_rides
WHERE incomplete_rides='Yes';


-- ----------------------------------------------------------------------------------------------------------------------
-- ANSWERS 

-- 1. Retrieve all successful bookings:
SELECT *
FROM sucessful_Bookings;

-- 2. Find the average ride distance for each vehicle type:
SELECT * FROM rides_distance_each_vehical;

-- 3. Get the total number of cancelled rides by customers:
SELECT * FROM canceled_rides_by_customers;

-- 4. List the top 5 customers who booked the highest number of rides:
SELECT * FROM top_5_customers;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT * FROM  cancelled_by_drivers_P_C_issues;

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT * FROM max_min_Driver_ratings;

-- 7. Retrieve all rides where payment was made using UPI:
SELECT * FROM UPI_payments;

-- 8. Find the average customer rating per vehicle type:
SELECT * FROM Avg_customer_ratings;

-- 9. Calculate the total booking value of rides completed successfully:
SELECT * FROM total_successful_Ride_values;

-- 10. List all incomplete rides along with the reason:
SELECT * FROM incomplete_rides_reason;

