import 'package:alisha_dawid_wedding_website/models/wedding_details/timeline_entry.dart';
import 'package:flutter/material.dart';

const weddingDayTimelineEntries = <TimelineEntry>[
  TimelineEntry(
    time: '11:00am',
    title: 'Blessings and Bridal sendoff',
    details:
        'Blessings and bridal sendoff with the closest family and friends.',
    icon: Icons.favorite_border,
    pinImageAssetPath: 'lib/assets/timeline_pins/1.Blessings.png',
  ),
  TimelineEntry(
    time: '1:00pm',
    title: 'Nuptial Mass',
    details: 'Our wedding ceremony begins with the Nuptial Mass.',
    icon: Icons.church_outlined,
    pinImageAssetPath: 'lib/assets/timeline_pins/2.Nuptials.png',
  ),
  TimelineEntry(
    time: '2:15pm',
    title: 'Receiving Line & Group Photo',
    details:
        'Guests are warmly invited to enjoy light refreshments, tea & coffee in the Church Hall while the newly weds go off to a private photoshoot. If you have booked nearby accommodation, please feel free to take this opportunity to freshen up and relax before returning for the reception celebrations.',
    icon: Icons.groups_2_outlined,
    pinImageAssetPath: 'lib/assets/timeline_pins/3.GroupPhotos.png',
  ),
  TimelineEntry(
    time: '3:30pm',
    title: 'Refreshments & Private Photos',
    details: 'Guests can enjoy refreshments while family photos are taken.',
    icon: Icons.local_cafe_outlined,
    pinImageAssetPath: 'lib/assets/timeline_pins/4.Refreshments.png',
  ),
  TimelineEntry(
    time: '5:00pm',
    title: 'Reception Guest Arrival',
    details: 'Guests arrive at the reception venue and enjoy welcome drinks.',
    icon: Icons.local_bar_outlined,
    pinImageAssetPath: 'lib/assets/timeline_pins/5.Reception.png',
  ),
  TimelineEntry(
    time: '6:00pm',
    title: 'Grand Entrance',
    details: 'The newlyweds make their entrance and the evening begins.',
    icon: Icons.celebration_outlined,
    pinImageAssetPath: 'lib/assets/timeline_pins/6.GrandEntrance.png',
  ),
  TimelineEntry(
    time: '6:30pm',
    title: 'Toasts & Speeches',
    details:
        'Family and friends share speeches, stories, toasts and cake cutting.',
    icon: Icons.campaign_outlined,
    pinImageAssetPath: 'lib/assets/timeline_pins/7.Toast&Speeches.png',
  ),
  TimelineEntry(
    time: '7:00pm',
    title: 'First Dance',
    details: 'The newlyweds dance to their first song as a couple.',
    icon: Icons.campaign_outlined,
    pinImageAssetPath: 'lib/assets/timeline_pins/8.FirstDance.png',
  ),
  TimelineEntry(
    time: '7:30pm',
    title: 'Opening of the Buffet',
    details: 'The buffet opens and guests are invited to enjoy the meal.',
    icon: Icons.restaurant_menu_outlined,
    pinImageAssetPath: 'lib/assets/timeline_pins/9.Buffet Open.png',
  ),
];
