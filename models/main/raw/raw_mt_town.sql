{# デジタル庁 アドレス・ベース・レジストリ 町字マスタ
   https://dataset.address-br.digital.go.jp/documents/b80e77a0e2d24e5692be4af885eb3de7/about #}

{{ config(materialized='table') }}

select *
from read_csv(
    'data/mt_town_all.csv',
    header=true,
    columns={
        'lg_code': 'VARCHAR',
        'machiaza_id': 'VARCHAR',
        'machiaza_type': 'VARCHAR',
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
        'oaza_cho': 'VARCHAR',
        'oaza_cho_kana': 'VARCHAR',
        'oaza_cho_roma': 'VARCHAR',
        'chome': 'VARCHAR',
        'chome_kana': 'VARCHAR',
        'chome_number': 'VARCHAR',
        'koaza': 'VARCHAR',
        'koaza_kana': 'VARCHAR',
        'koaza_roma': 'VARCHAR',
        'machiaza_dist': 'VARCHAR',
        'rsdt_addr_flg': 'VARCHAR',
        'rsdt_addr_mtd_code': 'VARCHAR',
        'oaza_cho_aka_flg': 'VARCHAR',
        'koaza_aka_code': 'VARCHAR',
        'oaza_cho_gsi_uncmn': 'VARCHAR',
        'koaza_gsi_uncmn': 'VARCHAR',
        'status_flg': 'VARCHAR',
        'wake_num_flg': 'VARCHAR',
        'efct_date': 'DATE',
        'ablt_date': 'DATE',
        'src_code': 'VARCHAR',
        'post_code': 'VARCHAR',
        'remarks': 'VARCHAR'
    }
)
