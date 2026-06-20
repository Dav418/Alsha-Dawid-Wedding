import 'package:flutter/material.dart';

import 'timeline_entry.dart';

const weddingDayTimelineEntries = <TimelineEntry>[
  TimelineEntry(
    time: '11:00am',
    title: 'Blessings and Bridal sendoff',
    details:
        'Blessings and bridal sendoff with the closest family and friends.',
    icon: Icons.favorite_border,
    pinImageAssetPath: 'lib/assets/timeline_pins/blessings.png',
  ),
  TimelineEntry(
    time: '1:00pm',
    title: 'Nuptial Mass',
    details: 'Our wedding ceremony begins with the Nuptial Mass.',
    icon: Icons.church_outlined,
  ),
  TimelineEntry(
    time: '2:15pm',
    title: 'Receiving Line & Group Photo',
    details:
        'Guests are warmly invited to enjoy light refreshments, tea & coffee in the Church Hall while the newly weds go off to a private photoshoot. If you have booked nearby accommodation, please feel free to take this opportunity to freshen up and relax before returning for the reception celebrations.',
    icon: Icons.groups_2_outlined,
  ),
  TimelineEntry(
    time: '3:30pm',
    title: 'Refreshments & Private Photos',
    details: 'Guests can enjoy refreshments while family photos are taken.',
    icon: Icons.local_cafe_outlined,
  ),
  TimelineEntry(
    time: '5:00pm',
    title: 'Reception Guest Arrival',
    details: 'Guests arrive at the reception venue and enjoy welcome drinks.',
    icon: Icons.local_bar_outlined,
  ),
  TimelineEntry(
    time: '6:00pm',
    title: 'Grand Entrance',
    details: 'The newlyweds make their entrance and the evening begins.',
    icon: Icons.celebration_outlined,
  ),
  TimelineEntry(
    time: '6:30pm',
    title: 'Toasts & Speeches',
    details: 'Family and friends share speeches, stories, and toasts.',
    icon: Icons.campaign_outlined,
  ),
  TimelineEntry(
    time: '7:00pm',
    title: 'Opening of the Buffet',
    details: 'The buffet opens and guests are invited to enjoy the meal.',
    icon: Icons.restaurant_menu_outlined,
  ),
];
