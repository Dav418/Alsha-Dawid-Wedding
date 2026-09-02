import 'package:flutter/painting.dart';

final _ordinalPattern = RegExp(r'(\d+)(st|nd|rd|th)\b', caseSensitive: false);

const _inlineMarkdownMarkers = ['***', '~~', '**', '__', '*', '_'];

extension StringExtension on String {
  String withSuperscriptOrdinals() {
    return replaceAllMapped(_ordinalPattern, (match) {
      final digits = match.group(1)!;
      final suffix = match.group(2)!.superscriptOrdinal;
      return '$digits$suffix';
    });
  }

  String get superscriptOrdinal {
    return split('').map(_toSuperscriptLetter).join();
  }

  List<InlineSpan> toInlineMarkdownSpans() {
    final spans = _parseInlineMarkdown(this, null);
    if (spans.isEmpty) {
      return [TextSpan(text: this)];
    }
    return spans;
  }
}

List<InlineSpan> _parseInlineMarkdown(String text, TextStyle? style) {
  if (text.isEmpty) {
    return [TextSpan(text: text, style: style)];
  }

  for (var i = 0; i < text.length; i++) {
    for (final marker in _inlineMarkdownMarkers) {
      if (!text.startsWith(marker, i)) {
        continue;
      }

      final contentStart = i + marker.length;
      final close = text.indexOf(marker, contentStart);
      if (close == -1) {
        continue;
      }

      final spans = <InlineSpan>[];
      if (i > 0) {
        spans.add(TextSpan(text: text.substring(0, i), style: style));
      }

      final inner = text.substring(contentStart, close);
      final nestedStyle = (style ?? const TextStyle()).merge(
        _styleForMarkdownMarker(marker),
      );
      spans.addAll(_parseInlineMarkdown(inner, nestedStyle));
      spans.addAll(
        _parseInlineMarkdown(text.substring(close + marker.length), style),
      );
      return spans;
    }
  }

  return [TextSpan(text: text, style: style)];
}

TextStyle _styleForMarkdownMarker(String marker) {
  switch (marker) {
    case '***':
      return const TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      );
    case '**':
    case '__':
      return const TextStyle(fontWeight: FontWeight.bold);
    case '*':
    case '_':
      return const TextStyle(fontStyle: FontStyle.italic);
    case '~~':
      return const TextStyle(decoration: TextDecoration.lineThrough);
    default:
      return const TextStyle();
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
