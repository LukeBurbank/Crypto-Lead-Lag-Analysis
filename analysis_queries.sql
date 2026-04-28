
---- Isolate Eth first

SELECT date,
       daily_return AS eth_return
FROM crypto_returns
WHERE coin = 'ETH'
  AND daily_return IS NOT NULL;


----Join eth with other coins

SELECT 
    e.date,
    e.daily_return AS eth_return,
    c.coin,
    c.daily_return AS coin_return
FROM crypto_returns e
JOIN crypto_returns c
    ON e.date = c.date
WHERE e.coin = 'ETH'
  AND c.coin != 'ETH'
  AND e.daily_return IS NOT NULL
  AND e.daily_return != ''
  AND c.daily_return IS NOT NULL
  AND c.daily_return != '';

---- Eth Green vs Red averages 

SELECT 
    c.coin,
    CASE 
        WHEN e.daily_return > 0 THEN 'Green'
        ELSE 'Red'
    END AS eth_direction,
    AVG(c.daily_return) AS avg_coin_return
FROM crypto_returns e
JOIN crypto_returns c
    ON e.date = c.date
WHERE e.coin = 'ETH'
  AND c.coin != 'ETH'
  AND e.daily_return IS NOT NULL
  AND e.daily_return != ''
  AND c.daily_return IS NOT NULL
  AND c.daily_return != ''
GROUP BY c.coin, eth_direction;

---- Same thing just rounded
SELECT 
    c.coin,
    CASE 
        WHEN e.daily_return > 0 THEN 'Green'
        ELSE 'Red'
    END AS eth_direction,
    ROUND(AVG(CAST(c.daily_return AS REAL)), 6) AS avg_coin_return
FROM crypto_returns e
JOIN crypto_returns c
    ON e.date = c.date
WHERE e.coin = 'ETH'
  AND c.coin != 'ETH'
  AND e.daily_return IS NOT NULL
  AND e.daily_return != ''
  AND c.daily_return IS NOT NULL
  AND c.daily_return != ''
GROUP BY c.coin, eth_direction
ORDER BY c.coin, eth_direction;

----Big move SQL version  

SELECT 
    c.coin,
    CASE
        WHEN e.daily_return > 0.02 THEN 'Big Green'
        WHEN e.daily_return < -0.02 THEN 'Big Red'
        ELSE 'Normal'
    END AS eth_move_bucket,
    ROUND(AVG(CAST(c.daily_return AS REAL)), 6) AS avg_coin_return
FROM crypto_returns e
JOIN crypto_returns c
    ON e.date = c.date
WHERE e.coin = 'ETH'
  AND c.coin != 'ETH'
  AND e.daily_return IS NOT NULL
  AND e.daily_return != ''
  AND c.daily_return IS NOT NULL
  AND c.daily_return != ''
GROUP BY c.coin, eth_move_bucket
ORDER BY c.coin, eth_move_bucket;

-----------------------------------------------------------------------------------------
---Next-Day Effect  
SELECT 
    e.date AS today,
    c.coin,
    CAST(e.daily_return AS REAL) AS eth_today,
    LEAD(CAST(c.daily_return AS REAL)) OVER (
        PARTITION BY c.coin
        ORDER BY 
            printf(
                '%04d-%02d-%02d',
                CAST(substr(substr(c.date, instr(c.date, '/') + 1),
                            instr(substr(c.date, instr(c.date, '/') + 1), '/') + 1) AS INT),
                CAST(substr(c.date, 1, instr(c.date, '/') - 1) AS INT),
                CAST(substr(substr(c.date, instr(c.date, '/') + 1), 1,
                instr(substr(c.date, instr(c.date, '/') + 1), '/') - 1) AS INT))) AS coin_next_day
FROM crypto_returns e
JOIN crypto_returns c
    ON e.date = c.date
WHERE e.coin = 'ETH'
  AND c.coin != 'ETH'
  AND e.daily_return IS NOT NULL
  AND e.daily_return != ''
  AND c.daily_return IS NOT NULL
  AND c.daily_return != '';

-----------------------------------------------------------------------------------------
---Grouped Next-day Averages  
SELECT 
    coin,
    CASE 
        WHEN eth_today > 0 THEN 'Green'
        ELSE 'Red'
    END AS eth_direction,
    ROUND(AVG(coin_next_day), 6) AS avg_next_day_return
FROM (
    SELECT 
        e.date,
        c.coin,
        CAST(e.daily_return AS REAL) AS eth_today,
        LEAD(CAST(c.daily_return AS REAL)) OVER (
            PARTITION BY c.coin
            ORDER BY 
                printf(
                    '%04d-%02d-%02d',
                    CAST(substr(substr(c.date, instr(c.date, '/') + 1),
                                instr(substr(c.date, instr(c.date, '/') + 1), '/') + 1) AS INT),
                    CAST(substr(c.date, 1, instr(c.date, '/') - 1) AS INT),
                    CAST(substr(substr(c.date, instr(c.date, '/') + 1), 1,
                                instr(substr(c.date, instr(c.date, '/') + 1), '/') - 1) AS INT))) AS coin_next_day
    FROM crypto_returns e
    JOIN crypto_returns c
        ON e.date = c.date
    WHERE e.coin = 'ETH'
      AND c.coin != 'ETH'
      AND e.daily_return IS NOT NULL
      AND e.daily_return != ''
      AND c.daily_return IS NOT NULL
      AND c.daily_return != '') t
