import 'package:freezed_annotation/freezed_annotation.dart';

import '../assets/wedding_party/wedding_party_assets.dart';

part 'party_member.freezed.dart';

@freezed
class PartyMember with _$PartyMember {
  const PartyMember._();

  const factory PartyMember({
    required String firstName,
    required String lastName,
    String? honorific,
  }) = _PartyMember;

  String get displayName {
    if (honorific != null) {
      return '$honorific $firstName $lastName';
    }
    return '$firstName $lastName';
  }

  String get assetPath => WeddingPartyAssets.portrait(firstName, lastName);
}
