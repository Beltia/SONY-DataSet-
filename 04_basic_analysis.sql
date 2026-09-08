-- Basic descriptive analysis

SELECT COUNT(*) AS trading_days,
       MIN(trading_date) AS first_date,
       MAX(trading_date) AS last_date,
       AVG(close_price) AS average_close,
       MIN(close_price) AS minimum_close,
       MAX(close_price) AS maximum_close,
       AVG(volume) AS average_volume
FROM sony_stock;

-- Highest and lowest closing-price days
SELECT trading_date, close_price
FROM sony_stock
ORDER BY close_price DESC
LIMIT 10;

SELECT trading_date, close_price
FROM sony_stock
ORDER BY close_price ASC
LIMIT 10;

-- Highest-volume days
SELECT trading_date, volume, close_price
FROM sony_stock
ORDER BY volume DESC
LIMIT 10;

-- Annual performance
WITH yearly AS (
    SELECT EXTRACT(YEAR FROM trading_date)::INT AS year,
           (ARRAY_AGG(close_price ORDER BY trading_date))[1] AS first_close,
           (ARRAY_AGG(close_price ORDER BY trading_date DESC))[1] AS last_close,
           AVG(close_price) AS average_close,
           MAX(close_price) AS max_close,
           MIN(close_price) AS min_close,
           AVG(volume) AS average_volume
    FROM sony_stock
    GROUP BY EXTRACT(YEAR FROM trading_date)
)
SELECT year, first_close, last_close,
       ROUND(((last_close / NULLIF(first_close,0)) - 1) * 100, 2) AS annual_return_pct,
       average_close, max_close, min_close, average_volume
FROM yearly
ORDER BY year;

-- Monthly averages
SELECT EXTRACT(YEAR FROM trading_date)::INT AS year,
       EXTRACT(MONTH FROM trading_date)::INT AS month,
       AVG(close_price) AS average_close,
       AVG(volume) AS average_volume
FROM sony_stock
GROUP BY 1,2
ORDER BY 1,2;
