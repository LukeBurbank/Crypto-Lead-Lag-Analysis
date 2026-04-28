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


