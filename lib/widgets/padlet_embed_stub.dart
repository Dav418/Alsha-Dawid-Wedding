import 'package:flutter/material.dart';

/// Non-web fallback — the wedding site targets Flutter web for this embed.
Widget buildPadletEmbed({
  required String embedUrl,
  required double height,
}) {
  return SizedBox(
    height: height,
    width: double.infinity,
    child: const Center(
      child: Text('Live updates are available on the web version of this site.'),
    ),
  );
}
