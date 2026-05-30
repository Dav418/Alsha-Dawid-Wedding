# Alisha & Dawid — Wedding Website

A mobile-first Flutter web wedding site for Alisha Fernandes and Dawid Gorski. Guests can browse the schedule, travel notes, wedding party, FAQ, and a live countdown — all from a single static deployment on GitHub Pages.

**Live site:** [https://dav418.github.io/Alsha-Dawid-Wedding/](https://dav418.github.io/Alsha-Dawid-Wedding/)

## Tech stack

- **Flutter Web** — UI and routing
- **Riverpod** — app state
- **auto_route** — declarative navigation
- **Freezed + json_serializable** — typed content models from JSON
- **flutter_hooks** — lightweight widget state (countdown, accordions)
- **Google Fonts** — typography (Playfair Display, Montserrat, script faces)
- **GitHub Pages** — static hosting from the `/docs` folder on `main`

## Features

- Home invite card with couple names, date, and location
- Wedding countdown (UTC target from content JSON)
- Our Story timeline with photo stack
- Wedding details (ceremony, reception, dress code, transport)
- Wedding party portraits
- FAQ accordion
- Footer quick links (schedule, venue map, live updates)
- Clickable contact email and Instagram link
- Side drawer navigation across all sections

Placeholder sections (RSVP, gallery, travel) remain scaffolded for future content.

At startup the app loads this file once through a Riverpod provider and passes typed `WeddingContent` models to pages and widgets. Layout, colours, icons, and routing stay in Dart — the JSON holds text, URLs, dates, and lists only.

### Public data

This is a **public static site**. The JSON is bundled into the web build and shipped to GitHub Pages like any other asset. It is **not encrypted** and should not contain secrets. Treat email addresses and external links as publicly visible.

### Swapping sensetive wedding content

1. Edit or replace `assets/content/wedding_content.json` with your own content (keep the same JSON shape).
2. Run code generation if you changed Dart models:
   ```powershell
   dart run build_runner build --delete-conflicting-outputs
   ```
3. Run the app locally to verify, then deploy (see below).

Couple names, schedule copy, FAQ entries, party members, contact email, Instagram, live-updates URL, venue map query, and the countdown UTC timestamp all come from this file.

## Run locally

Requires a recent stable Flutter SDK (Dart ≥ 3.6).

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome
```

For a release-style web build (matching GitHub Pages paths):

```powershell
flutter build web --release --base-href "/Alsha-Dawid-Wedding/"
```

Serve `build/web` with any static file server, or open via Flutter’s dev server.

## Deploy to GitHub Pages

The repo publishes from the **`/docs` folder on `main`**. The included PowerShell script builds Flutter web, copies output into `docs`, commits, and pushes:

```powershell
.\deploy.ps1
```

The script:

1. Verifies you are on `main`
2. Runs `flutter pub get`
3. Runs `dart run build_runner build --delete-conflicting-outputs`
4. Builds with `--base-href "/Alsha-Dawid-Wedding/"`
5. Copies `build/web` → `docs` and adds `.nojekyll`
6. Commits and pushes `docs` if anything changed

Ensure GitHub Pages is configured to serve from **branch `main`, folder `/docs`**.

After pushing, allow one to two minutes for GitHub Pages to update, then hard-refresh the live URL.

## Generated files

Code generation produces `*.freezed.dart`, `*.g.dart`, and `*.gr.dart` files locally. These are **gitignored** and recreated by `build_runner` before each build or deploy. Do not commit them.

## Project layout (high level)

```
assets/content/          Wedding copy (JSON)
lib/content/             Models, repository, Riverpod provider
lib/features/            Route pages
lib/router/              auto_route configuration
lib/shell/               App shell (app bar, footer, scroll)
lib/theme/               Colours and typography
lib/widgets/             Shared UI components
docs/                    Built web app (deploy artefact)
deploy.ps1               Build and publish script
```

## Licence

Private wedding project — not intended for redistribution.
