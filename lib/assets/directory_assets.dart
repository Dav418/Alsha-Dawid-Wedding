import 'package:flutter/services.dart';

/// Shared helpers for bundled asset paths under `lib/assets/<directory>`.
abstract base class DirectoryAssets {
  static const String libRoot = 'lib/assets';

  static const List<String> extensions = ['png', 'jpeg', 'jpg'];

  static Set<String>? _bundled;

  /// Loads the asset manifest once.
  static Future<void> ensureLoaded() async {
    if (_bundled != null) return;
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    _bundled = manifest.listAssets().toSet();
  }

  /// Normalises a label to a snake_case filename stem.
  ///
  /// Each word is lowercased and stripped to alphanumeric characters; words are
  /// joined with `_`. e.g. `"Nuptial Mass"` → `nuptial_mass`, `"D'Souza"` → `dsouza`
  static String slug(String value) {
    return value
        .split(RegExp(r'[\s&]+'))
        .map(
          (word) => word.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), ''),
        )
        .where((part) => part.isNotEmpty)
        .join('_');
  }

  /// `$base/$relativePath` — [relativePath] may include subdirs (no extension).
  static String _resolve(String base, String relativePath) =>
      '$base/$relativePath';

  /// First bundled image for [relativePath] under [base], or null if none match.
  static String? image(String base, String relativePath) {
    final bundled = _bundled;
    if (bundled == null) return null;

    final stem = _resolve(base, relativePath);
    for (final ext in extensions) {
      final path = '$stem.$ext';
      if (bundled.contains(path)) return path;
    }
    return null;
  }
}
