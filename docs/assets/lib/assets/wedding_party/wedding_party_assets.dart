import '../directory_assets.dart';

/// Portrait paths under [lib/assets/wedding_party] — `firstname_surname.{jpeg,png}`.
abstract final class WeddingPartyAssets extends DirectoryAssets {
  WeddingPartyAssets._();

  static const String base = '${DirectoryAssets.libRoot}/wedding_party';

  static String portraitStem(String firstName, String lastName) {
    return DirectoryAssets.resolve(
      base,
      '${DirectoryAssets.slug(firstName)}_${DirectoryAssets.slug(lastName)}',
    );
  }

  static List<String> portraitCandidates(String firstName, String lastName) {
    return DirectoryAssets.extensionCandidates(
      portraitStem(firstName, lastName),
      DirectoryAssets.extensions,
    );
  }
}
