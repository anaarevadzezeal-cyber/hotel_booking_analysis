-- 03_booking_trends.sql
-- Analysis of monthly booking volume 

-- question #1: Which months have the highest number of bookings? 

SELECT arrival_date_year , 
       arrival_date_month ,
       count(*) as total_bookings
FROM hotel_bookings hb
GROUP BY arrival_date_year , arrival_date_month 
ORDER BY arrival_date_year, total_bookings DESC ; 

-- Average bookings per day of month 

SELECT arrival_date_day_of_month,
       Count(*) AS total_bookings
FROM hotel_bookings hb 
GROUP BY arrival_date_day_of_month 
ORDER BY arrival_date_day_of_month ;

-- Bookings by day of week (0=Sunday, 6=Saturday) 

SELECT 
    strftime('%w', reservation_status_date) AS weekday,
    COUNT(*) AS total_bookings
FROM hotel_bookings
GROUP BY weekday
ORDER BY weekday;

