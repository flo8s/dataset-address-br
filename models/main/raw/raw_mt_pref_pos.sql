{# デジタル庁 アドレス・ベース・レジストリ 都道府県マスタ位置参照拡張
   https://dataset.address-br.digital.go.jp/documents/535e5c01f4af4f5bba72618472f07db9/about #}

{{ config(materialized='table') }}

select *
from read_csv(
    'data/mt_pref_pos_all.csv',
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