WHERE coin_next_day IS NOT NULL
GROUP BY coin, eth_direction
ORDER BY coin, eth_direction;

-----------------------------------------------------------------------------------------
---Next day strongest postive responcese
SELECT *
FROM (
    SELECT 
        coin,
        CASE 
            WHEN eth_today > 0 THEN 'Green'
            ELSE 'Red'
        END AS eth_direction,
        ROUND(AVG(coin_next_day), 6) AS avg_next_day_return
    FROM (
        SELECT 
            e.date,
            c.coin,
            CAST(e.daily_return AS REAL) AS eth_today,
            LEAD(CAST(c.daily_return AS REAL)) OVER (
                PARTITION BY c.coin
                ORDER BY 
                    printf(
                        '%04d-%02d-%02d',
                        CAST(substr(substr(c.date, instr(c.date, '/') + 1),
                         instr(substr(c.date, instr(c.date, '/') + 1), '/') + 1) AS INT),
                        CAST(substr(c.date, 1, instr(c.date, '/') - 1) AS INT),
                        CAST(substr(substr(c.date, instr(c.date, '/') + 1), 1,
                        instr(substr(c.date, instr(c.date, '/') + 1), '/') - 1) AS INT))) AS coin_next_day
        FROM crypto_returns e
        JOIN crypto_returns c
            ON e.date = c.date
        WHERE e.coin = 'ETH'
          AND c.coin != 'ETH'
          AND e.daily_return IS NOT NULL
          AND e.daily_return != ''
          AND c.daily_return IS NOT NULL
          AND c.daily_return != '') t
    WHERE coin_next_day IS NOT NULL
    GROUP BY coin, eth_direction) x
WHERE eth_direction = 'Green'
ORDER BY avg_next_day_return DESC;

----- Count obersavtions 
SELECT 
    coin,
    COUNT(*) AS observations
FROM (
    SELECT 
        c.coin,
        LEAD(CAST(c.daily_return AS REAL)) OVER (
            PARTITION BY c.coin
            ORDER BY 
                printf(
                    '%04d-%02d-%02d',
                    CAST(substr(substr(c.date, instr(c.date, '/') + 1),
                                instr(substr(c.date, instr(c.date, '/') + 1), '/') + 1) AS INT),
                    CAST(substr(c.date, 1, instr(c.date, '/') - 1) AS INT),
                    CAST(substr(substr(c.date, instr(c.date, '/') + 1), 1,
                   instr(substr(c.date, instr(c.date, '/') + 1), '/') - 1) AS INT))) AS coin_next_day,
CAST(e.daily_return AS REAL) AS eth_today
    FROM crypto_returns e
    JOIN crypto_returns c
        ON e.date = c.date
    WHERE e.coin = 'ETH'
      AND c.coin = 'Shuffle'
      AND e.daily_return > 0
      AND e.daily_return IS NOT NULL
      AND e.daily_return != ''
      AND c.daily_return IS NOT NULL
      AND c.daily_return != '') t
WHERE coin_next_day IS NOT NULL
GROUP BY coin;

-----Rank coins By responsiveness "Which coins move the most when the market moves"
SELECT 
    c.coin,
    ROUND(AVG(ABS(CAST(c.daily_return AS REAL))), 6) AS avg_volatility
FROM crypto_returns c
WHERE c.coin != 'ETH'
  AND c.daily_return IS NOT NULL
  AND c.daily_return != ''
GROUP BY c.coin
ORDER BY avg_volatility DESC;


---- Corrleation  
SELECT 
    c.coin,
    ROUND(
        (AVG(CAST(e.daily_return AS REAL) * CAST(c.daily_return AS REAL))
        - AVG(CAST(e.daily_return AS REAL)) * AVG(CAST(c.daily_return AS REAL)))
        /
        (SQRT(AVG(CAST(e.daily_return AS REAL) * CAST(e.daily_return AS REAL))
         - AVG(CAST(e.daily_return AS REAL)) * AVG(CAST(e.daily_return AS REAL)))
            *
            SQRT(AVG(CAST(c.daily_return AS REAL) * CAST(c.daily_return AS REAL))
         - AVG(CAST(c.daily_return AS REAL)) * AVG(CAST(c.daily_return AS REAL)))),4) AS correlation_with_eth
FROM crypto_returns e
JOIN crypto_returns c
    ON e.date = c.date
WHERE e.coin = 'ETH'
  AND c.coin != 'ETH'
  AND e.daily_return IS NOT NULL
  AND e.daily_return != ''
  AND c.daily_return IS NOT NULL
  AND c.daily_return != ''
GROUP BY c.coin
ORDER BY correlation_with_eth DESC;

