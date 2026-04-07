"""アドレス・ベース・レジストリ マスタデータパイプライン。

1. data/ の zip ファイルを展開
2. dbt ビルド

データ更新手順:
  ABR サイト (https://dataset.address-br.digital.go.jp/) から最新の zip をダウンロードし、
  data/ に配置してコミットする。git 履歴でデータバージョンを追跡できる。
"""

import logging
import zipfile
from pathlib import Path

from dbt.cli.main import dbtRunner

logger = logging.getLogger("pipelines")

DATA_DIR = Path("data")

ZIPS = [
    "mt_pref_all",
    "mt_pref_pos_all",
    "mt_city_all",
    "mt_city_pos_all",
    "mt_town_all",
    "mt_town_fullset_all",
]


def main():
    _extract_all()

    dbt = dbtRunner()

    result = dbt.invoke(["deps"])
    if not result.success:
        raise SystemExit("dbt deps failed")

    result = dbt.invoke(["run"])
    if not result.success:
        raise SystemExit("dbt run failed")

    result = dbt.invoke(["docs", "generate"])
    if not result.success:
        raise SystemExit("dbt docs generate failed")


def _extract_all() -> None:
    """data/ 内の zip ファイルを CSV に展開する。"""
    for filename in ZIPS:
        _extract(filename)


def _extract(filename: str) -> None:
    """zip を展開する。CSV が既に存在すればスキップ。"""
    csv_path = DATA_DIR / f"{filename}.csv"
    zip_path = DATA_DIR / f"{filename}.csv.zip"

    if csv_path.exists():
        logger.info(f"  skip (already exists: {csv_path})")
        return

    if not zip_path.exists():
        raise FileNotFoundError(f"{zip_path} not found. Download from ABR site.")

    logger.info(f"  extracting {zip_path.name}...")
    with zipfile.ZipFile(zip_path) as zf:
        zf.extract(f"{filename}.csv", DATA_DIR)


if __name__ == "__main__":
    main()
