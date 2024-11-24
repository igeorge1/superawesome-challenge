WITH src_hero_abilities AS (
    SELECT 
        CASE 
        WHEN STRPOS(name, ' (') > 0 THEN SUBSTR(name, 1, STRPOS(name, ' (') - 1)
        ELSE name
    END AS name,
     superpowers
    FROM {{ ref('hero-abilities') }}
)
SELECT 
    name, 
    superpowers 
FROM src_hero_abilities
ORDER BY name