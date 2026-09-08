-- Data quality checks

-- NULL checks
SELECT
    COUNT(*) FILTER (WHERE trading_date IS NULL) AS null_dates,
    COUNT(*) FILTER (WHERE open_price IS NULL) AS null_open,
    COUNT(*) FILTER (WHERE high_price IS NULL) AS null_high,
    COUNT(*) FILTER (WHERE low_price IS NULL) AS null_low,
    COUNT(*) FILTER (WHERE close_price IS NULL) AS null_close,
    COUNT(*) FILTER (WHERE volume IS NULL) AS null_volume
FROM sony_stock;

-- Duplicate dates
SELECT trading_date, COUNT(*)
FROM sony_stock
GROUP BY trading_date
HAVING COUNT(*) > 1;

-- Invalid price relationships
SELECT *
FROM sony_stock
WHERE high_price < low_price
   OR high_price < open_price
   OR high_price < close_price
   OR low_price > open_price
   OR low_price > close_price;

-- Invalid/zero values
SELECT *
FROM sony_stock
WHERE open_price <= 0
   OR high_price <= 0
   OR low_price <= 0
   OR close_price <= 0
   OR volume < 0;

-- Date range
SELECT MIN(trading_date) AS first_date,
       MAX(trading_date) AS last_date,
       COUNT(*) AS rows
FROM sony_stock;

-- Potentially unusual observations: investigate rather than automatically delete.
WITH returns AS (
    SELECT trading_date, close_price,
           LAG(close_price) OVER (ORDER BY trading_date) AS previous_close
    FROM sony_stock
)
SELECT trading_date, close_price, previous_close,
       (close_price / NULLIF(previous_close,0) - 1) * 100 AS daily_return_pct
FROM returns
WHERE ABS((close_price / NULLIF(previous_close,0) - 1) * 100) > 10
ORDER BY ABS((close_price / NULLIF(previous_close,0) - 1) * 100) DESC;
