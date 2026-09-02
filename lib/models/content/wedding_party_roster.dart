import 'package:freezed_annotation/freezed_annotation.dart';

import 'wedding_party_member.dart';

part 'wedding_party_roster.freezed.dart';
part 'wedding_party_roster.g.dart';

@freezed
class WeddingPartyRoster with _$WeddingPartyRoster {
  const factory WeddingPartyRoster({
    required List<WeddingPartyMember> bridesmaids,
    @JsonKey(name: 'brideSquad') required List<WeddingPartyMember> bridesquad,
    required List<WeddingPartyMember> groomsmen,
    required List<WeddingPartyMember> flowerGirls,
    required List<WeddingPartyMember> pageBoys,
    required List<WeddingPartyMember> parents,
    required WeddingPartyMember maidOfHonor,
    required WeddingPartyMember bestMan,
    required List<WeddingPartyMember> dogs,
  }) = _WeddingPartyRoster;

  factory WeddingPartyRoster.fromJson(Map<String, dynamic> json) =>
      _$WeddingPartyRosterFromJson(json);
}
