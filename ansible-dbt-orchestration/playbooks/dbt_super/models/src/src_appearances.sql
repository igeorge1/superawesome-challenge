WITH src_appearances AS (
    SELECT 
       publisher, name, appearances FROM {{ ref('src_dc_data') }}
       UNION ALL
    SELECT publisher, name, appearances FROM {{ ref('src_marvel_data') }}
)
SELECT 
    name,
    appearances,
    publisher
FROM src_appearances
ORDER BY name