import 'package:freezed_annotation/freezed_annotation.dart';

part 'wedding_content.freezed.dart';
part 'wedding_content.g.dart';

/// Wedding-specific swap data loaded from JSON (names, dates, contacts, venues, etc.).
@freezed
class WeddingContent with _$WeddingContent {
  const factory WeddingContent({
    required WeddingCouple couple,
    required WeddingEvent event,
    required WeddingContact contact,
    required WeddingSocial social,
    required WeddingLinks links,
    required WeddingVenueSlot ceremony,
    required WeddingVenueSlot reception,
    required WeddingPartyRoster weddingParty,
    required List<String> ourStoryPhotoUrls,
  }) = _WeddingContent;

  factory WeddingContent.fromJson(Map<String, dynamic> json) =>
      _$WeddingContentFromJson(json);
}

@freezed
class WeddingCouple with _$WeddingCouple {
  const WeddingCouple._();

  const factory WeddingCouple({
    required String partner1Name,
    required String partner2Name,
  }) = _WeddingCouple;

  factory WeddingCouple.fromJson(Map<String, dynamic> json) =>
      _$WeddingCoupleFromJson(json);

  String get siteTitle {
    final partner1First = partner1Name.split(' ').first;
    final partner2First = partner2Name.split(' ').first;
    return '$partner1First & $partner2First';
  }
}

@freezed
class WeddingEvent with _$WeddingEvent {
  const factory WeddingEvent({
    required String dateDisplay,
    required String locationDisplay,
    required DateTime countdownUtc,
  }) = _WeddingEvent;

  factory WeddingEvent.fromJson(Map<String, dynamic> json) =>
      _$WeddingEventFromJson(json);
}

@freezed
class WeddingContact with _$WeddingContact {
  const factory WeddingContact({
    required String email,
  }) = _WeddingContact;

  factory WeddingContact.fromJson(Map<String, dynamic> json) =>
      _$WeddingContactFromJson(json);
}

@freezed
class WeddingSocial with _$WeddingSocial {
  const factory WeddingSocial({
    required String instagramHandle,
    required String instagramUrl,
  }) = _WeddingSocial;

  factory WeddingSocial.fromJson(Map<String, dynamic> json) =>
      _$WeddingSocialFromJson(json);
}

@freezed
class WeddingLinks with _$WeddingLinks {
  const factory WeddingLinks({
    required String liveUpdatesUrl,
    required String venueMapQuery,
  }) = _WeddingLinks;

  factory WeddingLinks.fromJson(Map<String, dynamic> json) =>
      _$WeddingLinksFromJson(json);
}

@freezed
class WeddingVenueSlot with _$WeddingVenueSlot {
  const factory WeddingVenueSlot({
    required String time,
    required List<String> addressLines,
  }) = _WeddingVenueSlot;

  factory WeddingVenueSlot.fromJson(Map<String, dynamic> json) =>
      _$WeddingVenueSlotFromJson(json);
}

@freezed
class WeddingPartyRoster with _$WeddingPartyRoster {
  const factory WeddingPartyRoster({
    required List<WeddingPartyMember> bridesmaids,
    required List<WeddingPartyMember> groomsmen,
    required List<WeddingPartyMember> parents,
  }) = _WeddingPartyRoster;

  factory WeddingPartyRoster.fromJson(Map<String, dynamic> json) =>
      _$WeddingPartyRosterFromJson(json);
}

@freezed
class WeddingPartyMember with _$WeddingPartyMember {
  const WeddingPartyMember._();

  const factory WeddingPartyMember({
    required String firstName,
    required String lastName,
    String? honorific,
  }) = _WeddingPartyMember;

  factory WeddingPartyMember.fromJson(Map<String, dynamic> json) =>
      _$WeddingPartyMemberFromJson(json);

  String get displayName {
    if (honorific != null) {
      return '$honorific $firstName $lastName';
    }
    return '$firstName $lastName';
  }
}
