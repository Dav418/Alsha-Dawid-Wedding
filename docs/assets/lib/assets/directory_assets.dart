/// Shared helpers for bundled asset paths under `lib/assets/<directory>`.
abstract base class DirectoryAssets {
  static const String libRoot = 'lib/assets';

  /// Tried in order — `.jpeg` first, then `.png`.
  static const List<String> extensions = ['jpeg', 'png'];

  /// Normalises a label to a filename stem (lowercase, alphanumeric only).
  ///
  /// e.g. `"D'Souza"` → `dsouza`
  static String slug(String value) {
    return value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '').trim();
  }

  /// `$base/$relativePath` — [relativePath] may include subdirs (no extension).
  static String resolve(String base, String relativePath) => '$base/$relativePath';

  /// `$base/$stem.$ext` using the first matching [extensions] entry.
  static String image(
    String base,
    String stem, [
    List<String> extensions = DirectoryAssets.extensions,
  ]) =>
      '${resolve(base, stem)}.${extensions.first}';

  /// `$stem.$ext` for each [extensions] entry, in order.
  static List<String> extensionCandidates(
    String stem,
    List<String> extensions,
  ) {
    return [for (final ext in extensions) '$stem.$ext'];
  }
}
