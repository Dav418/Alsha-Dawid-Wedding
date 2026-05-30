/// Portrait paths under [lib/assets/wedding_party] — `firstname_surname.png`.
abstract final class WeddingPartyAssets {
  WeddingPartyAssets._();

  static const String _base = 'lib/assets/wedding_party';

  /// e.g. portrait('Sonia', "D'Souza") → `lib/assets/wedding_party/sonia_dsouza.png`
  static String portrait(String firstName, String lastName) {
    return '$_base/${_slug(firstName)}_${_slug(lastName)}.png';
  }

  static String _slug(String value) {
    return value.toLowerCase().replaceAll(RegExp(r"[^a-z0-9]+"), '').trim();
  }
}
