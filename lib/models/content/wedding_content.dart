import 'package:alisha_dawid_wedding_website/models/content/hygraph_image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'our_story_photo.dart';
import 'wedding_contact.dart';
import 'wedding_couple.dart';
import 'wedding_event.dart';
import 'wedding_food_list.dart';
import 'wedding_links.dart';
import 'wedding_party_roster.dart';
import 'wedding_venue_slot.dart';

part 'wedding_content.freezed.dart';
part 'wedding_content.g.dart';

@freezed
class WeddingContent with _$WeddingContent {
  const WeddingContent._();

  const factory WeddingContent({
    required WeddingCouple couple,
    required WeddingEvent event,
    required WeddingContact contact,
    required WeddingLinks links,
    required WeddingVenueSlot ceremony,
    required WeddingVenueSlot reception,
    required WeddingPartyRoster weddingParty,
    required List<OurStoryPhoto> ourStoryPhotos,
    required List<WeddingFoodList> food,
    required List<HygraphImage> gallery,
    required String permissions,
  }) = _WeddingContent;

  factory WeddingContent.fromJson(Map<String, dynamic> json) =>
      _$WeddingContentFromJson(json);

  List<String> get ourStoryPhotoUrls => ourStoryPhotos
      .map((photo) => photo.imageUrl)
      .whereType<String>()
      .toList(growable: false);
}
