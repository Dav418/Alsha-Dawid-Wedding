import '../directory_assets.dart';

/// Bundled food photos — drop images into [lib/assets/food/polish/] and
/// [lib/assets/food/goan/] using the slug filenames referenced in [FoodMenuData].
abstract final class FoodAssets extends DirectoryAssets {
  FoodAssets._();

  static const String base = '${DirectoryAssets.libRoot}/food';
  static const List<String> _extensions = ['jpg', ...DirectoryAssets.extensions];

  static String polish(String slug) =>
      DirectoryAssets.image(base, 'polish/$slug', _extensions);

  static String goan(String slug) =>
      DirectoryAssets.image(base, 'goan/$slug', _extensions);
}
