import '../directory_assets.dart';

/// Paths for home hero florals (transparent PNGs under [lib/assets/home]).
abstract final class WeddingAssets extends DirectoryAssets {
  WeddingAssets._();

  static const String base = '${DirectoryAssets.libRoot}/home';
  static const List<String> _extensions = ['png'];

  static String get leftFloralCluster =>
      DirectoryAssets.image(base, 'left_floral_cluster', _extensions);

  static String get rightFloralCluster =>
      DirectoryAssets.image(base, 'right_floral_cluster', _extensions);

  static String get bottomFloralRibbon =>
      DirectoryAssets.image(base, 'bottom_floral_ribbon', _extensions);

  static String get monogramAdWreath =>
      DirectoryAssets.image(base, 'monogram_ad_wreath', _extensions);

  static String get seal => DirectoryAssets.image(base, 'seal', _extensions);

  static String get rsvpButton =>
      DirectoryAssets.image(base, 'rsvp_button', _extensions);
}
