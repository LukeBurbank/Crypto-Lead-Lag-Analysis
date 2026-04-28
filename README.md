# Crypto Lead-Lag Analysis: ETH Influence on Altcoin Behavior
![Crypto Dashboard](images/crypto-dashboard.png)
Built an end-to-end crypto market analysis project using Excel, SQL, and Tableau to analyze how ETH price movements influence same-day and next-day altcoin behavior.

## Project Overview

This project analyzes how Ethereum (ETH) price movements influence altcoin behavior across both same-day and next-day timeframes.

The project began in Excel using AAVE as a single test asset before expanding into a full SQL-based analysis across multiple altcoins. Final insights and visualizations were built in Tableau to identify patterns in correlation, volatility, and spillover effects from ETH price movements.

The analysis focused on:
- Same-day altcoin reactions during ETH green vs red days
- Altcoin performance during large ETH price swings
- Next-day spillover effects after ETH moves
- Correlation strength between ETH and altcoins
- Relative volatility across major altcoins

## Business Problem

Crypto markets are highly interconnected, but not all altcoins react to Ethereum movements in the same way.

The goal of this project was to determine:

- Which altcoins move most closely with ETH
- How altcoins react during strong ETH price movements
- Whether ETH movements create measurable next-day spillover effects
- Which altcoins exhibit the highest volatility
- How consistently altcoins respond during ETH green and red days

Understanding these relationships can help traders and analysts better evaluate market behavior, correlation risk, and short-term momentum across crypto assets.

## Tools Used

- **Excel** — Initial exploratory analysis using AAVE as a single test asset
- **SQL** — Scaled the analysis across multiple altcoins and calculated correlations, volatility metrics, and spillover effects
- **Tableau** — Built an interactive dashboard to visualize ETH influence on altcoin behavior
- **GitHub** — Documented and presented the full project workflow and findings

## Dataset & Methodology

The dataset consisted of daily return data for Ethereum (ETH) and multiple altcoins from 2025 onward, totaling over 5,000 rows of market data. Assets analyzed included cryptocurrencies such as Chainlink, AAVE, Render, ONDO, Injective, and several others.

The project originally began in Excel using AAVE as a single test case before expanding into a larger SQL-based dataset that allowed analysis across multiple cryptocurrencies simultaneously.

Key calculations and transformations included:

- Daily return calculations for ETH and altcoins
- Classification of ETH green vs red trading days
- Identification of large ETH move periods (greater than ±2%)
- Next-day spillover analysis using lagged return comparisons
- Correlation analysis between ETH and altcoin returns
- Average daily volatility calculations using absolute returns

SQL queries were used to aggregate and analyze the data before exporting the results into Tableau for visualization and dashboard development.

## Analysis & Findings

### 1. Same-Day ETH Influence on Altcoins

The analysis showed that most altcoins moved in the same direction as ETH during the same trading day. Positive ETH days were generally associated with positive average altcoin returns, while negative ETH days often produced broad declines across the altcoin market.

### 2. Impact of Large ETH Price Movements

When ETH experienced large price swings greater than ±2%, many altcoins showed amplified reactions. Several assets demonstrated significantly stronger volatility during these periods, suggesting that major ETH movements can strongly influence short-term altcoin behavior.

### 3. Next-Day Spillover Effects

Next-day spillover effects after ETH green and red days appeared weak and inconsistent across most assets. While a few coins showed small positive continuation effects, the majority of next-day reactions clustered near zero, suggesting limited predictive power from ETH’s prior-day direction alone.

### 4. Correlation Analysis

Correlation analysis revealed that some altcoins tracked ETH much more closely than others. Chainlink demonstrated the strongest relationship with ETH price movements, while other assets displayed weaker correlations and more independent behavior.

### 5. Volatility Analysis

Volatility analysis showed major differences in average daily movement size across altcoins. Render exhibited the highest average daily volatility in the dataset, indicating larger average price swings compared to other analyzed assets.

## Conclusion

This project evolved from a small Excel-based experiment using AAVE into a larger SQL and Tableau analysis of how Ethereum influences altcoin behavior across multiple market conditions.

The analysis revealed strong same-day relationships between ETH and many altcoins, particularly during periods of high volatility. However, next-day spillover effects appeared limited, suggesting that ETH direction alone may not provide strong predictive power for future altcoin returns.

By combining Excel, SQL, and Tableau, this project demonstrates an end-to-end analytical workflow involving data transformation, statistical analysis, and dashboard visualization within a cryptocurrency market context.

## Interactive Dashboard

View the full interactive Tableau dashboard here:

[View Tableau Dashboard](https://public.tableau.com/app/profile/luke.burbank1441/viz/CryptoLead-LagAnalysisETHInfluenceonAltcoinBehavior/Dashboard1)
