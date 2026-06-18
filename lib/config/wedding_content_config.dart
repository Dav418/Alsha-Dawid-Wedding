/// Wedding content JSON (injected at compile time — not stored in source).
///
/// Local run / build:
/// ```bash
/// python3 scripts/merge_dart_defines.py
/// flutter run -d chrome --dart-define-from-file=dart_defines.json
/// flutter build web --release --dart-define-from-file=dart_defines.json
/// ```
///
/// Edit [wedding_content.json] at the repo root, then run the merge script.
/// See [wedding_content.json.example] for the expected JSON shape.
const weddingContentJson = String.fromEnvironment(
  'WEDDING_CONTENT_JSON',
  defaultValue: '',
);

/// Whether wedding content was supplied at compile time.
bool get isWeddingContentConfigured => weddingContentJson.isNotEmpty;
