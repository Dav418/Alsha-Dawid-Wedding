#!/usr/bin/env bash
set -euo pipefail

PAGES_BRANCH="main"
CUSTOM_DOMAIN="alisha-dawid-wedding.vip"
SITE_URL="https://${CUSTOM_DOMAIN}/"
FAVICON_SOURCE="lib/assets/home/monogram_ad_wreath.png"
FAVICON_SIZE=48
SECRETS_PATH="secrets.json"

if command -v fvm >/dev/null 2>&1; then
  FLUTTER="fvm flutter"
  DART="fvm dart"
else
  FLUTTER="flutter"
  DART="dart"
fi

run_cmd() {
  local message="$1"
  shift
  echo ""
  echo "==> ${message}"
  echo "$*"
  "$@"
}

html_escape() {
  python3 -c 'import html, sys; print(html.escape(sys.argv[1], quote=False))' "$1"
}

get_app_title() {
  python3 scripts/fetch_app_title.py
}

remove_path_strict() {
  local path="$1"
  [[ -e "$path" ]] || return 0
  rm -rf "$path"
  if [[ -e "$path" ]]; then
    echo ""
    echo "ERROR: Failed to remove ${path}"
    exit 1
  fi
}

regenerate_web_folder() {
  local temp_dir
  temp_dir="$(mktemp -d "${TMPDIR:-/tmp}/flutter_web_template_XXXXXXX")"
  trap 'rm -rf "$temp_dir"' RETURN

  run_cmd "Generating fresh Flutter web folder in temp directory" \
    $FLUTTER create --platforms=web --project-name alisha_dawid_wedding_website --no-pub "$temp_dir"

  if [[ ! -f "${temp_dir}/web/index.html" ]]; then
    echo ""
    echo "ERROR: temporary web/index.html was not generated."
    exit 1
  fi

  echo ""
  echo "==> Replacing repo web folder with regenerated web folder"
  remove_path_strict "web"
  mkdir -p web
  cp -R "${temp_dir}/web/." web/
}

update_web_index_metadata() {
  local app_title="$1"
  local html_title
  html_title="$(html_escape "$app_title")"
  local index_path="web/index.html"

  python3 - "$index_path" "$html_title" <<'PY'
import re
import sys
from pathlib import Path

index_path, html_title = sys.argv[1:3]
html = Path(index_path).read_text()

html = re.sub(
    r'<meta name="description" content=".*?">',
    f'<meta name="description" content={html_title}>',
    html,
    count=1,
)
html = re.sub(
    r"<title>.*?</title>",
    f"<title>{html_title}</title>",
    html,
    count=1,
)

maps_comment = """
  <!--
    Google Maps is loaded from Dart when GOOGLE_MAPS_API_KEY is passed at
    build/run time (--dart-define-from-file=secrets.json). Do not add a
    hard-coded key here — deploy scripts regenerate this file from scratch.
  -->
"""

if "GOOGLE_MAPS_API_KEY" not in html:
    html = html.replace("</head>", f"{maps_comment}</head>", 1)

Path(index_path).write_text(html)
PY
}

update_web_manifest_metadata() {
  local app_title="$1"
  local manifest_path="web/manifest.json"
  [[ -f "$manifest_path" ]] || return 0

  python3 - "$manifest_path" "$app_title" <<'PY'
import json
import sys
from pathlib import Path

path, app_title = sys.argv[1:3]
manifest_path = Path(path)
manifest = json.loads(manifest_path.read_text())
manifest["name"] = app_title
manifest["short_name"] = "Wedding"
manifest_path.write_text(json.dumps(manifest, indent=2) + "\n")
PY
}

update_web_favicon() {
  local dest_path="web/favicon.png"
  if [[ ! -f "$FAVICON_SOURCE" ]]; then
    echo ""
    echo "ERROR: ${FAVICON_SOURCE} not found."
    exit 1
  fi

  echo ""
  echo "==> Creating favicon from monogram asset"
  sips -z "$FAVICON_SIZE" "$FAVICON_SIZE" "$FAVICON_SOURCE" --out "$dest_path" >/dev/null

  if [[ ! -f "$dest_path" ]]; then
    echo ""
    echo "ERROR: ${dest_path} was not created."
    exit 1
  fi
}

ensure_web404_page() {
  local web_output="$1"
  local index_path="${web_output}/index.html"
  local not_found_path="${web_output}/404.html"

  if [[ ! -f "$index_path" ]]; then
    echo ""
    echo "ERROR: ${index_path} not found."
    exit 1
  fi

  echo ""
  echo "==> Creating 404.html from built index.html for GitHub Pages deep links"
  cp "$index_path" "$not_found_path"
}

assert_build_config_ready() {
  assert_google_maps_secrets_ready
}

