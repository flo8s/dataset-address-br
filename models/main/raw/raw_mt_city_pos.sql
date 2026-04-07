{# デジタル庁 アドレス・ベース・レジストリ 市区町村マスタ位置参照拡張
   https://dataset.address-br.digital.go.jp/documents/7108b74d9fad4e79997538ec40aa8015/about #}

{{ config(materialized='table') }}

select *
from read_csv(
    'data/mt_city_pos_all.csv',
    header=true,
    columns={
        'lg_code': 'VARCHAR',
        'rep_lon': 'DOUBLE',
        'rep_lat': 'DOUBLE',
        'rep_srid': 'VARCHAR',
        'rep_scale': 'VARCHAR',
        'plygn_fname': 'VARCHAR',
        'plygn_kcode': 'VARCHAR',
        'plygn_fmt': 'VARCHAR',
        'plygn_srid': 'VARCHAR',
        'plygn_scale': 'VARCHAR'
    }
)
