-- 04_customer_segments.sql 

-- question #1: Market segment distribution (excluding canceled bookings)

SELECT market_segment ,
       COUNT(*) AS Total_Bookings_Not_Cancelled 
FROM hotel_bookings hb 
WHERE is_canceled = 0
GROUP BY market_segment 
ORDER BY Total_Bookings_Not_Cancelled DESC  


-- question #2: Compare repeat guest volume between 4-star and 5-star hotels 

SELECT hb.hotel,
       is_repeated_guest,
       star_rating,
       COUNT(*) AS Total_Bookings,
       COUNT(CASE WHEN is_repeated_guest = 1 then 1 END) as Repeated_Guests,
       ROUND(100.0 * count(case when is_repeated_guest = 1 then 1 end) / count(*) , 2) as repeat_guest_rate
FROM hotel_bookings hb 
INNER JOIN 
hotel_info hi ON hb.hotel=hi.hotel
group by star_rating
  

-- question #3: Which hotel star rating has the highest percentage of bookings that include children? 

SELECT hb.hotel, 
       star_rating,
       count(*) as Total_bookings,
       SUM(CASE WHEN children >=1 then 1 else 0 END) as Bookings_With_Children,
       ROUND(100.0 * SUM(CASE WHEN children >=1 THEN 1 ELSE 0 END) / COUNT(*), 2) as Percentage_of_res_with_children
FROM hotel_bookings hb 
INNER JOIN 
hotel_info hi ON hb.hotel=hi.hotel 
GROUP BY star_rating
 

-- question #4: Compare the total bookings and cancellations between the hotel with a spa and the hotel without a spa

SELECT 'Hotel with spa' AS Hotel_type,
       COUNT(*) AS Total_bookings,
       SUM(is_canceled) AS Total_cancellations
FROM hotel_bookings hb 
INNER JOIN 
hotel_info hi ON 
hb.hotel=hi.hotel 
WHERE has_spa=1 
UNION 
SELECT 'Hotel without spa ' AS Hotel_type ,
        COUNT(*) AS Total_bookings ,
        SUM(is_canceled) AS Total_cancellations
FROM hotel_info hi 
INNER JOIN 
hotel_bookings hb ON 
hi.hotel=hb.hotel 
WHERE has_spa=0

-- question #5: Star ratings with cancellation rate above 10% 

SELECT hb.hotel ,
      star_rating, 
      COUNT(*) as Total_bookings,
      SUM(is_canceled) as Total_cancelations ,
      ROUND(SUM(is_canceled) *100.0 / COUNT(*), 2) AS Cancellation_Percentage
FROM hotel_bookings hb 
INNER JOIN 
hotel_info hi ON
hb.hotel=hi.hotel
GROUP BY star_rating 
HAVING ROUND(SUM(is_canceled) *100.0 / COUNT(*), 2) > 10 
ORDER BY Cancellation_Percentage DESC