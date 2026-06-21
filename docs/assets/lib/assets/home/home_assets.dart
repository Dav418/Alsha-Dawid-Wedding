import '../directory_assets.dart';

abstract final class HomeAssets extends DirectoryAssets {
  HomeAssets._();

  static const String base = '${DirectoryAssets.libRoot}/home';

  static String? image(String relativePath) =>
      DirectoryAssets.image(base, relativePath);
}
