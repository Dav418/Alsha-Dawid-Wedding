/// Google Maps API key for Flutter Web (injected at compile time — not stored in source).
///
/// Local run / build:
/// ```bash
/// flutter run -d chrome --dart-define-from-file=secrets.json
/// flutter build web --dart-define-from-file=secrets.json
/// ```
///
/// See [secrets.json.example] at the repo root for the expected JSON shape.
const googleMapsApiKey = String.fromEnvironment(
  'GOOGLE_MAPS_API_KEY',
  defaultValue: '',
);

/// Whether a real key was supplied at compile time (not empty / placeholder).
bool get isGoogleMapsConfigured =>
    googleMapsApiKey.isNotEmpty &&
    googleMapsApiKey != 'YOUR_GOOGLE_MAPS_API_KEY';
