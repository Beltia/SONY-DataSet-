# SONY-DataSet-
[README.md](https://github.com/user-attachments/files/31965139/README.md)
# Sony Group Corporation Stock Analytics (2014–2026)

## Project Overview

This project analyses historical daily stock data for **Sony Group Corporation (SONY)** from **2 January 2014 to 24 August 2026**. The project combines **Microsoft Excel and SQL** to explore price performance, trading activity, volatility and historical investment characteristics.

The project is designed as a portfolio demonstration of practical financial data analytics, data cleaning, database design, SQL querying and Excel visualisation.

> **Disclaimer:** This is an educational data-analysis project. Historical market performance does not guarantee future results and the analysis is not personalised financial advice.

## Why I Chose Sony

Sony was selected because it is a globally recognised company with a long history of publicly traded market data. The dataset provides more than a decade of daily observations, making it suitable for time-series analysis rather than a simple snapshot analysis.

The dataset also creates an opportunity to demonstrate technical skills using a realistic financial dataset. Daily open, high, low, close and volume data can be transformed into measures such as daily returns, price ranges, moving averages and rolling volatility. This makes the project relevant to Information Systems, data analytics and fintech-oriented work.

## Research Question

**What can historical Sony stock data reveal about price performance, volatility, trading activity and historical investment characteristics?**

### Supporting questions

- How has Sony's closing price changed over time?
- Which years experienced the strongest and weakest historical price performance?
- How has trading volume changed?
- Which periods show unusually high volatility?
- How do short- and long-term moving averages describe historical trends?
- What were the largest historical price movements and drawdowns?
- What limitations should be considered when using historical stock data?

## Dataset

Source: Kaggle — **Sony Group Corporation Stock Data (2014–2026)**.

The supplied dataset contains 3,179 daily observations and six fields:

| Field | Description |
|---|---|
| Date | Trading date |
| Open | Opening stock price |
| High | Highest price during the session |
| Low | Lowest price during the session |
| Close | Closing stock price |
| Volume | Shares traded during the session |

The supplied file was checked for missing values and duplicate trading dates. No missing values or duplicate dates were found in the supplied 3,179-row dataset.

## Data Preparation

The cleaned dataset adds analytical fields including:

- Previous closing price
- Daily price change
- Daily return
- Intraday range
- Intraday range percentage
- 7-, 30-, 50- and 200-day simple moving averages
- 30-day rolling volatility
- Year
- Month
- Quarter
- Day of week

Legitimate market outliers should be investigated rather than automatically deleted because extreme price movements can represent genuine market events.

## Excel Analysis

The Excel workbook contains:

- `Raw_Data` — original supplied observations
- `Clean_Data` — transformed analytical dataset
- `Calculations` — key project metrics
- `Monthly_Analysis` — monthly aggregation
- `Yearly_Analysis` — annual aggregation
- `Dashboard` — KPI and chart layout

The dashboard focuses on closing price, trading volume and key descriptive statistics.

## SQL Analysis

The SQL scripts demonstrate:

- Relational table design
- Constraints
- Data-quality checks
- Aggregation
- `GROUP BY`
- `HAVING`
- `CASE`
- CTEs
- `LAG()`
- Window functions
- Moving averages
- Rolling volatility
- Ranking
- Drawdown analysis

The scripts are written for **PostgreSQL**.

## Initial Descriptive Findings

Based on the supplied dataset:

- **3,179** trading-day observations are available.
- The dataset runs from **2 January 2014 to 24 August 2026**.
- The first recorded closing price is approximately **3.20**.
- The latest recorded closing price is approximately **24.26**.
- The highest recorded closing price is approximately **30.26**.
- The lowest recorded closing price is approximately **2.85**.
- Average daily trading volume is approximately **5.85 million shares**.

The price figures should be interpreted in the context of the dataset's underlying market-data methodology and price adjustments.

## Skills Demonstrated

**Technical**
- SQL
- PostgreSQL
- Microsoft Excel
- Data cleaning
- Data transformation
- Database design
- Window functions
- Time-series analysis
- Financial calculations
- Data visualisation

**Analytical**
- Trend analysis
- Volatility analysis
- Return analysis
- Trading-volume analysis
- Drawdown analysis
- Business question formulation
- Interpretation of financial data

## Limitations

This project analyses historical observations only. It does not include all factors that can influence a stock's future performance, such as company fundamentals, dividends, exchange rates, interest rates, market indexes, news, macroeconomic conditions or investor sentiment.

The dataset also ends on 24 August 2026, so the analysis should not be interpreted as a live market-monitoring system.

## Conclusion

This project demonstrates how a real-world financial dataset can be transformed into a structured analytical workflow. Excel provides an accessible environment for cleaning, calculations and visualisation, while SQL provides a scalable method for storing, querying and analysing the same data.

The main value of the project is not predicting Sony's future stock price, but demonstrating how structured data can be used to answer meaningful financial and business questions.
