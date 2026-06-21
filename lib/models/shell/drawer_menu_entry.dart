import 'package:freezed_annotation/freezed_annotation.dart';

import '../../providers/page_availability_provider.dart';
import '../app/app_page.dart';

part 'drawer_menu_entry.freezed.dart';

@freezed
class DrawerMenuEntry with _$DrawerMenuEntry {
  const DrawerMenuEntry._();

  const factory DrawerMenuEntry.page({required AppPage page}) =
      DrawerMenuPageEntry;

  const factory DrawerMenuEntry.liveUpdates() = DrawerMenuLiveUpdatesEntry;

  bool isAvailable(Map<AppPage, bool> availability) => when(
        page: (page) => isPageWorking(availability, page),
        liveUpdates: () => true,
      );

  static ({
    List<DrawerMenuEntry> available,
    List<DrawerMenuEntry> underConstruction,
  }) partitionByAvailability(Map<AppPage, bool> availability) {
    final available = <DrawerMenuEntry>[];
    final underConstruction = <DrawerMenuEntry>[];

    for (final entry in drawerMenuEntries) {
      if (entry.isAvailable(availability)) {
        available.add(entry);
      } else {
        underConstruction.add(entry);
      }
    }

    return (available: available, underConstruction: underConstruction);
  }
}

const drawerMenuEntries = <DrawerMenuEntry>[
  DrawerMenuEntry.page(page: AppPage.home),
  DrawerMenuEntry.page(page: AppPage.ourStory),
  DrawerMenuEntry.page(page: AppPage.gallery),
  DrawerMenuEntry.page(page: AppPage.itinerary),
  DrawerMenuEntry.page(page: AppPage.map),
  DrawerMenuEntry.page(page: AppPage.food),
  DrawerMenuEntry.page(page: AppPage.rsvp),
  DrawerMenuEntry.page(page: AppPage.faq),
  DrawerMenuEntry.page(page: AppPage.weddingParty),
  DrawerMenuEntry.page(page: AppPage.vendors),
  DrawerMenuEntry.liveUpdates(),
  DrawerMenuEntry.page(page: AppPage.countdown),
];
