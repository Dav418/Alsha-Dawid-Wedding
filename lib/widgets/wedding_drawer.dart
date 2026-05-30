import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../content/repositories/wedding_content_repository.dart';
import '../features/countdown/countdown_page.dart';
import '../features/faq/faq_page.dart';
import '../features/gallery/gallery_page.dart';
import '../features/home/home_page.dart';
import '../features/our_story/our_story_page.dart';
import '../features/rsvp/rsvp_page.dart';
import '../features/travel/travel_page.dart';
import '../features/wedding_details/wedding_details_page.dart';
import '../features/wedding_party/wedding_party_page.dart';
import '../router/app_router.gr.dart';
import '../utils/open_external_url.dart';

/// Side drawer with all sections — tuned for phones (large tap targets).
///
/// [routerContext] must come from [AutoRouter]'s `builder` (nested stack scope).
class WeddingDrawer extends ConsumerWidget {
  const WeddingDrawer({
    required this.routerContext,
    required this.onNavigate,
    super.key,
  });

  final BuildContext routerContext;
  final void Function(String routeName) onNavigate;

  void _go({
    required BuildContext drawerContext,
    required String routeName,
    required void Function(BuildContext) push,
  }) {
    push(routerContext);
    Navigator.of(drawerContext).pop();
    onNavigate(routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final router = routerContext.router;
    final active = router.current.name;
    final liveUpdatesUrl =
        ref.watch(weddingContentRepositoryProvider).requireValue.links.liveUpdatesUrl;

    Widget tile({
      required String label,
      required String routeName,
      required void Function(BuildContext) push,
    }) {
      final selected = active == routeName;

      return ListTile(
        selected: selected,
        selectedTileColor: scheme.primaryContainer.withValues(alpha: 0.35),
        title: Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            letterSpacing: 0.8,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        onTap: () => _go(
          drawerContext: context,
          routeName: routeName,
          push: push,
        ),
      );
    }

    return Drawer(
      backgroundColor: scheme.surface,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: scheme.outlineVariant),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Menu',
                  style: theme.textTheme.titleLarge?.copyWith(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            tile(
              label: 'HOME',
              routeName: HomeRoute.name,
              push: HomePage.push,
            ),
            tile(
              label: 'OUR STORY',
              routeName: OurStoryRoute.name,
              push: OurStoryPage.push,
            ),
            tile(
              label: 'DETAILS',
              routeName: WeddingDetailsRoute.name,
              push: WeddingDetailsPage.push,
            ),
            tile(
              label: 'RSVP',
              routeName: RsvpRoute.name,
              push: RsvpPage.push,
            ),
            tile(
              label: 'TRAVEL',
              routeName: TravelRoute.name,
              push: TravelPage.push,
            ),
            tile(
              label: 'GALLERY',
              routeName: GalleryRoute.name,
              push: GalleryPage.push,
            ),
            tile(
              label: 'WEDDING PARTY',
              routeName: WeddingPartyRoute.name,
              push: WeddingPartyPage.push,
            ),
            tile(
              label: 'FAQ',
              routeName: FaqRoute.name,
              push: FaqPage.push,
            ),
            ListTile(
              title: Text(
                'LIVE UPDATES',
                style: theme.textTheme.titleSmall?.copyWith(
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                await openExternalUrl(Uri.parse(liveUpdatesUrl));
              },
            ),
            tile(
              label: 'COUNTDOWN',
              routeName: CountdownRoute.name,
              push: CountdownPage.push,
            ),
          ],
        ),
      ),
    );
  }
}
