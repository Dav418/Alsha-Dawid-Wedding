import '../widgets/line_icon.dart';

enum FooterNavAction {
  schedule(
    title: 'SCHEDULE',
    icon: LineIconVariant.calendar,
  ),
  venueMap(
    title: 'VENUE',
    icon: LineIconVariant.mapPin,
  ),
  liveUpdates(
    title: 'LIVE UPDATES',
    icon: LineIconVariant.megaphone,
  );

  const FooterNavAction({
    required this.title,
    required this.icon,
  });

  final String title;
  final LineIconVariant icon;
}
