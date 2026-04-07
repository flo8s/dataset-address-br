{{ config(materialized='table') }}

SELECT
    t.*,
    f.oaza_cho_uncmn_reg,
    f.oaza_cho_uncmn_mj,
    f.oaza_cho_uncmn_type,
    f.oaza_cho_uncmn_code,
    f.koaza_uncmn_reg,
    f.koaza_uncmn_mj,
    f.koaza_uncmn_type,
    f.koaza_uncmn_code,
    f.alias_oaza,
    f.alias_oaza_kana,
    f.alias_oaza_roma,
    f.alias_koaza,
    f.alias_koaza_kana,
    f.alias_koaza_roma
FROM {{ ref('stg_town') }} t
LEFT JOIN {{ ref('stg_town_fullset') }} f
    ON t.lg_code = f.lg_code AND t.machiaza_id = f.machiaza_id
