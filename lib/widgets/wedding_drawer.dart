import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router/app_router.dart';

/// Side drawer with all sections — tuned for phones (large tap targets).
///
/// [routerContext] must come from [AutoRouter]'s `builder` (nested stack scope).
class WeddingDrawer extends StatelessWidget {
  const WeddingDrawer({super.key, required this.routerContext});

  final BuildContext routerContext;

  void _go(BuildContext drawerContext, PageRouteInfo route) {
    routerContext.router.navigate(route);
    Navigator.of(drawerContext).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final router = routerContext.router;
    final active = router.current.name;

    Widget tile({
      required String label,
      required PageRouteInfo route,
      required String routeName,
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
        onTap: () => _go(context, route),
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
              route: const HomeRoute(),
              routeName: HomeRoute.name,
            ),
            tile(
              label: 'OUR STORY',
              route: const OurStoryRoute(),
              routeName: OurStoryRoute.name,
            ),
            tile(
              label: 'DETAILS',
              route: const WeddingDetailsRoute(),
              routeName: WeddingDetailsRoute.name,
            ),
            tile(
              label: 'RSVP',
              route: const RsvpRoute(),
              routeName: RsvpRoute.name,
            ),
            tile(
              label: 'TRAVEL',
              route: const TravelRoute(),
              routeName: TravelRoute.name,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                'MORE',
                style: theme.textTheme.labelSmall?.copyWith(
                  letterSpacing: 2,
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            tile(
              label: 'GALLERY',
              route: const GalleryRoute(),
              routeName: GalleryRoute.name,
            ),
            tile(
              label: 'WEDDING PARTY',
              route: const WeddingPartyRoute(),
              routeName: WeddingPartyRoute.name,
            ),
            tile(
              label: 'FAQ',
              route: const FaqRoute(),
              routeName: FaqRoute.name,
            ),
            tile(
              label: 'COUNTDOWN',
              route: const CountdownRoute(),
              routeName: CountdownRoute.name,
            ),
          ],
        ),
      ),
    );
  }
}
