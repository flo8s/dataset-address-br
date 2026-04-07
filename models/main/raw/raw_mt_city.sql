{# デジタル庁 アドレス・ベース・レジストリ 市区町村マスタ
   https://dataset.address-br.digital.go.jp/documents/5e130d8117c6426fa1f53a5dbf90cb74/about #}

{{
    config(
        materialized='table'
    )
}}

select *
from read_csv(
    'data/mt_city_all.csv',
    header=true,
    columns={
        'lg_code': 'VARCHAR',
        'pref': 'VARCHAR',
        'pref_kana': 'VARCHAR',
        'pref_roma': 'VARCHAR',
        'county': 'VARCHAR',
        'county_kana': 'VARCHAR',
        'county_roma': 'VARCHAR',
        'city': 'VARCHAR',
        'city_kana': 'VARCHAR',
        'city_roma': 'VARCHAR',
        'ward': 'VARCHAR',
        'ward_kana': 'VARCHAR',
        'ward_roma': 'VARCHAR',
        'efct_date': 'DATE',
        'ablt_date': 'DATE',
        'remarks': 'VARCHAR'
    }
)
