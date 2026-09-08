-- Historical investment characteristics.
-- These queries are descriptive, not forecasts or personalised investment advice.

-- Buy-and-hold price change across the dataset
SELECT MIN(trading_date) AS start_date,
       MAX(trading_date) AS end_date,
       (ARRAY_AGG(close_price ORDER BY trading_date))[1] AS starting_close,
       (ARRAY_AGG(close_price ORDER BY trading_date DESC))[1] AS ending_close,
       ROUND((
           ((ARRAY_AGG(close_price ORDER BY trading_date DESC))[1] /
            NULLIF((ARRAY_AGG(close_price ORDER BY trading_date))[1],0)) - 1
       ) * 100, 2) AS total_price_change_pct
FROM sony_stock;

-- Maximum historical drawdown based on closing prices
WITH running AS (
    SELECT trading_date, close_price,
           MAX(close_price) OVER (
               ORDER BY trading_date
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ) AS running_peak
    FROM sony_stock
)
SELECT trading_date, close_price, running_peak,
       ROUND(((close_price / NULLIF(running_peak,0)) - 1) * 100, 2) AS drawdown_pct
FROM running
ORDER BY drawdown_pct ASC
LIMIT 20;

-- Annual volatility and return
WITH returns AS (
    SELECT trading_date,
           EXTRACT(YEAR FROM trading_date)::INT AS year,
           ((close_price / NULLIF(LAG(close_price) OVER (ORDER BY trading_date),0)) - 1) AS daily_return
    FROM sony_stock
),
yearly AS (
    SELECT year,
           STDDEV_SAMP(daily_return) * 100 AS daily_volatility_pct,
           AVG(daily_return) * 100 AS average_daily_return_pct
    FROM returns
    WHERE daily_return IS NOT NULL
    GROUP BY year
)
SELECT *
FROM yearly
ORDER BY year;

-- Important interpretation note:
-- Historical return and volatility describe what happened in the sample.
-- They do not establish what Sony's future return or risk will be.
