-- Obtaining the heroes and villains with the 5 most common superpowers
-- We will extend the model created for question 3, linking the obtained top 5 superpowers to the unnested list abilities
-- Filter for heroes and villains which are having the five of most common superpowers

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
),
superpowers_top_5 AS (
SELECT 
    superpower, 
    superpower_count
FROM superpower_counts
ORDER BY superpower_count DESC
LIMIT 5
)
SELECT 
    name,
    FROM superpowers_top_5 a
    INNER JOIN unnest_superpowers b ON a.superpower = b.superpower
    GROUP BY b.name
    HAVING COUNT(b.name) = 5
    ORDER BY b.name