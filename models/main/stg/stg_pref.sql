SELECT
    lg_code,
    LEFT(lg_code, 2) AS pref_code,
    pref AS pref_name,
    pref_kana AS pref_name_kana,
    efct_date
FROM {{ ref('raw_mt_pref') }}
WHERE lg_code IS NOT NULL
