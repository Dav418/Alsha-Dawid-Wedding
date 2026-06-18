#!/usr/bin/env python3
"""Merge secrets.json and wedding_content.json into dart_defines.json for Flutter."""

from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SECRETS_PATH = ROOT / "secrets.json"
CONTENT_PATH = ROOT / "wedding_content.json"
OUTPUT_PATH = ROOT / "dart_defines.json"


def main() -> int:
    if not SECRETS_PATH.exists():
        print(
            f"ERROR: {SECRETS_PATH.name} not found. "
            "Copy secrets.json.example to secrets.json.",
            file=sys.stderr,
        )
        return 1

    if not CONTENT_PATH.exists():
        print(
            f"ERROR: {CONTENT_PATH.name} not found. "
            "Copy wedding_content.json.example to wedding_content.json.",
            file=sys.stderr,
        )
        return 1

    secrets = json.loads(SECRETS_PATH.read_text())
    content = json.loads(CONTENT_PATH.read_text())

    defines = {
        "GOOGLE_MAPS_API_KEY": secrets.get("GOOGLE_MAPS_API_KEY", ""),
        "WEDDING_CONTENT_JSON": json.dumps(content, separators=(",", ":")),
    }

    OUTPUT_PATH.write_text(json.dumps(defines, indent=2) + "\n")
    print(f"Wrote {OUTPUT_PATH.name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
