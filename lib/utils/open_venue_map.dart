import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

const _venueQuery = 'Rickmansworth, UK';

Uri venueMapUri() {
  final encoded = Uri.encodeComponent(_venueQuery);

  if (kIsWeb) {
    return Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$encoded',
    );
  }

  return switch (defaultTargetPlatform) {
    TargetPlatform.iOS => Uri.parse('https://maps.apple.com/?q=$encoded'),
    _ => Uri.parse('geo:0,0?q=$encoded'),
  };
}

Future<void> openVenueMap() async {
  final uri = venueMapUri();
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
