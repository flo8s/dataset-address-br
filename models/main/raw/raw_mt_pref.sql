{# デジタル庁 アドレス・ベース・レジストリ 都道府県マスタ
   https://dataset.address-br.digital.go.jp/documents/45bcb60e4dc747b58def5493ab829825/about #}

{{ config(materialized='table') }}

select *
from read_csv(
    'data/mt_pref_all.csv',
    header=true,
    columns={
        'lg_code': 'VARCHAR',
        'pref': 'VARCHAR',
        'pref_kana': 'VARCHAR',
        'pref_roma': 'VARCHAR',
        'efct_date': 'DATE',
        'ablt_date': 'DATE',
        'remarks': 'VARCHAR'
    }
)
