WITH src_comic_characters_info AS (
    SELECT 
        name, 
        alignment, 
        publisher,
        ROW_NUMBER() OVER (PARTITION BY name, alignment, publisher) AS row_num
    FROM {{ ref('comic_characters_info') }}
)
SELECT 
    name, 
    alignment, 
    publisher
FROM src_comic_characters_info
WHERE row_num = 1
ORDER BY name