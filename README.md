# SQL-Hotel-Project

[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/JacobAronowitz/SQL-Hotel-Project-Group-4/badge)](https://securityscorecards.dev/viewer/?uri=github.com/JacobAronowitz/SQL-Hotel-Project-Group-4)
[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/8563/badge)](https://www.bestpractices.dev/projects/8563)

A Hotel Management Database complete with Queries and DDL

Hotel Database Introduction

Project Objective: The objective of this database project is to create a relational database system that is able to accurately track and support the assorted reservation details and statistics of an upscale hotel. The expected outcomes of this project include an efficient way to track guest reservations, available rooms, dynamic room pricing, and guest amenities.  

Scope of the Project: The scope of this project encompasses the following aspects of the
hotel's operations:
Guest reservations and amenities
Dynamic room pricing that adjusts per day
Amount and type of rooms available
Repeated customer status and previous bookings/cancellations
Number of weekends and weeknights stayed

The project does not include employee data such as salary, benefits, time spent with the company, or vacation days. Additionally, it does not address guest payment type/information, guest sentiment data, or type of guest trip.

# Dataset Description: The dataset includes several interconnected tables that simulate the real-world happenings of a hotel management system. Key entities include:

 Bookings (previously Guests): Once a guest makes a reservation, the booking is assigned a unique ID (Booking_ID - Primary Key) number that relates to the details of the guest’s reservation. Details include guest information of the rentee (Guest_ID references guest information table), the number of adults that are staying at the hotel and the number of children that are staying at the hotel.
Booking_ID (Primary Key)
Guest_ID (Foreign Key)
Number_of_adults
Number_of_children

Rooms: The ‘Rooms’ table will list all of the details of the rooms offered, including the room type, booking availability, and price per room. 
Booking_ID (Foreign Key)
Room_Type
Price

Amenities: This table details the amenities selected by the guest. These amenities include the type of meal plan selected by the guest, whether or not the guest reserved a parking space or not, and special requests made by the guest.
Guest_ID (Foreign key)
Meal_Plan
Parking_Place

Prior Guest Bookings: This table contains data regarding guest’s previous interactions with the hotel including prior bookings, prior cancellations, and whether or not they are repeated guests.
Guest ID (Foreign Key)
Num_Prev_Cancel
Repeated_Guest 
Num_Prev_Stays

 Time Slots: The 'time_slot' table contains the guest’s reservation details on the amount of weekends and weeknights guests plan on staying or have booked to stay, the exact arrival date, and the time between booking and arrival.
Booking_ID (Foreign Key)
Num_Weekends
Num_Weekdays
Arrival_Year
Arrival_Month
Arrival_Date

Guest Information: Guests will be assigned a unique ID (Guest_ID) that identifies each guest. This table will have the Unique ID (primary key), their name, and whether they were a prior guest or not.
Guest_ID (Primary Key)
First_Name
Last_Name

Logic behind each table:
Guest_Info: The logic behind this table was that each guest that makes a booking gets assigned a unique 10-digit ID that corresponds to their name which will be used for any other operation involving that guest.

Bookings: The logic behind this table is that once a guest has made a booking, they are assigned another unique ID that corresponds to their booking and their booking information including how many adults and how many children are included. The table also checks that a booking for no more than 4 people as that is the maximum room occupancy.

Rooms: The logic behind this table is to store the type of room booked by the guest, either 1,2,3,4 as well as the corresponding price per room, the price of which is dynamic

Prior_Bookings: The logic behind this table is that if the guest has made any prior bookings before the current booking, it will display their status as a repeated guest, as well as how many previous cancellations and previous stays they have made.

Timeslot: The logic behind this table is to show how long the booking is for. A booking can be no longer than a week at a time, and the number of weekends and weekdays is displayed alongside the exact arrival date.

Amenities: The logic behind this table is to check whether the guest has requested any amenities alongside their stay such as a meal plan or a parking space


# Data Population: 
The data was provided through a CSV datasheet found on Kaggle which was ported into Excel, each column was then into tables that made sense. The Original datasheet did not provide guest names and IDs, so the guest info table was randomly generated with names (first name and last name) and randomized IDs for the guest info.

# How To Use:
In order to use the system, open the DDL file first in software like PostgreSQL, then run the DDL to create the tables. Once the tables have been created, open the Population file and populate the data. After completing both steps, the database is now ready for querying.

# Contributions:
Before a contribution is made using a pull request, contact me at JacobAronowitzMail@gmail.com so we can discuss what is being added.
Acceptable contributions must:
1) Change the DDL, Queries, or Inserts in a significant way.
2) Address an issue or to-do list in the SQL file being contributed to.
3) The contribution must not cause the rest of the SQL to break.

# Bug and Vulnerability Reporting:
All bugs and vulnerabilities must be reported to JacobAronowitzMail@gmail.com with a summary of the bug and the name of the SQL file where it was found.
