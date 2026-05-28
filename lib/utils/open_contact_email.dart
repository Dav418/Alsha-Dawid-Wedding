import 'package:url_launcher/url_launcher.dart';

const contactEmailAddress = 'dawishagorski@gmail.com';

Uri contactEmailUri() => Uri(
      scheme: 'mailto',
      path: contactEmailAddress,
    );

Future<bool> openContactEmail() {
  return launchUrl(contactEmailUri());
}
