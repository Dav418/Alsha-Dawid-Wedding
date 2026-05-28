import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

final _padletBoardUri = Uri.parse(
  'https://padlet.com/gorskidawid98/my-glorious-padlet-nh7dv7ohems19mue',
);

/// Opens the Padlet live updates board in a new browser tab.
Future<void> openLiveUpdatesInNewTab() async {
  await launchUrl(
    _padletBoardUri,
    webOnlyWindowName: kIsWeb ? '_blank' : null,
    mode: kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
  );
}
