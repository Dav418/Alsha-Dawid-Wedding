import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../content/cms_image.dart';

part 'vendor_item.freezed.dart';
part 'vendor_item.g.dart';

enum VendorCategory {
  photographyFilm('PHOTOGRAPHY & FILM'),
  floralsStyling('FLORALS & STYLING'),
  foodDrink('FOOD & DRINK'),
  musicEntertainment('MUSIC & ENTERTAINMENT'),
  beauty('BEAUTY');

  const VendorCategory(this.title);

  final String title;
}

@freezed
class VendorLinks with _$VendorLinks {
  const VendorLinks._();

  const factory VendorLinks({
    String? instagram,
    String? website,
    String? facebook,
    String? tiktok,
    String? youtube,
    String? twitter,
    String? linkedin,
    String? pinterest,
    String? reddit,
    String? telegram,
    String? whatsapp,
  }) = _VendorLinks;

  factory VendorLinks.fromJson(Map<String, dynamic> json) =>
      _$VendorLinksFromJson(json);

  Uri? get instagramUri => _socialUri(
        instagram,
        (handle) => 'https://www.instagram.com/$handle/',
      );

  Uri? get websiteUri => _absoluteUri(website);

  Uri? get facebookUri => _socialUri(
        facebook,
        (handle) => 'https://www.facebook.com/$handle/',
      );

  Uri? get tiktokUri => _socialUri(
        tiktok,
        (handle) => 'https://www.tiktok.com/@$handle/',
      );

  Uri? get youtubeUri => _socialUri(
        youtube,
        (handle) => 'https://www.youtube.com/channel/$handle/',
      );

  Uri? get twitterUri => _socialUri(
        twitter,
        (handle) => 'https://www.twitter.com/$handle/',
      );

  Uri? get linkedinUri => _socialUri(
        linkedin,
        (handle) => 'https://www.linkedin.com/in/$handle/',
      );

  Uri? get pinterestUri => _socialUri(
        pinterest,
        (handle) => 'https://www.pinterest.com/$handle/',
      );

  Uri? get redditUri => _socialUri(
        reddit,
        (handle) => 'https://www.reddit.com/user/$handle/',
      );

  Uri? get telegramUri => _socialUri(
        telegram,
        (handle) => 'https://t.me/$handle/',
      );

  Uri? get whatsappUri => _socialUri(
        whatsapp,
        (handle) => 'https://wa.me/$handle/',
      );

  String? get instagramHandle {
    final value = instagram?.trim();
    if (value == null || value.isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(value);
    if (uri != null && uri.hasScheme) {
      final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
      if (segments.isEmpty) {
        return null;
      }
      return segments.first.replaceFirst(RegExp(r'^@'), '');
    }

    return value.replaceFirst(RegExp(r'^@'), '');
  }
}

Uri? _absoluteUri(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }

  return Uri.tryParse(trimmed);
}

Uri? _socialUri(String? value, String Function(String handle) builder) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }

  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
    return Uri.tryParse(trimmed);
  }

  final handle = trimmed.replaceFirst(RegExp(r'^@'), '');
  if (handle.isEmpty) {
    return null;
  }

  return Uri.parse(builder(handle));
}

@freezed
class VendorItem with _$VendorItem {
  const VendorItem._();

  const factory VendorItem({
    required String name,
    required VendorCategory category,
    String? description,
    CmsImage? logo,
    required VendorLinks links,
    @Default(0) int sortOrder,
  }) = _VendorItem;

  factory VendorItem.fromJson(Map<String, dynamic> json) =>
      _$VendorItemFromJson(json);

  String? get logoUrl {
    final value = logo?.absoluteUrl.trim();

    if (value == null || value.isEmpty) {
      return null;
    }

    return value;
  }

  IconData get icon => switch (category) {
        VendorCategory.photographyFilm => Icons.photo_camera_rounded,
        VendorCategory.floralsStyling => Icons.local_florist_rounded,
        VendorCategory.foodDrink => Icons.restaurant_rounded,
        VendorCategory.musicEntertainment => Icons.music_note_rounded,
        VendorCategory.beauty => Icons.spa_rounded,
      };
}
