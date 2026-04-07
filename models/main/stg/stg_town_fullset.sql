SELECT DISTINCT
    lg_code,
    machiaza_id,
    oaza_cho_uncmn_reg,
    oaza_cho_uncmn_mj,
    oaza_cho_uncmn_type,
    oaza_cho_uncmn_code,
    koaza_uncmn_reg,
    koaza_uncmn_mj,
    koaza_uncmn_type,
    koaza_uncmn_code,
    alias_oaza,
    alias_oaza_kana,
    alias_oaza_roma,
    alias_koaza,
    alias_koaza_kana,
    alias_koaza_roma
FROM {{ ref('raw_mt_town_fullset') }}
WHERE lg_code IS NOT NULL
