import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../domain/countdown_nav_card.dart';
import '../features/countdown/countdown_nav_icons.dart';
import '../features/wedding_details/wedding_details_page.dart';
import '../router/app_router.gr.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/open_live_updates.dart';
import '../utils/open_venue_map.dart';

const weddingFooterNavItems = [
  CountdownNavCard(
    title: 'SCHEDULE',
    subtitle: 'View the full itinerary',
    icon: CountdownNavIconVariant.calendar,
    route: WeddingDetailsRoute(),
  ),
  CountdownNavCard(
    title: 'VENUE',
    subtitle: 'Get directions and map',
    icon: CountdownNavIconVariant.mapPin,
    route: TravelRoute(),
  ),
  CountdownNavCard(
    title: 'LIVE UPDATES',
    subtitle: 'Stay updated on all the details',
    icon: CountdownNavIconVariant.megaphone,
    route: LiveUpdatesRoute(),
  ),
];

void pushWeddingFooterRoute(BuildContext context, PageRouteInfo<void> route) {
  switch (route.routeName) {
    case WeddingDetailsRoute.name:
      WeddingDetailsPage.push(context);
  }
}

/// Scrollable footer with quick links — shown at the bottom of every shell page.
class WeddingFooter extends StatelessWidget {
  const WeddingFooter({
    required this.routerContext,
    this.onNavigate,
    super.key,
  });

  final BuildContext routerContext;
  final void Function(String routeName)? onNavigate;

  @override
  Widget build(BuildContext context) {
    final activeRoute = routerContext.router.current.name;

    return ColoredBox(
      color: AppColors.burgundyAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.goldBrass.withValues(alpha: 0.45),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
              child: Row(
                children: [
                  for (var i = 0; i < weddingFooterNavItems.length; i++) ...[
                    if (i > 0)
                      VerticalDivider(
                        width: 1,
                        thickness: 1,
                        indent: 8,
                        endIndent: 8,
                        color: AppColors.goldBrass.withValues(alpha: 0.35),
                      ),
                    Expanded(
                      child: _FooterNavButton(
                        data: weddingFooterNavItems[i],
                        selected: weddingFooterNavItems[i].icon !=
                                CountdownNavIconVariant.mapPin &&
                            activeRoute ==
                                weddingFooterNavItems[i].route.routeName,
                        onTap: () async {
                          final item = weddingFooterNavItems[i];

                          if (item.icon == CountdownNavIconVariant.mapPin) {
                            await openVenueMap();
                            return;
                          }

                          if (item.icon == CountdownNavIconVariant.megaphone) {
                            await openLiveUpdatesInNewTab();
                            return;
                          }

                          final routeName = item.route.routeName;

                          if (activeRoute == routeName) {
                            onNavigate?.call(routeName);
                            return;
                          }

                          pushWeddingFooterRoute(routerContext, item.route);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _FooterNavButton extends StatelessWidget {
  const _FooterNavButton({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final CountdownNavCard data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labelColor = selected
        ? AppColors.goldBrass
        : Colors.white.withValues(alpha: 0.92);

    return Material(
      color: selected
          ? Colors.white.withValues(alpha: 0.08)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CountdownNavIcon(
                variant: data.icon,
                size: 28,
                color: AppColors.goldBrass,
              ),
              const SizedBox(height: 6),
              Text(
                data.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.navCardTitle(
                  Theme.of(context).colorScheme,
                  color: labelColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
