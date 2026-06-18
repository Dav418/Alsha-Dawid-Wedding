# Alisha & Dawid Wedding Website

A mobile-first Flutter web wedding website for Alisha Fernandes and Dawid Gorski.

The site gives guests one simple place to view the wedding details, RSVP, wedding party, food menu, FAQ, venue map, live updates, and countdown.

**Live site:** https://alisha-dawid-wedding.vip

---

## Tech stack

* **Flutter Web** for the static website
* **Riverpod** for app state and content loading
* **auto_route** for routing
* **Freezed + json_serializable** for typed content models
* **flutter_hooks** for lightweight widget state
* **Google Fonts** for typography
* **google_maps_flutter** for the embedded accommodation map
* **url_launcher** for external links (RSVP, live updates, email)
* **GitHub Pages** for static hosting from the `/docs` folder

This repo pins Flutter via [FVM](https://fvm.app/) (see `.fvmrc`). The run and deploy scripts use `fvm flutter` when FVM is installed, otherwise plain `flutter`.

---

## Features

* Mobile-first wedding invite landing page
* Wedding countdown
* Ceremony and reception details (times and addresses from JSON; dress code and transport copy in Dart)
* RSVP page (opens external RSVP URL from JSON)
* Wedding party section
* Our Story timeline (timeline copy in Dart; photo URLs from JSON)
* Food & menu page
* FAQ accordion
* Embedded Google Maps page with accommodation POIs
* Footer quick links (itinerary, venue map, live updates)
* Contact email link
* Static content compiled from JSON at build time
* GitHub Pages deployment scripts

Gallery and travel are still placeholder sections for future content.

---

## Design choices

**Static site, no backend.** Everything is a Flutter web build served from GitHub Pages. There is no server, database, or runtime API.

**Swap data in JSON, polish in Dart.** Names, dates, venues, party members, and external URLs live in `wedding_content.json` so they can be edited without touching UI code. Layout, routing, styling, icons, animations, FAQ text, Our Story copy, and food menu content stay in Dart because they are tied to the design.

**Compile-time content injection.** Wedding content is not loaded from a public JSON file at runtime. A merge script embeds it into the build via `--dart-define-from-file=dart_defines.json`. That keeps the deployed site a single static bundle and avoids an extra network fetch for core content.

**Secrets stay separate.** The Google Maps API key lives in gitignored `secrets.json` and is merged into `dart_defines.json` at run/build time. It is never committed and never belongs in `wedding_content.json`.

**Custom domain hosting.** The site is served from the domain root (`/`), not from a GitHub Pages project subpath, so builds use `--base-href '/'`.

---

## Content

Editable wedding content lives at the repo root:

```text
wedding_content.json
```

Copy `wedding_content.json.example` to `wedding_content.json`, then edit it like normal JSON. See the example file for the expected shape.

**In JSON:**

* Couple names
* Wedding date, location display, and countdown timestamp
* Ceremony and reception times and address lines
* Wedding party members
* Contact email
* External links: RSVP URL, live updates URL, venue map search query
* Our Story photo URLs

**In Dart (not JSON):**

* FAQ questions and answers
* Our Story timeline headings and descriptions
* Dress code, transport, and other details-page copy
* Food menu items and images
* Map POI data and page copy

Before running or building, merge content with your API key:

```bash
python3 scripts/merge_dart_defines.py
```

Or use `./run.sh` / `.\run.ps1`, which run the merge step automatically. VS Code launch configs also run it via a preLaunchTask.

---

## Secrets and local setup

These files are gitignored:

* `secrets.json` — `GOOGLE_MAPS_API_KEY` for the embedded map
* `wedding_content.json` — editable wedding content
* `dart_defines.json` — generated merge of the two, used by Flutter

Copy the example files and fill in your values:

```bash
cp secrets.json.example secrets.json
cp wedding_content.json.example wedding_content.json
python3 scripts/merge_dart_defines.py
```

On Windows:

```powershell
Copy-Item secrets.json.example secrets.json
Copy-Item wedding_content.json.example wedding_content.json
python3 scripts/merge_dart_defines.py
```

Restrict the Maps key to HTTP referrers such as `http://localhost:*` and `https://alisha-dawid-wedding.vip/*`.

---

## Public data warning

This is a public static website.

Wedding content is compiled into the web build and published with the site. It is not private, encrypted, or hidden.

Keep API keys in `secrets.json` only. Do not put them in `wedding_content.json`.

---

## Run locally

First-time setup:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
cp secrets.json.example secrets.json
cp wedding_content.json.example wedding_content.json
```

Then run:

```bash
./run.sh
```

On Windows:

```powershell
.\run.ps1
```

That merges `secrets.json` + `wedding_content.json` into `dart_defines.json` and starts the app in Chrome.

---

## Build for custom domain

The site is deployed at the domain root:

```text
https://alisha-dawid-wedding.vip/
```

A manual release build needs the custom-domain base href **and** the merged dart defines:

```bash
python3 scripts/merge_dart_defines.py
flutter build web --release --base-href '/' --dart-define-from-file=dart_defines.json
```

Do not use the old repo-path base href:

```bash
flutter build web --release --base-href '/Alsha-Dawid-Wedding/'
```

That was only needed when the site was hosted directly under the GitHub Pages repo URL.

Prefer `./deploy.sh` or `.\deploy.ps1` instead of building by hand — they handle codegen, web metadata, validation, and copying output to `/docs`.

---

## Deploy

The repo publishes from:

```text
main branch → /docs folder
```

Run from the repo root on `main`:

```bash
./deploy.sh
```

On Windows:

```powershell
.\deploy.ps1
```

The deploy script:

1. Verifies the script is being run from the Flutter project root on the `main` branch.
2. Cleans the Flutter project and regenerates the `web/` folder from the current Flutter SDK.
3. Updates web metadata (title, manifest, favicon) from `wedding_content.json`.
4. Gets Flutter packages and runs code generation.
5. Validates `wedding_content.json` and `secrets.json`.
6. Merges dart defines and builds the Flutter web release with `--base-href '/'`.
7. Creates `404.html` for GitHub Pages deep links.
8. Replaces the `/docs` folder with the latest `build/web` output.
9. Adds `.nojekyll` and the `CNAME` file for the custom domain.
10. Commits and pushes the updated deploy files.

After pushing, wait for GitHub Pages to update, then hard-refresh the live site (e.g. Cmd + Shift + R on macOS, Ctrl + F5 on Windows).

---

## Generated files

Code generation creates files such as:

```text
*.freezed.dart
*.g.dart
*.gr.dart
```

These are generated by `build_runner`.

Run code generation after changing models, routes, providers, or anything else that depends on generated files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## Project layout

```text
wedding_content.json     Editable wedding content (gitignored)
secrets.json             Google Maps API key (gitignored)
dart_defines.json        Generated merge for Flutter (gitignored)
scripts/                 merge_dart_defines.py
lib/config/              Compile-time config (content JSON, Maps key)
lib/content/             Content models, repository, and provider
lib/features/            Main route pages and feature sections
lib/router/              auto_route configuration
lib/shell/               App shell, navigation, scroll structure
lib/theme/               Colours, typography, and theme setup
lib/widgets/             Shared UI widgets
lib/assets/              Bundled images (home, party, food, etc.)
web/                     Flutter web template files
docs/                    Built GitHub Pages output
deploy.sh / deploy.ps1   Build and deployment scripts
run.sh / run.ps1         Run locally in Chrome (one command)
```

---

## Licence

Private wedding project. Not intended for redistribution.
