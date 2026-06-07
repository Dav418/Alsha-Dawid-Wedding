/// Bundled food photos — drop PNGs into [lib/assets/food/polish/] and
/// [lib/assets/food/goan/] using the slug filenames referenced in [FoodMenuData].
abstract final class FoodAssets {
  FoodAssets._();

  static const _root = 'lib/assets/food';

  static String polish(String slug) => '$_root/polish/$slug.png';

  static String goan(String slug) => '$_root/goan/$slug.png';
}
