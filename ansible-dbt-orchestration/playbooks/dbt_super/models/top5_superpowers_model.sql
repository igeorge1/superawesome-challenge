-- Obtaining the 5 most common superpowers
-- In first part normalizing the superpowers using TRIM, REPLACE and then UNEST to convert the array into individual rows
-- Further count, sort and select the top 5

WITH cleaned_superpowers AS (
    SELECT 
        name, 
        TRIM(REPLACE(REPLACE(REPLACE(superpowers, '[', ''), ']', ''), '''', '')) AS superpowers
    FROM {{ ref('src_hero_abilities') }}
), 
unnest_superpowers AS (
    SELECT 
        name, 
        TRIM(UNNEST(SPLIT(superpowers, ','))) AS superpower
    FROM cleaned_superpowers
), 
superpower_counts AS (
    SELECT 
        superpower, 
        COUNT(*) AS superpower_count
    FROM unnest_superpowers
    GROUP BY superpower
)
SELECT 
    superpower, 
    superpower_count
FROM superpower_counts
ORDER BY superpower_count DESC
LIMIT 5
