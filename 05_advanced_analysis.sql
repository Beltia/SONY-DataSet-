-- Advanced SQL: LAG, rolling averages, ranking and volatility

WITH daily AS (
    SELECT trading_date, close_price, volume,
           LAG(close_price) OVER (ORDER BY trading_date) AS previous_close
    FROM sony_stock
)
SELECT trading_date, close_price, previous_close,
       close_price - previous_close AS price_change,
       ROUND(((close_price / NULLIF(previous_close,0)) - 1) * 100, 4) AS daily_return_pct
FROM daily
ORDER BY trading_date;

-- 30-trading-day moving average
SELECT trading_date, close_price,
       AVG(close_price) OVER (
           ORDER BY trading_date
           ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
       ) AS sma_30
FROM sony_stock
ORDER BY trading_date;

-- 30-day rolling volatility of daily returns
WITH returns AS (
    SELECT trading_date, close_price,
           ((close_price / NULLIF(LAG(close_price) OVER (ORDER BY trading_date),0)) - 1) AS daily_return
    FROM sony_stock
)
SELECT trading_date,
       daily_return,
       STDDEV_SAMP(daily_return) OVER (
           ORDER BY trading_date
           ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
       ) * 100 AS rolling_30d_volatility_pct
FROM returns
ORDER BY trading_date;

-- Rank the largest daily moves
WITH returns AS (
    SELECT trading_date, close_price,
           ((close_price / NULLIF(LAG(close_price) OVER (ORDER BY trading_date),0)) - 1) * 100 AS daily_return_pct
    FROM sony_stock
)
SELECT trading_date, close_price, daily_return_pct,
       RANK() OVER (ORDER BY ABS(daily_return_pct) DESC) AS movement_rank
FROM returns
WHERE daily_return_pct IS NOT NULL
ORDER BY movement_rank
LIMIT 20;

-- Volume compared with the overall average
SELECT trading_date, volume, close_price
FROM sony_stock
WHERE volume > (SELECT AVG(volume) FROM sony_stock) * 2
ORDER BY volume DESC;
