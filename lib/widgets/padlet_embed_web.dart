import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

int _padletViewCounter = 0;

/// Registers an iframe with [HtmlElementView] for Padlet on Flutter web.
Widget buildPadletEmbed({
  required String embedUrl,
  required double height,
}) {
  final viewType = 'padlet-embed-${_padletViewCounter++}';

  ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
    final iframe = web.HTMLIFrameElement()
      ..src = embedUrl
      ..style.border = '0'
      ..style.width = '100%'
      ..style.height = '${height}px'
      ..style.display = 'block'
      ..style.padding = '0'
      ..style.margin = '0'
      ..allow =
          'camera;microphone;geolocation;display-capture;clipboard-write';

    return iframe;
  });

  return SizedBox(
    height: height,
    width: double.infinity,
    child: HtmlElementView(viewType: viewType),
  );
}
