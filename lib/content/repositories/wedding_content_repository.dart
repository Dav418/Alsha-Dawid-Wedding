import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../api/wedding_api.dart';
import '../../config/strapi_config.dart';
import '../../models/content/content.dart';

part 'wedding_content_repository.g.dart';

@riverpod
class WeddingContentRepository extends _$WeddingContentRepository {
  @override
  Future<WeddingContent> build() async {
    return loadWeddingContent(ref.watch(weddingApiServiceProvider));
  }
}

Future<WeddingContent> loadWeddingContent([WeddingApi? api]) async {
  final client = api ??
      WeddingApi(
        Dio(
          BaseOptions(
            baseUrl: StrapiConfig.baseUrl,
            responseType: ResponseType.json,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 15),
          ),
        ),
      );

  final wedding = await client.getWeddingJson();
  final members = await client.getWeddingPartyMembers();
  final foodItems = await client.getFoodItems();
  final storyEntries = await client.getStoryEntries();

  return WeddingContent(
    couple: WeddingCouple.fromJson(
      wedding['couple'] as Map<String, dynamic>,
    ),
    event: WeddingEvent.fromJson(
      wedding['event'] as Map<String, dynamic>,
    ),
    contact: WeddingContact.fromJson(
      wedding['contact'] as Map<String, dynamic>,
    ),
    links: WeddingLinks.fromJson(
      wedding['links'] as Map<String, dynamic>,
    ),
    ceremony: WeddingVenueSlot.fromJson(
      wedding['ceremony'] as Map<String, dynamic>,
    ),
    reception: WeddingVenueSlot.fromJson(
      wedding['reception'] as Map<String, dynamic>,
    ),
    weddingParty: _assembleWeddingParty(members),
    ourStoryPhotos: storyEntries,
    food: _groupFood(foodItems),
    gallery: _parseGallery(wedding['gallery']),
    permissions: Map<String, dynamic>.from(
      wedding['permissions'] as Map? ?? const <String, dynamic>{},
    ),
  );
}

WeddingPartyRoster _assembleWeddingParty(List<WeddingPartyMember> members) {
  final bridesmaids = <WeddingPartyMember>[];
  final bridesquad = <WeddingPartyMember>[];
  final groomsmen = <WeddingPartyMember>[];
  final flowerGirls = <WeddingPartyMember>[];
  final pageBoys = <WeddingPartyMember>[];
  final parents = <WeddingPartyMember>[];
  final dogs = <WeddingPartyMember>[];

  WeddingPartyMember? maidOfHonor;
  WeddingPartyMember? bestMan;

  for (final member in members) {
    switch (member.role) {
      case 'bridesmaids':
        bridesmaids.add(member);
      case 'bridesquad':
        bridesquad.add(member);
      case 'groomsmen':
        groomsmen.add(member);
      case 'flowerGirls':
        flowerGirls.add(member);
      case 'pageBoys':
        pageBoys.add(member);
      case 'parents':
        parents.add(member);
      case 'maidOfHonor':
        maidOfHonor = member;
      case 'bestMan':
        bestMan = member;
      case 'dogs':
        dogs.add(member);
      default:
        throw StateError('Unknown wedding party role: ${member.role}');
    }
  }

  if (maidOfHonor == null) {
    throw StateError('Strapi returned no maid of honor.');
  }

  if (bestMan == null) {
    throw StateError('Strapi returned no best man.');
  }

  return WeddingPartyRoster(
    bridesmaids: bridesmaids,
    bridesquad: bridesquad,
    groomsmen: groomsmen,
    flowerGirls: flowerGirls,
    pageBoys: pageBoys,
    parents: parents,
    maidOfHonor: maidOfHonor,
    bestMan: bestMan,
    dogs: dogs,
  );
}

List<WeddingFoodList> _groupFood(List<WeddingFoodItem> items) {
  final groups = <String, List<WeddingFoodItem>>{};

  for (final item in items) {
    groups.putIfAbsent(item.culture, () => <WeddingFoodItem>[]);
    groups[item.culture]!.add(item);
  }

  return groups.entries
      .map(
        (entry) => WeddingFoodList(
          culture: entry.key,
          items: entry.value,
        ),
      )
      .toList(growable: false);
}

List<CmsImage> _parseGallery(Object? raw) {
  if (raw is! List) {
    return const <CmsImage>[];
  }

  return raw
      .whereType<Map<String, dynamic>>()
      .map(CmsImage.fromJson)
      .toList(growable: false);
}