assert_google_maps_secrets_ready() {
  if [[ ! -f "$SECRETS_PATH" ]]; then
    echo ""
    echo "ERROR: ${SECRETS_PATH} not found."
    echo "The Map page embeds Google Maps and needs an API key at build time."
    echo ""
    echo "Setup:"
    echo "  1. Copy secrets.json.example to secrets.json"
    echo "  2. Paste your Google Maps API key (Maps JavaScript API enabled)"
    echo "  3. Restrict the key to HTTP referrers, e.g.:"
    echo "       http://localhost:*"
    echo "       https://${CUSTOM_DOMAIN}/*"
    echo ""
    echo "secrets.json is gitignored and is not committed by this script."
    exit 1
  fi

  local api_key
  api_key="$(python3 - <<'PY'
import json
import sys
from pathlib import Path

try:
    data = json.loads(Path("secrets.json").read_text())
except json.JSONDecodeError as exc:
    print(f"__INVALID_JSON__:{exc}", file=sys.stderr)
    sys.exit(2)

print(data.get("GOOGLE_MAPS_API_KEY", ""))
PY
)" || {
    echo ""
    echo "ERROR: ${SECRETS_PATH} is not valid JSON."
    exit 1
  }

  if [[ -z "${api_key// /}" ]]; then
    echo ""
    echo "ERROR: GOOGLE_MAPS_API_KEY is empty in ${SECRETS_PATH}."
    exit 1
  fi

  case "$api_key" in
    paste-your-key-here|YOUR_GOOGLE_MAPS_API_KEY)
      echo ""
      echo "ERROR: GOOGLE_MAPS_API_KEY in ${SECRETS_PATH} is still a placeholder."
      exit 1
      ;;
  esac

  echo ""
  echo "Google Maps API key found in ${SECRETS_PATH} (key value not printed)."
}

echo ""
echo "Starting Flutter web deploy..."

[[ -f pubspec.yaml ]] || {
  echo "ERROR: pubspec.yaml not found. Run from the Flutter project root."
  exit 1
}

[[ -d .git ]] || {
  echo "ERROR: .git folder not found. Run from the Git repo root."
  exit 1
}

current_branch="$(git branch --show-current)"
if [[ "$current_branch" != "$PAGES_BRANCH" ]]; then
  echo ""
  echo "ERROR: You are on branch '${current_branch}'."
  echo "GitHub Pages is using branch '${PAGES_BRANCH}'."
  echo "Switch branch first with: git checkout ${PAGES_BRANCH}"
  exit 1
fi

APP_TITLE="$(get_app_title)"
HTML_TITLE="$(html_escape "$APP_TITLE")"

echo ""
echo "Using app title: ${APP_TITLE}"

run_cmd "Cleaning Flutter project" $FLUTTER clean

echo ""
echo "==> Making sure old generated folders are removed"
remove_path_strict "build"
remove_path_strict ".dart_tool"
remove_path_strict ".flutter-plugins-dependencies"

regenerate_web_folder

echo ""
echo "==> Updating regenerated web metadata"
update_web_index_metadata "$APP_TITLE"
update_web_manifest_metadata "$APP_TITLE"
update_web_favicon

run_cmd "Getting Flutter packages" $FLUTTER pub get
run_cmd "Running code generation" $DART run build_runner build --delete-conflicting-outputs

assert_build_config_ready

run_cmd "Building Flutter web for custom domain (with Google Maps key)" \
  $FLUTTER build web --release --base-href '/' --dart-define-from-file=secrets.json

[[ -f build/web/index.html ]] || { echo "ERROR: build/web/index.html was not created."; exit 1; }
[[ -f build/web/main.dart.js ]] || { echo "ERROR: build/web/main.dart.js was not created."; exit 1; }
[[ -f build/web/favicon.png ]] || { echo "ERROR: build/web/favicon.png was not created."; exit 1; }

ensure_web404_page "build/web"
[[ -f build/web/404.html ]] || { echo "ERROR: build/web/404.html was not created."; exit 1; }

if ! grep -q "<title>${HTML_TITLE}</title>" build/web/index.html; then
  echo ""
  echo "ERROR: build/web/index.html has the wrong browser tab title."
  echo "Expected: <title>${HTML_TITLE}</title>"
  exit 1
fi

echo ""
echo "==> Replacing docs folder"
remove_path_strict "docs"
mkdir -p docs

echo ""
echo "==> Copying build/web into docs"
cp -R build/web/. docs/

echo ""
echo "==> Adding .nojekyll"
: > docs/.nojekyll

echo ""
echo "==> Adding CNAME for custom domain"
printf '%s' "$CUSTOM_DOMAIN" > docs/CNAME

[[ -f docs/index.html ]] || { echo "ERROR: docs/index.html is missing after copy."; exit 1; }
[[ -f docs/main.dart.js ]] || { echo "ERROR: docs/main.dart.js is missing after copy."; exit 1; }
[[ -f docs/404.html ]] || { echo "ERROR: docs/404.html is missing after copy."; exit 1; }
[[ -f docs/CNAME ]] || { echo "ERROR: docs/CNAME is missing after copy."; exit 1; }

if ! grep -q "<title>${HTML_TITLE}</title>" docs/index.html; then
  echo ""
  echo "ERROR: docs/index.html has the wrong browser tab title after copy."
  exit 1
fi

echo ""
echo "==> Adding web and docs folders to Git"
git add -A web docs
git add -f web docs

echo ""
echo "==> Git status for web and docs"
git status --short web docs

if [[ -z "$(git status --porcelain web docs)" ]]; then
  echo ""
  echo "No web/docs changes to deploy."
  echo "Your site may already be up to date."
  exit 0
fi

echo ""
echo "==> Committing deploy files"
git commit -m "DEPLOY regenerated Flutter web app for custom domain"

echo ""
echo "==> Pushing to GitHub"
git push origin "$PAGES_BRANCH"

echo ""
echo "Deploy pushed successfully."
echo "Open:"
echo "$SITE_URL"
echo ""
echo "Hard refresh with Cmd + Shift + R if your browser cached the old app."
