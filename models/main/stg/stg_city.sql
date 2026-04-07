SELECT
    lg_code,
    LEFT(lg_code, 5) AS lg_code_5,
    LEFT(lg_code, 2) AS pref_code,
    pref AS pref_name,
    pref_kana AS pref_name_kana,
    county AS county_name,
    city AS city_name,
    city_kana AS city_name_kana,
    ward AS ward_name,
    ward_kana AS ward_name_kana,
    ward IS NOT NULL AS is_designated_city_ward,
    efct_date
FROM {{ ref('raw_mt_city') }}
WHERE lg_code IS NOT NULL
