
INSERT INTO Guest_Info(Guest_ID, First_Name, Last_Name) VALUES ('8825671442','David','Leblanc'); 
INSERT INTO Guest_Info(Guest_ID, First_Name, Last_Name) VALUES ('3474694238','Joshua','Martinez'); 
INSERT INTO Guest_Info(Guest_ID, First_Name, Last_Name) VALUES ('2265658250','Edward','Sanford'); 

INSERT INTO Bookings(Booking_ID, Num_Adults, Num_Children, Guest_ID) VALUES ('INN00001',2,0,'33297543');
INSERT INTO Bookings(Booking_ID, Num_Adults, Num_Children, Guest_ID) VALUES ('INN00002','2','0','42230290'); 
INSERT INTO Bookings(Booking_ID, Num_Adults, Num_Children, Guest_ID) VALUES ('INN00003','1','0','42619453'); 

INSERT INTO Rooms(Booking_ID, Room_Type, Price) VALUES ('INN00001',1, 65); 
INSERT INTO Rooms(Booking_ID, Room_Type, Price) VALUES ('INN00002', 2, 106.68); 
INSERT INTO Rooms(Booking_ID, Room_Type, Price) VALUES ('INN00003', 3, 60); 

INSERT INTO Prior_Bookings(Guest_ID, Repeat_Guest, Num_Prev_Cancels, Num_Prev_Stays) VALUES ('33297543',1,0,0);
INSERT INTO Prior_Bookings(Guest_ID, Repeat_Guest, Num_Prev_Cancels, Num_Prev_Stays) VALUES ('42230290',0,0,0); 

INSERT INTO Timeslot(Booking_ID, Num_Weekends, Num_Weekdays, Arrival_Year, Arrival_Month, Arrival_Date) VALUES ('INN00001',1,2,2017, 10, 2); 
INSERT INTO Timeslot(Booking_ID, Num_Weekends, Num_Weekdays, Arrival_Year, Arrival_Month, Arrival_Date) VALUES ('INN00002',2,3,2018, 11, 6); 
INSERT INTO Timeslot(Booking_ID, Num_Weekends, Num_Weekdays, Arrival_Year, Arrival_Month, Arrival_Date) VALUES ('INN00003',2,1,2018, 2, 28); 

INSERT INTO Amenities(Guest_ID, Meal_Plan, Parking_Space) VALUES ('33297543','Meal Plan 1',0); 
INSERT INTO Amenities(Guest_ID, Meal_Plan, Parking_Space) VALUES ('42230290','Not Selected',0); 
INSERT INTO Amenities(Guest_ID, Meal_Plan, Parking_Space) VALUES ('42619453','Meal Plan 1',1); 
