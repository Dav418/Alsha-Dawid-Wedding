#!/usr/bin/env bash
set -euo pipefail

if command -v fvm >/dev/null 2>&1; then
  FLUTTER="fvm flutter"
else
  FLUTTER="flutter"
fi

if [[ ! -f secrets.json ]]; then
  echo "ERROR: secrets.json not found."
  echo "Copy secrets.json.example to secrets.json and add your Google Maps API key."
  exit 1
fi

exec $FLUTTER run -d chrome --dart-define-from-file=secrets.json "$@"
