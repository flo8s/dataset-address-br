SELECT
    lg_code,
    ST_Point(rep_lon, rep_lat) AS geometry
FROM {{ ref('raw_mt_pref_pos') }}
WHERE rep_lon IS NOT NULL AND rep_lat IS NOT NULL
