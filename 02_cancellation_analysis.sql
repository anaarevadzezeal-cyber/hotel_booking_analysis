-- 02_analysis_cancellations.sql 
-- question #1: Calculate the overall cancellation rate 

SELECT COUNT(*) AS total_bookings,
       SUM(is_canceled) AS total_cancellations,
       ROUND(100.0 * SUM(is_canceled) / COUNT(*), 2) AS cancellation_rate
FROM hotel_bookings; 

-- Cancellation rate by month 

SELECT arrival_date_month ,
       Count(*) AS total_bookings, 
       SUM(is_canceled) AS total_cancellations,
       ROUND(100.0 * sum(is_canceled) / count(*), 2) AS Cancellation_rate
FROM hotel_bookings hb 
GROUP BY arrival_date_month 
ORDER BY Cancellation_rate DESC

-- Cancellation rate by market segment 

SELECT market_segment, 
       count(*) as total_bookings,
       SUM(is_canceled) AS total_cancellations,
       Round(100.0 * sum(is_canceled)/count(*), 2 ) as Cancellation_rate
FROM hotel_bookings hb 
GROUP BY market_segment
ORDER BY Cancellation_rate DESC
