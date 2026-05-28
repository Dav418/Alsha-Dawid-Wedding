import 'package:flutter/material.dart';

import 'padlet_embed_stub.dart'
    if (dart.library.js_interop) 'padlet_embed_web.dart';

const _defaultPadletEmbedUrl = 'https://padlet.com/embed/nh7dv7ohems19mue';

/// Embeds a Padlet board via iframe on Flutter web ([HtmlElementView]).
class PadletEmbed extends StatelessWidget {
  const PadletEmbed({
    super.key,
    this.embedUrl = _defaultPadletEmbedUrl,
    this.height = 608,
  });

  final String embedUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: const Color(0x1A000000)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: buildPadletEmbed(embedUrl: embedUrl, height: height),
      ),
    );
  }
}
