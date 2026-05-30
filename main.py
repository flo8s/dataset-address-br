"""アドレス・ベース・レジストリ マスタデータパイプライン。

1. data/ の zip ファイルを展開
2. dbt build
3. snapshot MotherDuck catalog to R2 (same Python process)
"""

from __future__ import annotations

import importlib.util
import logging
import os
import sys
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

SHARED_SCRIPTS = Path(__file__).resolve().parent / "shared" / "scripts"
_spec = importlib.util.spec_from_file_location(
    "snapshot_to_r2", SHARED_SCRIPTS / "snapshot-to-r2.py"
)
assert _spec and _spec.loader
snapshot_to_r2 = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(snapshot_to_r2)


def main() -> None:
    target = os.environ.get("DBT_TARGET", sys.argv[1] if len(sys.argv) > 1 else "default")

    _extract_all()

    dbt = dbtRunner()
    for cmd in (
        ["deps"],
        ["build", "--target", target],
        ["docs", "generate", "--target", target],
    ):
        result = dbt.invoke(cmd)
        if not result.success:
            raise SystemExit(f"dbt {' '.join(cmd)} failed")

    snapshot_to_r2.run(target)


def _extract_all() -> None:
    for filename in ZIPS:
        _extract(filename)


def _extract(filename: str) -> None:
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
