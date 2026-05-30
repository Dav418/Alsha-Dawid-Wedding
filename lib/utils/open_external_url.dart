import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens [uri] in a new browser tab on web, or externally on other platforms.
Future<bool> openExternalUrl(Uri uri) {
  return launchUrl(
    uri,
    webOnlyWindowName: kIsWeb ? '_blank' : null,
    mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
  );
}
