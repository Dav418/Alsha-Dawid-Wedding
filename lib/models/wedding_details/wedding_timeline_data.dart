import 'package:alisha_dawid_wedding_website/models/wedding_details/timeline_entry.dart';
import 'package:flutter/material.dart';

const weddingDayTimelineEntries = <TimelineEntry>[
  TimelineEntry(
    time: '11:00am',
    title: 'Blessings & Bridal sendoff',
    details:
        "At the Bride's residence, family and friends wish her well before she makes her way to the church.",
    icon: Icons.favorite_border,
  ),
  TimelineEntry(
    time: '1:00pm',
    title: 'Nuptial Mass',
    details:
        'Witness the exchange of vows before God, family and friends as we enter into the sacred covenant of Holy Matrimony.',
    icon: Icons.church_outlined,
  ),
  TimelineEntry(
    time: '2:15pm',
    title: 'Receiving Line & Group Photo',
    details:
        'A wonderful opportunity to personally congratulate the newlyweds, share your well wishes, and create lasting memories together before the reception begins.',
    icon: Icons.groups_2_outlined,
  ),
  TimelineEntry(
    time: '3:30pm',
    title: 'Refreshments & Private Photos',
    details:
        'Guests are warmly invited to enjoy light refreshments, tea & coffee in the Church Hall while the newlyweds go off to a private photo shoot. If you have booked nearby accommodation, please feel free to take this opportunity to freshen up and relax before returning for the reception celebrations.',
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
    details:
        'Pop some bubbly and raise a glass. Its time to toast the newlyweds!',
    icon: Icons.campaign_outlined,
  ),
  TimelineEntry(
    time: '7:00pm',
    title: 'First Dance',
    details: 'The newlyweds dance to their first song as a couple.',
    icon: Icons.campaign_outlined,
  ),
  TimelineEntry(
    time: '7:30pm',
    title: 'Opening of the Buffet',
    details:
        'Help yourselves to a selection of Goan and Polish cuisine, embracing the union of our two cultures.',
    icon: Icons.restaurant_menu_outlined,
  ),
  TimelineEntry(
    time: '11:00pm',
    title: 'Send Off',
    details:
        'As the celebrations draw to a close, it is time to bid farewell to the newlyweds as they drive off into the moonlight, embarking on their happily ever after together.',
    icon: Icons.drive_eta_outlined,
  ),
];
