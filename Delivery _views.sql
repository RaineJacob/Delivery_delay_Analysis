-- Creatign Views for importing BI dashboard

-- Time of Day View
CREATE VIEW vw_orders_by_time_of_day AS
SELECT
	time_of_day,
	count(*) AS total_orders,
	avg(delivery_time_min) AS avg_delay
FROM delivery_data
GROUP BY time_of_day;

--festival impact

CREATE VIEW vw_festival_impact AS
SELECT
	festival_flag,
	count(*) AS total_orders,
	avg(delivery_time_min) AS avg_delay
FROM delivery_data
GROUP BY festival_flag;


--Traffic impact

CREATE VIEW vw_traffic_impact AS
SELECT 
	traffic_level,
	count(*) AS total_orders,
	avg(delivery_delay_min) AS avg_delay
FROM delivery_data
GROUP BY traffic_level;

--Order value vs delay

CREATE VIEW vw_order_value_vs_delay AS
SELECT
	CASE
		WHEN order_value < 100 THEN 'Low'
		WHEN order_value BETWEEN 100 AND 300 THEN 'Medium'
		ELSE 'High'
	END AS order_value_range,
	count(*) AS order_count,
	avg(delivery_delay_min) AS avg_delay,
	avg(order_value) AS avg_value
FROM delivery_data
GROUP BY
	CASE
		WHEN order_value < 100 THEN 'Low'
		WHEN order_value BETWEEN 100 AND 300 THEN 'Medium'
		ELSE 'High'
	END;


--Delivery status

CREATE VIEW vw_delivery_status_summary AS
SELECT
	CASE 
		WHEN delivery_delay_min > 0 THEN 'Delayed'
		ELSE 'On Time'
	END AS delivery_status,
	count(*) AS total_orders
FROM delivery_data
GROUP BY
	CASE 
		WHEN delivery_delay_min > 0 THEN 'Delayed'
		ELSE 'On Time'
	END;


--Delay by day of week

CREATE VIEW vw_delay_by_day_of_week AS
SELECT
	DATENAME(weekday, order_datetime) AS day_of_week,
	count(*) AS total_orders,
	avg(delivery_delay_min) AS avg_delay
FROM delivery_data
GROUP BY DATENAME(weekday, order_datetime);


--festival trafffic combo

CREATE VIEW vw_festival_traffic_combo AS
SELECT 
	festival_flag,
	traffic_level,
	count(*) AS total_orders,
	avg(delivery_delay_min) AS avg_delay
FROM delivery_data
GROUP BY festival_flag, traffic_level;


--top delayed location 

CREATE VIEW vw_top_delayed_locations AS
SELECT TOP 5
	drop_area,
	count(*) AS total_orders,
	avg(delivery_delay_min) AS avg_delay
FROM delivery_data
GROUP BY drop_area
ORDER BY avg_delay DESC;


--fastest delivery agents

CREATE VIEW vw_fastest_delivery_agents AS
SELECT TOP 5
	delivery_agent_id,
	count(*) AS total_orders,
	avg(delivery_delay_min) AS avg_delay
FROM delivery_data
GROUP BY delivery_agent_id
HAVING count(*) > 10
ORDER BY avg_delay;

--delay count
CREATE VIEW vw_delivery_delay_counts AS
SELECT
    SUM(CASE WHEN delivery_delay_min > 0 THEN 1 ELSE 0 END) AS delayed_orders,
    SUM(CASE WHEN delivery_delay_min <= 0 THEN 1 ELSE 0 END) AS on_time_orders,
    COUNT(*) AS total_orders
FROM delivery_data;
