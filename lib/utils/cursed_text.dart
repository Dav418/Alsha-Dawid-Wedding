import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Playful scrambled placeholder copy for unrevealed wedding party members.
///
/// Uses ASCII letters only so script/serif fonts do not render missing-glyph
/// striped boxes for block-drawing characters.
abstract final class CursedText {
  CursedText._();

  static const _letters = 'abcdefghijklmnopqrstuvwxyz';
  static const _marks = [
    '\u0300',
    '\u0301',
    '\u0304',
    '\u0307',
    '\u0308',
    '\u0310',
    '\u0313',
    '\u0323',
    '\u0335',
    '\u0336',
    '\u0338',
  ];

  static String name({required String seed}) {
    final base = _generate(
      seed: '$seed-name',
      wordCount: 2,
      minWordLen: 4,
      maxWordLen: 7,
    );
    return _zalgify(_scrambleCase(base), seed: '$seed-name-z', intensity: 2);
  }

  static String bio({required String seed}) {
    final base = _generate(
      seed: '$seed-bio',
      wordCount: 10,
      minWordLen: 3,
      maxWordLen: 8,
    );
    return _zalgify(_scrambleCase(base), seed: '$seed-bio-z', intensity: 1);
  }

  static TextStyle portraitNameStyle(ColorScheme scheme) =>
      GoogleFonts.spaceMono(
        fontSize: 11.5,
        height: 1.25,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        color: scheme.onSurface.withValues(alpha: 0.82),
      );

  static TextStyle polaroidNameStyle(ColorScheme scheme) =>
      GoogleFonts.spaceMono(
        fontSize: 22,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: scheme.primary,
      );

  static TextStyle polaroidBioStyle(ColorScheme scheme) =>
      GoogleFonts.spaceMono(
        fontSize: 12,
        height: 1.45,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: scheme.onSurfaceVariant.withValues(alpha: 0.88),
      );

  static String _generate({
    required String seed,
    required int wordCount,
    required int minWordLen,
    required int maxWordLen,
  }) {
    var state = seed.hashCode;

    int nextInt() {
      state = (state * 1103515245 + 12345) & 0x7fffffff;
      return state;
    }

    final words = <String>[];
    for (var w = 0; w < wordCount; w++) {
      final length = minWordLen + nextInt() % (maxWordLen - minWordLen + 1);
      final buffer = StringBuffer();

      for (var i = 0; i < length; i++) {
        if (nextInt() % 9 == 0) {
          buffer.write('?');
        } else {
          buffer.write(_letters[nextInt() % _letters.length]);
        }
      }

      words.add(buffer.toString());
    }

    return words.join(' ');
  }

  static String _scrambleCase(String text) {
    var state = text.hashCode;

    int nextInt() {
      state = (state * 1103515245 + 12345) & 0x7fffffff;
      return state;
    }

    final buffer = StringBuffer();
    for (final unit in text.runes) {
      if (unit == 0x20 || unit == 0x3f) {
        buffer.writeCharCode(unit);
        continue;
      }

      final char = String.fromCharCode(unit);
      buffer.write(nextInt().isEven ? char.toUpperCase() : char);
    }

    return buffer.toString();
  }

  static String _zalgify(
    String text, {
    required String seed,
    required int intensity,
  }) {
    var state = seed.hashCode;

    int nextInt() {
      state = (state * 1103515245 + 12345) & 0x7fffffff;
      return state;
    }

    final buffer = StringBuffer();
    for (final unit in text.runes) {
      if (unit == 0x20) {
        buffer.write(' ');
        continue;
      }

      buffer.writeCharCode(unit);
      final markCount = nextInt() % (intensity + 1);
      for (var i = 0; i < markCount; i++) {
        buffer.write(_marks[nextInt() % _marks.length]);
      }
    }

    return buffer.toString();
  }
}
