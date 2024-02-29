/*
There are a Lot of commented out constraints that do not work at the moment,
These will be revisited and retested or remade into queries with cases and checks
to avoid too many conflicting constraints.
*/

CREATE TABLE Guest_Info (
	Guest_ID VARCHAR(10) UNIQUE
	,First_Name VARCHAR(30) NOT NULL
	,Last_Name VARCHAR(30) NOT NULL
	,--Should add some sort of check to make sure there aren't too many uses of a name but idk yet how
	PRIMARY KEY (Guest_ID)
	);

CREATE TABLE Bookings (
	Booking_ID VARCHAR(10) UNIQUE
	,Num_Adults SMALLINT NOT NULL
	,Num_Children SMALLINT NOT NULL
	,Guest_ID VARCHAR(10) UNIQUE
--TODO: Minor_Safety check doesn't work as intended.
-- 	,CONSTRAINT Minor_Safety CHECK (
-- 		(
-- 			Num_Adults < 1
-- 			AND Num_Children > 1
-- 			)
-- 		 --Checks that minors can't rent a room without an adult
-- 		)
-- 	,--Checks that there isn't a large amount of adults trying to book with a single child
-- 	CONSTRAINT Empty_Booking CHECK (
--  		Num_Adults = 0
-- 		AND Num_Children = 0
-- 		),
	,CONSTRAINT Full_Occupancy CHECK (
		(
			Num_Adults <= 2
			AND Num_Children <= 2
			)
		OR (Num_Adults <= 4)
		)
	,--Checks that a room doesn't have more than 4 people in it at once
	PRIMARY KEY (Booking_ID)
	,FOREIGN KEY (Guest_ID) REFERENCES Guest_Info(Guest_ID) ON DELETE SET NULL
	);



CREATE TABLE Rooms (
	Booking_ID VARCHAR(10) UNIQUE
	,Room_Type INT NOT NULL
	,Price NUMERIC(5,2) NOT NULL
	,CONSTRAINT Num_Of_Types CHECK (
		Room_Type BETWEEN 1 AND 4
		)
	,FOREIGN KEY (Booking_ID) REFERENCES Bookings(Booking_ID) ON DELETE SET NULL
	);

CREATE TABLE Prior_Bookings (
	Guest_ID VARCHAR(10) UNIQUE
	,Repeat_Guest SMALLINT NOT NULL
	,Num_Prev_Cancels SMALLINT NOT NULL
	,Num_Prev_Stays SMALLINT NOT NULL
--TODDO: Repeat_Yes Check does not work as intended.
--	,CONSTRAINT Repeat_Yes CHECK (Repeat_Guest = 1)
-- 	,--Right now my best idea is moving it here to check if repeat guest is 1 which means yes
-- 	CONSTRAINT Repeat_Status CHECK (
-- 		Repeat_Guest = 1
-- 		OR Repeat_Guest = 0
-- 		)
	,--but then I don't know how to make it bounded to either 1 or 0, this line DOES work, but idk
	--how well it'll work when data population starts 
	FOREIGN KEY (Guest_ID) REFERENCES Guest_Info(Guest_ID) ON DELETE SET NULL
	);


--"foreign key (Repeat_Guest) references Guest_Info(Repeat_Guest)" doesn't work
--ERROR:  there is no unique constraint matching given keys for referenced table "guest_info" 
--SQL state: 42830
--We have to find some other way to get this table to only contain guests with a one in their repeated guest status
CREATE TABLE Timeslot (
	Booking_ID VARCHAR(10) UNIQUE
	,Num_Weekends SMALLINT NOT NULL
	,Num_Weekdays SMALLINT NOT NULL
	,Arrival_Year NUMERIC(4, 0) NOT NULL
	,Arrival_Month INT NOT NULL
	,Arrival_Date SMALLINT NOT NULL
-- 	,CONSTRAINT Max_Stay CHECK (
-- 		Num_Weekdays <= 5
-- 		AND Num_Weekends <= 2
--		) --Verifies booking is for isn't more than a week
-- 	,CONSTRAINT Days CHECK (
-- 		(
-- 			Arrival_Month = 2
-- 			AND Arrival_Date > 28
-- 			)
-- 		OR (
-- 			Arrival_Month = 9
-- 			AND Arrival_Date > 30
-- 			)
-- 		OR (
-- 			Arrival_Month = 4
-- 			AND Arrival_Date > 30
-- 			)
-- 		OR (
-- 			Arrival_Month = 6
-- 			AND Arrival_Date > 30
-- 			)
-- 		OR (
-- 			Arrival_Month = 11
-- 			AND Arrival_Date > 30
-- 			)
-- 		) --Verifies proper days of months
	,CONSTRAINT Months CHECK (
		Arrival_Month Between 1 and 12
		)
	,FOREIGN KEY (Booking_ID) REFERENCES Bookings(Booking_ID) ON DELETE SET NULL
	);


CREATE TABLE Amenities (
	Guest_ID VARCHAR(10) UNIQUE
	,Meal_Plan Varchar(20) NOT NULL
	,Parking_Space SMALLINT NOT NULL
	,CONSTRAINT Space_Selected CHECK (
		Parking_Space = 1
		OR Parking_Space = 0
		)
	,FOREIGN KEY (Guest_ID) REFERENCES Guest_Info(Guest_ID) ON DELETE SET NULL
	);
