#!/usr/bin/env python3
"""Fetch the site title from Strapi for deploy metadata."""

from __future__ import annotations

import json
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CONFIG_PATH = ROOT / "lib" / "config" / "strapi_config.dart"


def strapi_wedding_url() -> str:
    config = CONFIG_PATH.read_text()
    base_match = re.search(r"static const baseUrl =\s*'([^']+)'", config)
    wedding_match = re.search(r"static const wedding =\s*'([^']+)'", config)

    if base_match is None or wedding_match is None:
        raise RuntimeError(
            f"Could not read Strapi wedding URL from {CONFIG_PATH.name}",
        )

    return f"{base_match.group(1).rstrip('/')}{wedding_match.group(1)}"


def fetch_app_title() -> str:
    url = f"{strapi_wedding_url()}?populate=*"
    request = urllib.request.Request(
        url,
        headers={
            "Accept": "application/json",
            "User-Agent": "alisha-dawid-wedding-deploy/1.0",
        },
        method="GET",
    )

    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            payload = json.load(response)
    except urllib.error.URLError as exc:
        raise RuntimeError(f"Failed to fetch wedding title from Strapi: {exc}") from exc

    data = payload.get("data")
    if not isinstance(data, dict):
        raise RuntimeError("No published Wedding entry was found in Strapi.")

    couple = data.get("couple")
    if not isinstance(couple, dict):
        raise RuntimeError("Strapi wedding entry is missing couple data.")

    partner1 = str(couple["partner1Name"]).split()[0]
    partner2 = str(couple["partner2Name"]).split()[0]
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
