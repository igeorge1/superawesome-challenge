WITH src_marvel_data AS (
    SELECT 
        CASE 
        WHEN STRPOS(name, ' (') > 0 THEN SUBSTR(name, 1, STRPOS(name, ' (') - 1)
        ELSE name
    END AS name,
        COALESCE(SUM(appearances),0) AS appearances,
        'Marvel Comics' as publisher
    FROM {{ ref('marvel-data') }}
    GROUP BY name, publisher
)
SELECT 
    name,
    appearances,
    publisher
FROM src_marvel_data
ORDER BY name