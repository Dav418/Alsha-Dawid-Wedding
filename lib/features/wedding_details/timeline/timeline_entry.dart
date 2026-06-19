import 'timeline_image_position.dart';

class TimelineEntry {
  const TimelineEntry({
    required this.time,
    required this.title,
    this.details,
    this.imageAssetPath,
    this.imagePosition = TimelineImagePosition.topRight,
  });

  final String time;
  final String title;
  final String? details;
  final String? imageAssetPath;
  final TimelineImagePosition imagePosition;
}
