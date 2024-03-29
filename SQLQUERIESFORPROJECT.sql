--ALL GUESTS THAT HAVE HAD a prior booking SORTED BY date 
CREATE VIEW repeatedguests AS 
SELECT bookings.guest_id, bookings.booking_id, timeslot.arrival_year, timeslot.arrival_month, timeslot.arrival_date 
FROM bookings INNER JOIN timeslot ON bookings.booking_id = timeslot.booking_id
INNER JOIN prior_bookings ON bookings.guest_id = prior_bookings.guest_id
WHERE repeat_guest = 1
ORDER BY arrival_year, arrival_month, arrival_date;
--Call view
SELECT * FROM public.repeatedguests

--MAKE A VIEW: Select everyone with a certain meal plan on the month of december and in 2018--
CREATE VIEW meal_plans_2018_december AS
SELECT b.guest_id, b.booking_id, t.arrival_year, t.arrival_month, t.arrival_date, a.meal_plan
FROM bookings b
JOIN timeslot t ON b.booking_id = t.booking_id
JOIN amenities a ON b.guest_id = a.guest_id
WHERE arrival_month = 12
AND arrival_year = 2018
AND meal_plan = 'Meal Plan 1'
ORDER BY arrival_date;
--Call view
SELECT * FROM public.meal_plans_2018_december

--THE HOTEL ADDED A NEW SERVICE TO THEIR AMENITIES. ALTER the table so that it includes the "Room Cleaning" Amenties with 3 types of room cleaning. Any bookings before it should not be changed
--Change booking number 499 to room cleaning type 3
ALTER TABLE amenities
ADD COLUMN room_cleaning SMALLINT,
ADD CONSTRAINT room_cleaning_type_limit CHECK (
room_cleaning between 1 and 3) ;

UPDATE amenities
SET room_cleaning = 3
FROM bookings 
WHERE bookings.guest_id = amenities.guest_id
AND bookings.booking_id = 'INN00499';

--SELECT ALL PEOPLE THAT HAVE ROOM TYPE 4 IN 2017--
SELECT b.booking_id, b.guest_id, g.First_Name,g.Last_Name, r.room_type
FROM bookings b
JOIN guest_info g ON b.guest_id = g.guest_id
JOIN rooms r ON b.booking_id = r.booking_id
JOIN timeslot t ON b.booking_id = t.booking_id
WHERE t.arrival_year = 2017
AND r.room_type = 4;

----- FUNCTION: Select all people staying a week or greater/ NUM weekends + num weekdays >= 7 -----
CREATE OR REPLACE FUNCTION StayingForWeekOrGreater() RETURNS TABLE (
    guest_id VARCHAR(255), 
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    start_date DATE,
    number_of_weekends SMALLINT,
    number_of_weekdays SMALLINT
)
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        g.guest_id, 
        g.first_name,
        g.last_name,
        DATE(t.arrival_year || '-' || t.arrival_month || '-' || t.arrival_date) AS start_date,
        t.num_weekends,
        t.num_weekdays
    FROM
        bookings b
    JOIN
        guest_info g ON b.guest_id = g.guest_id
    JOIN
        timeslot t ON b.booking_id = t.booking_id
    WHERE
        (t.num_weekends + t.num_weekdays) >= 7;
END
$$
LANGUAGE 'plpgsql';

SELECT * 
FROM StayingForWeekOrGreater();



------ Select all the names, ID, and booking ID of all people staying in the year 2017 ------
SELECT bookings.booking_id, guest_info.guest_id, guest_info.first_name, guest_info.last_name
FROM timeslot NATURAL JOIN guest_info NATURAL JOIN bookings
WHERE timeslot.arrival_year = 2017;

------ Select all people in the amenities table who have NO Parking space and NO meal plan -------
select booking_id, guest_id, first_name, last_name, meal_plan, parking_space
from amenities natural join guest_info natural join bookings
where meal_plan = 'Not Selected' AND parking_space = 0;

----- Select all families ie parents >=1 children >= 1 ---------
select guest_id, booking_id, first_name, last_name, num_adults, num_children 
from bookings natural join guest_info
where num_children >= 1 AND num_adults >= 1;

--FIND THE AVERAGE PRICE OF ROOM TYPE 1 IN NOVEMBER 2018
SELECT t.arrival_year, t.arrival_month,ROUND(AVG(Price),2) as avg_room_price
FROM rooms r
JOIN timeslot t ON r.booking_id = t.booking_id
WHERE t.arrival_year = 2018
AND t.arrival_month = 11
GROUP BY t.arrival_year, t.arrival_month;


--Transaction to rename person after marriage and update booking
BEGIN;
-- Delete Holly's Previous profile and booking
DELETE FROM bookings
WHERE guest_id = '12021893'
AND booking_id = 'INN00062'
AND num_adults = 1
AND num_children = 0;

DELETE FROM guest_info
WHERE guest_id = '1202198320'
AND first_name = 'Holly'
AND last_name = 'Graham';

--Reinsert Holly with her new last name
INSERT INTO guest_info (guest_id, first_name, last_name)
VALUES ('1202198320', 'Holly', 'Watkins');

--Update Joshua Watkin's booking to include 2 adults
UPDATE bookings
SET num_adults = 2
WHERE booking_id = 'INN00086'
AND guest_id = '1623051702'; 

COMMIT;

