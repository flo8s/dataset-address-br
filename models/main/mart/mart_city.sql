{{ config(materialized='table') }}

SELECT
    c.*,
    pos.geometry
FROM {{ ref('stg_city') }} c
LEFT JOIN {{ ref('stg_city_pos') }} pos ON c.lg_code = pos.lg_code
