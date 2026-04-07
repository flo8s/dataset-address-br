{{ config(materialized='table') }}

SELECT
    p.*,
    pos.geometry
FROM {{ ref('stg_pref') }} p
LEFT JOIN {{ ref('stg_pref_pos') }} pos ON p.lg_code = pos.lg_code
