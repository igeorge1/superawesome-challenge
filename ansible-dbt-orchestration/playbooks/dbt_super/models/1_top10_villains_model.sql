-- Obtaining top 10 villains by appearance per publisher
-- Joining the cleaned data sources for 'characters info' and 'appearances' obtained based on 'dc data' and 'marvel data'
-- Filtering by alignment and obtaining the top 10

WITH ranked_villains AS (
    SELECT 
        a.publisher,
        a.name,
        SUM(b.appearances) appearances,
        ROW_NUMBER() OVER (PARTITION BY a.publisher ORDER BY SUM(b.appearances) DESC) AS rank
    FROM {{ ref('src_comic_characters_info') }} a 
    INNER JOIN {{ ref('src_appearances') }} b 
        ON LOWER(a.name) = LOWER(b.name) 
        AND a.publisher = b.publisher
    WHERE a.alignment = 'bad'
    GROUP by a.publisher, a.name
)
SELECT 
    publisher,
    name,
    appearances
FROM ranked_villains
WHERE rank <= 10
ORDER BY publisher, rank