import 'package:url_launcher/url_launcher.dart';

Uri contactEmailUri(String email) => Uri(
      scheme: 'mailto',
      path: email,
    );

Future<bool> openContactEmail(String email) {
  return launchUrl(contactEmailUri(email));
}
