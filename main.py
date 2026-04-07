"""アドレス・ベース・レジストリ マスタデータパイプライン。

1. 各種マスタ CSV をダウンロード・展開
2. dbt ビルド
"""

import logging
import zipfile
from io import BytesIO
from pathlib import Path
from urllib.request import Request, urlopen

from dbt.cli.main import dbtRunner

logger = logging.getLogger("pipelines")

BASE_URL = "https://data.address-br.digital.go.jp"
DATA_DIR = Path("data")

MASTERS = [
    ("mt_pref", "mt_pref_all"),
    ("mt_pref_pos", "mt_pref_pos_all"),
    ("mt_city", "mt_city_all"),
    ("mt_city_pos", "mt_city_pos_all"),
    ("mt_town", "mt_town_all"),
    ("mt_town_fullset", "mt_town_fullset_all"),
]


def main():
    _download_all()

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


def _download_all() -> None:
    """全マスタ CSV をダウンロードして展開する。"""
    DATA_DIR.mkdir(exist_ok=True)

    for name, filename in MASTERS:
        _download(name, filename)


def _download(name: str, filename: str) -> None:
    """単一マスタ CSV をダウンロードして展開する。既存ならスキップ。"""
    csv_path = DATA_DIR / f"{filename}.csv"
    if csv_path.exists():
        logger.info(f"  skip (already exists: {csv_path})")
        return

    url = f"{BASE_URL}/{name}/{filename}.csv.zip"
    logger.info(f"  downloading {filename}.csv.zip...")
    req = Request(url, headers={"User-Agent": "dataset-address-br"})
    with urlopen(req) as resp:
        data = resp.read()

    with zipfile.ZipFile(BytesIO(data)) as zf:
        zf.extract(f"{filename}.csv", DATA_DIR)

    lines = csv_path.read_text(encoding="utf-8").strip().splitlines()
    print(f"  {filename}.csv: {len(lines) - 1} records downloaded")


if __name__ == "__main__":
    main()
