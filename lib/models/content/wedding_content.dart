import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/extension/string_extension.dart';

part 'wedding_content.freezed.dart';
part 'wedding_content.g.dart';

/// Wedding-specific swap data loaded from JSON (names, dates, contacts, venues, etc.).
@freezed
class WeddingContent with _$WeddingContent {
  const factory WeddingContent({
    required WeddingCouple couple,
    required WeddingEvent event,
    required WeddingContact contact,
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
    return '$partner1First & $partner2First Wedding';
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

  const WeddingEvent._();

  String get weddingDate => dateDisplay.withSuperscriptOrdinals();
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
class WeddingLinks with _$WeddingLinks {
  const factory WeddingLinks({
    required String liveUpdatesUrl,
    required String venueMapQuery,
    required String rsvpUrl,
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
    required List<WeddingPartyMember> bridesquad,
    required List<WeddingPartyMember> groomsmen,
    required List<WeddingPartyMember> parents,
    required WeddingPartyMember maidOfHonor,
    required WeddingPartyMember bestMan,
    required List<WeddingPartyMember> dogs,
  }) = _WeddingPartyRoster;

  factory WeddingPartyRoster.fromJson(Map<String, dynamic> json) =>
      _$WeddingPartyRosterFromJson(json);
}

enum WeddingPartySection {
  bridesmaids('BRIDESMAIDS'),
  bridesquad('BRIDE SQUAD'),
  groomsmen('GROOMSMEN'),
  parents('PARENTS'),
  maidOfHonor('MAID OF HONOR'),
  bestMan('BEST MAN'),
  dogs('PAWS OF HONOR');

  const WeddingPartySection(this.title);

  final String title;
}

enum PortraitGender {
  male,
  female;

  /// Fallback portrait when no named asset exists.
  static PortraitGender forMember(
    WeddingPartyMember member,
    WeddingPartySection section,
  ) {
    switch (section) {
      case WeddingPartySection.bridesmaids:
      case WeddingPartySection.bridesquad:
        return PortraitGender.female;
      case WeddingPartySection.groomsmen:
        return PortraitGender.male;
      case WeddingPartySection.parents:
        final honorific = member.honorific?.trim().toLowerCase() ?? '';
        if (honorific.startsWith('mrs')) return PortraitGender.female;
        if (honorific.startsWith('mr')) return PortraitGender.male;
        return PortraitGender.male;
      case WeddingPartySection.maidOfHonor:
        return PortraitGender.female;
      case WeddingPartySection.bestMan:
        return PortraitGender.male;
      case WeddingPartySection.dogs:
        final bio = member.bio?.trim().toLowerCase() ?? '';
        if (bio.contains('girl')) return PortraitGender.female;
        if (bio.contains('boy')) return PortraitGender.male;
        return PortraitGender.male;
    }
  }
}

@freezed
class WeddingPartyMember with _$WeddingPartyMember {
  const WeddingPartyMember._();

  const factory WeddingPartyMember({
    required String firstName,
    required String lastName,
    String? honorific,
    String? bio,
  }) = _WeddingPartyMember;

  factory WeddingPartyMember.fromJson(Map<String, dynamic> json) =>
      _$WeddingPartyMemberFromJson(json);

  bool get hasName => firstName.trim().isNotEmpty || lastName.trim().isNotEmpty;

  bool get hasBio => bio?.trim().isNotEmpty ?? false;

  String get displayName {
    if (honorific != null) {
      return '$honorific $firstName $lastName';
    }
    return '$firstName $lastName';
  }
}
