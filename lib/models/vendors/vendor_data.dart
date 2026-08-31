import 'package:flutter/material.dart';

import 'vendor_item.dart';

// Each vendor can have an Instagram handle, a plain website URL, or neither.
// For Instagram just give the handle (the full link is built from it); for a
// website give the full URL. Replace the placeholders below and remove any
// vendors that don't apply.
const vendorItems = <VendorItem>[
  VendorItem(
    name: 'Photographer',
    links: VendorLinks(
      instagram: 'photographer',
      website: 'https://example.com',
    ),
    category: VendorCategory.photographyFilm,
    icon: Icons.photo_camera_rounded,
  ),
  VendorItem(
    name: 'Videographer',
    links: VendorLinks(
      instagram: 'videographer',
    ),
    category: VendorCategory.photographyFilm,
    icon: Icons.videocam_rounded,
  ),
  VendorItem(
    name: 'Florist',
    links: VendorLinks(
      instagram: 'florist',
    ),
    category: VendorCategory.floralsStyling,
    icon: Icons.local_florist_rounded,
  ),
  VendorItem(
    name: 'Décor & Styling',
    links: VendorLinks(
      instagram: 'decor_styling',
    ),
    category: VendorCategory.floralsStyling,
    icon: Icons.chair_alt_rounded,
  ),
  VendorItem(
    name: 'Caterer',
    links: VendorLinks(
      website: 'https://example.com',
    ),
    category: VendorCategory.foodDrink,
    icon: Icons.restaurant_rounded,
  ),
  VendorItem(
    name: 'Doughy Delights',
    links: VendorLinks(
      instagram: 'doughydelights_uk',
    ),
    category: VendorCategory.foodDrink,
    icon: Icons.cake_rounded,
  ),
  VendorItem(
    name: 'DJ / Band',
    links: VendorLinks(
      instagram: 'dj_band',
    ),
    category: VendorCategory.musicEntertainment,
    icon: Icons.music_note_rounded,
  ),
  VendorItem(
    name: 'Hair & Makeup',
    links: VendorLinks(
      instagram: 'hair_makeup',
    ),
    category: VendorCategory.beauty,
    icon: Icons.brush_rounded,
  ),
];
