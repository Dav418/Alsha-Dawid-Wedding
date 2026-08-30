#!/usr/bin/env python3
"""Fetch the site title from Hygraph for deploy metadata."""

from __future__ import annotations

import json
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CONFIG_PATH = ROOT / "lib" / "config" / "hygraph_config.dart"

TITLE_QUERY = """
query WeddingTitle {
  weddings(first: 1) {
    couple {
      partner1Name
      partner2Name
    }
  }
}
"""


def hygraph_endpoint() -> str:
    config = CONFIG_PATH.read_text()
    match = re.search(r"static const endpoint =\s*'([^']+)'", config)
    if match is None:
        raise RuntimeError(
            f"Could not read Hygraph endpoint from {CONFIG_PATH.name}",
        )
    return match.group(1)


def fetch_app_title() -> str:
    request = urllib.request.Request(
        hygraph_endpoint(),
        data=json.dumps({"query": TITLE_QUERY}).encode("utf-8"),
        headers={"Content-Type": "application/json"},
        method="POST",
    )

    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            payload = json.load(response)
    except urllib.error.URLError as exc:
        raise RuntimeError(f"Failed to fetch wedding title from Hygraph: {exc}") from exc

    errors = payload.get("errors")
    if errors:
        raise RuntimeError(f"Hygraph returned GraphQL errors: {json.dumps(errors)}")

    weddings = (payload.get("data") or {}).get("weddings") or []
    if not weddings:
        raise RuntimeError("No published Wedding entry was found in Hygraph.")

    couple = weddings[0]["couple"]
    partner1 = couple["partner1Name"].split()[0]
    partner2 = couple["partner2Name"].split()[0]
    return f"{partner1} & {partner2} Wedding"


def main() -> int:
    try:
        print(fetch_app_title())
    except Exception as exc:  # noqa: BLE001 - CLI boundary
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
