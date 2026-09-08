-- Connect to sony_stock_analytics before running this script.

DROP TABLE IF EXISTS sony_stock;

CREATE TABLE sony_stock (
    stock_id BIGSERIAL PRIMARY KEY,
    trading_date DATE NOT NULL UNIQUE,
    open_price NUMERIC(14,6) NOT NULL CHECK (open_price >= 0),
    high_price NUMERIC(14,6) NOT NULL CHECK (high_price >= 0),
    low_price NUMERIC(14,6) NOT NULL CHECK (low_price >= 0),
    close_price NUMERIC(14,6) NOT NULL CHECK (close_price >= 0),
    volume BIGINT NOT NULL CHECK (volume >= 0),
    CHECK (high_price >= low_price),
    CHECK (high_price >= open_price),
    CHECK (high_price >= close_price),
    CHECK (low_price <= open_price),
    CHECK (low_price <= close_price)
);

-- Import data/cleaned/sony_stock_cleaned.csv using your SQL client's CSV import tool.
-- For the core table, map:
-- Date -> trading_date, Open -> open_price, High -> high_price,
-- Low -> low_price, Close -> close_price, Volume -> volume.
