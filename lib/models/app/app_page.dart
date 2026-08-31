import 'package:flutter/material.dart';

import '../../features/countdown/countdown_page.dart';
import '../../features/countdown/countdown_test_page.dart';
import '../../features/faq/faq_page.dart';
import '../../features/food/food_page.dart';
import '../../features/gallery/gallery_page.dart';
import '../../features/home/home_page.dart';
import '../../features/map/map_page.dart';
import '../../features/our_story/our_story_page.dart';
import '../../features/rsvp/rsvp_page.dart';
import '../../features/vendors/vendors_page.dart';
import '../../features/wedding_details/wedding_details_page.dart';
import '../../features/wedding_party/wedding_party_page.dart';
import '../../router/app_router.gr.dart';

enum AppPage {
  home,
  ourStory,
  gallery,
  itinerary,
  map,
  food,
  rsvp,
  faq,
  weddingParty,
  vendors,
  countdown,
  countdownTest,
}

extension AppPageX on AppPage {
  String get displayName => switch (this) {
        AppPage.home => 'Home',
        AppPage.ourStory => 'Our Story',
        AppPage.gallery => 'Gallery',
        AppPage.itinerary => 'Itinerary',
        AppPage.map => 'Travel & Accommodation',
        AppPage.food => 'Food & Drinks',
        AppPage.rsvp => 'RSVP',
        AppPage.faq => 'FAQ',
        AppPage.weddingParty => 'Our Entourage',
        AppPage.vendors => 'Vendors',
        AppPage.countdown => 'Countdown',
        AppPage.countdownTest => 'Countdown Test',
      };

  String get routeName => switch (this) {
        AppPage.home => HomeRoute.name,
        AppPage.ourStory => OurStoryRoute.name,
        AppPage.gallery => GalleryRoute.name,
        AppPage.itinerary => WeddingDetailsRoute.name,
        AppPage.map => MapRoute.name,
        AppPage.food => FoodRoute.name,
        AppPage.rsvp => RsvpRoute.name,
        AppPage.faq => FaqRoute.name,
        AppPage.weddingParty => WeddingPartyRoute.name,
        AppPage.vendors => VendorsRoute.name,
        AppPage.countdown => CountdownRoute.name,
        AppPage.countdownTest => CountdownTestRoute.name,
      };

  void push(BuildContext context) => switch (this) {
        AppPage.home => HomePage.push(context),
        AppPage.ourStory => OurStoryPage.push(context),
        AppPage.gallery => GalleryPage.push(context),
        AppPage.itinerary => WeddingDetailsPage.push(context),
        AppPage.map => MapPage.push(context),
        AppPage.food => FoodPage.push(context),
        AppPage.rsvp => RsvpPage.push(context),
        AppPage.faq => FaqPage.push(context),
        AppPage.weddingParty => WeddingPartyPage.push(context),
        AppPage.vendors => VendorsPage.push(context),
        AppPage.countdown => CountdownPage.push(context),
        AppPage.countdownTest => CountdownTestPage.push(context),
      };
}

const defaultPageAvailability = <AppPage, bool>{
  AppPage.home: true,
  AppPage.ourStory: false,
  AppPage.gallery: false,
  AppPage.itinerary: true,
  AppPage.map: true,
  AppPage.food: false,
  AppPage.rsvp: true,
  AppPage.faq: true,
  AppPage.weddingParty: true,
  AppPage.vendors: true,
  AppPage.countdown: true,
  AppPage.countdownTest: true,
};
