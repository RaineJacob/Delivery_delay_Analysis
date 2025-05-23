-- ================================================
-- 📦 DELIVERY DATA ANALYSIS SQL SCRIPT
-- Objective: Analyze delivery performance across time, traffic, festivals, and order value.
-- Source Table: delivery_data
-- ================================================


-- 🔍 Inspect full dataset structure (initial exploration)
SELECT
    *
FROM
    delivery_data;


-- 🕒 ANALYSIS 1: Average Delivery Delay by Time of Day
-- Insight: Identifies peak delay periods like Night or Evening.
SELECT
    time_of_day,
    COUNT(*) AS total_orders,
    AVG(delivery_time_min) AS avg_delay
FROM
    delivery_data
GROUP BY
    time_of_day
ORDER BY
    avg_delay DESC;


-- 🎉 ANALYSIS 2: Impact of Festivals on Delivery Time
-- Insight: Shows whether festivals contribute to longer delivery times.
SELECT
    festival_flag,
    COUNT(*) AS total_orders,
    AVG(delivery_time_min) AS avg_delay
FROM
    delivery_data
GROUP BY
    festival_flag
ORDER BY
    avg_delay DESC;


-- 🚦 ANALYSIS 3: Delivery Delay by Traffic Level
-- Insight: Quantifies how low, medium, or high traffic affects delay.
SELECT 
    traffic_level,
    COUNT(*) AS total_orders,
    AVG(delivery_delay_min) AS avg_delay
FROM 
    delivery_data
GROUP BY 
    traffic_level
ORDER BY 
    avg_delay DESC;


-- 💰 ANALYSIS 4: Order Value vs. Delay
-- Insight: Groups orders by value tiers and shows delay + value averages.
SELECT
    CASE
        WHEN order_value < 100 THEN 'Low'
        WHEN order_value BETWEEN 100 AND 300 THEN 'Medium'
        ELSE 'High'
    END AS order_value_range,
    COUNT(*) AS order_count,
    AVG(delivery_delay_min) AS avg_delay,
    AVG(order_value) AS avg_value
FROM 
    delivery_data
GROUP BY
    CASE
        WHEN order_value < 100 THEN 'Low'
        WHEN order_value BETWEEN 100 AND 300 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY
    avg_delay DESC;


-- ⏱️ ANALYSIS 5: Delayed vs. On-Time Orders
-- Insight: Distribution of orders by whether they exceeded the estimated time.
SELECT
    CASE 
        WHEN delivery_delay_min > 0 THEN 'Delayed'
        ELSE 'On Time'
    END AS delivery_status,
    COUNT(*) AS total_orders
FROM
    delivery_data
GROUP BY
    CASE 
        WHEN delivery_delay_min > 0 THEN 'Delayed'
        ELSE 'On Time'
    END;


-- 📆 ANALYSIS 6: Average Delay by Day of the Week
-- Insight: Identifies weekdays with the most delivery delays.
SELECT
    DATENAME(WEEKDAY, order_datetime) AS day_of_week,
    COUNT(*) AS total_orders,
    AVG(delivery_delay_min) AS avg_delay
FROM
    delivery_data
GROUP BY
    DATENAME(WEEKDAY, order_datetime)
ORDER BY
    avg_delay DESC;


-- 🎉🚗 ANALYSIS 7: Festival + Traffic Combo Impact
-- Insight: Which festival & traffic conditions result in worst delays.
SELECT 
    festival_flag,
    traffic_level,
    COUNT(*) AS total_orders,
    AVG(delivery_delay_min) AS avg_delay
FROM 
    delivery_data
GROUP BY 
    festival_flag, traffic_level
ORDER BY 
    avg_delay DESC;


-- 📍 ANALYSIS 8: Top 5 Most Delayed Delivery Areas
-- Insight: Target zones for operational improvement.
SELECT TOP 5
    drop_area,
    COUNT(*) AS total_orders,
    AVG(delivery_delay_min) AS avg_delay
FROM
    delivery_data
GROUP BY
    drop_area
ORDER BY
    avg_delay DESC;

