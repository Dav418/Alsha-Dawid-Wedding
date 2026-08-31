import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_item.freezed.dart';

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

  Uri? get instagramUri {
    final handle = instagram?.trim().replaceFirst(RegExp(r'^@'), '');
    return handle?.isEmpty ?? true
        ? null
        : Uri.parse('https://www.instagram.com/$handle/');
  }

  Uri? get websiteUri {
    return website?.isEmpty ?? true
        ? null
        : Uri.parse(website!);
  }

  Uri? get facebookUri {
    return facebook?.isEmpty ?? true
        ? null
        : Uri.parse('https://www.facebook.com/$facebook/');
  }

  Uri? get tiktokUri {
    return tiktok?.isEmpty ?? true
        ? null
        : Uri.parse('https://www.tiktok.com/@$tiktok/');
  }

  Uri? get youtubeUri {
    return youtube?.isEmpty ?? true
        ? null
        : Uri.parse('https://www.youtube.com/channel/$youtube/');
  }

  Uri? get twitterUri {
    return twitter?.isEmpty ?? true
        ? null
        : Uri.parse('https://www.twitter.com/$twitter/');
  }

  Uri? get linkedinUri {
    return linkedin?.isEmpty ?? true
        ? null
        : Uri.parse('https://www.linkedin.com/in/$linkedin/');
  }

  Uri? get pinterestUri {
    return pinterest?.isEmpty ?? true
        ? null
        : Uri.parse('https://www.pinterest.com/$pinterest/');
  }

  Uri? get redditUri {
    return reddit?.isEmpty ?? true
        ? null
        : Uri.parse('https://www.reddit.com/user/$reddit/');
  }

  Uri? get telegramUri {
    return telegram?.isEmpty ?? true
        ? null
        : Uri.parse('https://t.me/$telegram/');
  }

  Uri? get whatsappUri {
    return whatsapp?.isEmpty ?? true
        ? null
        : Uri.parse('https://wa.me/$whatsapp/');
  }
}

@freezed
class VendorItem with _$VendorItem {
  const VendorItem._();

  const factory VendorItem({
    required String name,
    required VendorCategory category,
    required VendorLinks links,
    @Default(Icons.favorite_rounded) IconData icon,
  }) = _VendorItem;
}
