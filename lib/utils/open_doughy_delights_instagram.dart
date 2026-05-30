import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

final doughyDelightsInstagramUri = Uri.parse(
  'https://www.instagram.com/doughydelights_uk/',
);

Future<bool> openDoughyDelightsInstagram() {
  return launchUrl(
    doughyDelightsInstagramUri,
    webOnlyWindowName: kIsWeb ? '_blank' : null,
    mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
  );
}
