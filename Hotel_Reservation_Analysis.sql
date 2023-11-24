use [My Practice]
go

select * from [dbo].[Hotel Reservation Dataset]

/*1. What is the total number of reservations in the dataset?*/
select count(booking_status) as Count_of_Reservations
from [dbo].[Hotel Reservation Dataset]
where booking_status='Not_Canceled'

/*2.Which meal plan is the most popular among guests?*/
select type_of_meal_plan,count(type_of_meal_plan) as 'No.of times chosen by Guests' 
from [dbo].[Hotel Reservation Dataset]
group by type_of_meal_plan
order by 2 desc

/*3. What is the average price per room for reservations involving children?*/

select round(avg(avg_price_per_room),2) as [Avg.room_price] from [Hotel Reservation Dataset]
where no_of_children > 0

/*4. How many reservations were made for the year 20XX (replace XX with the desired year)?*/
select count(booking_status) as'No_of_Reservations' from [Hotel Reservation Dataset]
where booking_status='Not_Canceled' and datepart(yy,arrival_date)= 2018

/*5. What is the most commonly booked room type?*/

select room_type_reserved,count(room_type_reserved) as [No.of times booked] from [Hotel Reservation Dataset]
group by room_type_reserved
order by 2 desc

/*6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?*/
select count(booking_status) as[No.of Reservations] from [Hotel Reservation Dataset]
where booking_status = 'Not_Canceled' and no_of_weekend_nights >0

/*7. What is the highest and lowest lead time for reservations?*/

select max(lead_time) as Highest_lead_time, min(lead_time) as Lowest_lead_time
from [Hotel Reservation Dataset]
where booking_status='Not_Canceled'

/* 8. What is the most common market segment type for reservations? */

select market_segment_type,count(market_segment_type) as count_of_market_segment_type from [Hotel Reservation Dataset]
group by market_segment_type
order by 2 desc

/* 9. How many reservations have a booking status of "Confirmed"?*/

select count(booking_status) as Cnfirmed_Reservations from [Hotel Reservation Dataset]
where booking_status='Not_Canceled'

/* 10. What is the total number of adults and children across all reservations?*/


select sum(no_of_adults) as Total_Adults, sum(no_of_children) as Total_Children
from [Hotel Reservation Dataset]
where booking_status = 'Not_Canceled'

/*11. What is the average number of weekend nights for reservations involving children?*/

select sum(no_of_weekend_nights) as 'Avg.of weekend Nights' from [Hotel Reservation Dataset]
where booking_status='Not_Canceled' and no_of_children > 0

/*12. How many reservations were made in each month of the year?*/

select year(arrival_date) as 'Year',Month(arrival_date) as 'Month', count(booking_status) as 'No.of Reservations'
from [Hotel Reservation Dataset]
where booking_status='Not_Canceled'
group by year(arrival_date) ,Month(arrival_date)
order by 1,2

/*13. What is the average number of nights (both weekend and weekday) spent by guests for each room
type?*/
select * from [Hotel Reservation Dataset]
select room_type_reserved,AVG(no_of_weekend_nights + no_of_week_nights) as [Avg.nightsSpent] from [Hotel Reservation Dataset]
group by room_type_reserved

/* 14. For reservations involving children, what is the most common room type, and what is the average
price for that room type? */

select room_type_reserved, count(room_type_reserved) as Frequency,round(avg(avg_price_per_room),2) as avg_price from [Hotel Reservation Dataset]
where no_of_children > 0 and booking_status = 'Not_Canceled'
group by room_type_reserved
order by 2 desc

/* 15. Find the market segment type that generates the highest average price per room.*/
select market_segment_type, round(sum(avg_price_per_room),2) as [Avg.price per segment] from [Hotel Reservation Dataset]
group by market_segment_type
order by 2 desc

select * from [Hotel Reservation Dataset]