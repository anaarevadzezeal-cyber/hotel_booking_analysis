-- 01_exploration.sql 

-- question #1: Check how many rows are in the dataset

SELECT COUNT(*) AS total_bookings
From hotel_bookings hb ;


-- question #2: Look at a sample of the data

SELECT *
From hotel_bookings hb Limit 5; 

-- question #3: What is the time coverage? (earliest and latest reservation dates) 

SELECT MIN(date(reservation_status_date)) As Earliest_reservation,
       MAX(date(reservation_status_date)) As Latest_reservation
From hotel_bookings hb ; 

-- question #4: How many unique customers by country? 

SELECT country , count(*) as reservations
From hotel_bookings hb 
Group by country 
order by country  DESC limit 10 ; 

-- question #5: What are the main market segments? (distribution of booking channels)

SELECT market_segment, count(*) AS Reservations
from hotel_bookings hb 
group by market_segment 
order by Reservations desc ; 

-- question #6: What is the proportion of cancelled vs. non-cancelled bookings?

SELECT is_canceled,
count(*) as bookings, 
ROUND(100.0 * count(*) / (SELECT count(*) From hotel_bookings hb), 2) AS precentage
From hotel_bookings hb 
group by is_canceled 

-- question #7: Average length of stay (nights = week + weekend nights)

SELECT ROUND(AVG(stays_in_weekend_nights + stays_in_week_nights), 2) AS avg_length_of_stay
FROM hotel_bookings;

-- question #8: Any missing values in key columns? 

SELECT SUM(case when country IS NULL THEN 1 ELSE 0 END) AS Missing_country, 
       SUM(CASE WHEN market_segment IS NULL THEN 1 ELSE 0 END) AS MIssing_Market_Segment
FROM hotel_bookings hb 
