import 'package:alisha_dawid_wedding_website/assets/directory_assets.dart';

abstract final class TimelineAssets extends DirectoryAssets {
  TimelineAssets._();

  static const String base = '${DirectoryAssets.libRoot}/timeline_pins';

  static String? image(String relativePath) =>
      DirectoryAssets.image(base, DirectoryAssets.slug(relativePath));
}
