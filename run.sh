#!/usr/bin/env bash
set -euo pipefail

if command -v fvm >/dev/null 2>&1; then
  FLUTTER="fvm flutter"
else
  FLUTTER="flutter"
fi

python3 scripts/merge_dart_defines.py

exec $FLUTTER run -d chrome --dart-define-from-file=dart_defines.json "$@"
