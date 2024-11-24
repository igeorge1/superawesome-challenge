WITH src_dc_data AS (
    SELECT 
        CASE 
        WHEN STRPOS(name, ' (') > 0 THEN SUBSTR(name, 1, STRPOS(name, ' (') - 1)
        ELSE name
    END AS name,
        COALESCE(SUM(appearances),0) AS appearances,
        'DC Comics' as publisher
    FROM {{ ref('dc-data') }}
    GROUP BY name, publisher
)
SELECT 
    name,
    appearances,
    publisher
FROM src_dc_data
ORDER BY name