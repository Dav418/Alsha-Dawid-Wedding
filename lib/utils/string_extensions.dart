final _ordinalPattern = RegExp(r'(\d+)(st|nd|rd|th)\b', caseSensitive: false);

/// Ordinal suffixes with raised Unicode letters (e.g. `17ᵗʰ`).
extension SuperscriptOrdinalString on String {
  /// Replaces `17th`-style ordinals with superscript suffixes.
  String withSuperscriptOrdinals() {
    return replaceAllMapped(_ordinalPattern, (match) {
      final digits = match.group(1)!;
      final suffix = match.group(2)!.superscriptOrdinal;
      return '$digits$suffix';
    });
  }

  /// Raises ordinal suffix letters, e.g. `th` → `ᵗʰ`.
  String get superscriptOrdinal {
    return split('').map(_toSuperscriptLetter).join();
  }
}

String _toSuperscriptLetter(String letter) {
  switch (letter) {
    case 's':
      return '\u02E2';
    case 't':
      return '\u1D57';
    case 'n':
      return '\u207F';
    case 'd':
      return '\u1D48';
    case 'r':
      return '\u02B3';
    case 'h':
      return '\u02B0';
    default:
      return letter;
  }
}
