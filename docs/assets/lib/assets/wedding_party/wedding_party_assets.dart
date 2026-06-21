import '../../models/content/wedding_content.dart';
import '../directory_assets.dart';

abstract final class WeddingPartyAssets extends DirectoryAssets {
  WeddingPartyAssets._();

  static const String base = '${DirectoryAssets.libRoot}/wedding_party';

  static String portrait({
    required WeddingPartyMember member,
    required WeddingPartySection section,
  }) {
    final gender = PortraitGender.forMember(member, section);

    var path = DirectoryAssets.image(
      base,
      '${DirectoryAssets.slug(member.firstName)}_${DirectoryAssets.slug(member.lastName)}',
    );

    if (path != null) return path;

    switch (gender) {
      case PortraitGender.male:
        return DirectoryAssets.image(
          base,
          'unknown_male',
        )!;

      case PortraitGender.female:
        return DirectoryAssets.image(
          base,
          'unknown_female',
        )!;
    }
  }
}
