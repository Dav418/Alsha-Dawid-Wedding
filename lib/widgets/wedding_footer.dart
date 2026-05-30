import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../domain/footer_nav_item.dart';
import '../features/wedding_details/wedding_details_page.dart';
import '../router/app_router.gr.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/open_contact_email.dart';
import '../utils/open_doughy_delights_instagram.dart';
import '../utils/open_live_updates.dart';
import '../utils/open_venue_map.dart';
import 'hard_edge_color.dart';
import 'line_icon.dart';

const weddingFooterNavItems = [
  FooterNavItem(
    title: 'SCHEDULE',
    subtitle: 'View the full itinerary',
    icon: LineIconVariant.calendar,
    route: WeddingDetailsRoute(),
  ),
  FooterNavItem(
    title: 'VENUE',
    subtitle: 'Get directions and map',
    icon: LineIconVariant.mapPin,
    route: TravelRoute(),
  ),
  FooterNavItem(
    title: 'LIVE UPDATES',
    subtitle: 'Stay updated on all the details',
    icon: LineIconVariant.megaphone,
    route: LiveUpdatesRoute(),
  ),
];

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
    final compact = MediaQuery.sizeOf(context).width < 360;
    final contactHorizontalPadding = compact ? 16.0 : 40.0;

    return HardEdgeColor(
      color: AppColors.burgundyAccent,
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
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
                                LineIconVariant.mapPin &&
                            activeRoute ==
                                weddingFooterNavItems[i].route.routeName,
                        onTap: () async {
                          final item = weddingFooterNavItems[i];

                          if (item.icon == LineIconVariant.mapPin) {
                            await openVenueMap();
                            return;
                          }

                          if (item.icon == LineIconVariant.megaphone) {
                            await openLiveUpdatesInNewTab();
                            return;
                          }

                          final routeName = item.route.routeName;

                          if (activeRoute == routeName) {
                            onNavigate?.call(routeName);
                            return;
                          }

                          WeddingDetailsPage.push(routerContext);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.fromLTRB(
                contactHorizontalPadding,
                0,
                contactHorizontalPadding,
                16,
              ),
              child: const _FooterContactInfo(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterContactInfo extends StatelessWidget {
  const _FooterContactInfo();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final lineStyle = AppTypography.contactLine(scheme).copyWith(
      fontSize: 12,
      color: Colors.white.withValues(alpha: 0.85),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _FooterContactLine(
          icon: LineIconVariant.email,
          label: contactEmailAddress,
          style: lineStyle,
        ),
        const SizedBox(height: 6),
        _FooterContactLine(
          icon: LineIconVariant.instagram,
          label: '@doughydelights_uk',
          style: lineStyle.copyWith(
            color: AppColors.goldBrass,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.goldBrass.withValues(alpha: 0.5),
          ),
          onTap: () async {
            final opened = await openDoughyDelightsInstagram();

            if (!opened && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Could not open ${doughyDelightsInstagramUri.host}.',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class _FooterContactLine extends StatelessWidget {
  const _FooterContactLine({
    required this.icon,
    required this.label,
    required this.style,
    this.onTap,
  });

  final LineIconVariant icon;
  final String label;
  final TextStyle style;
  final VoidCallback? onTap;

  static const _iconSize = 16.0;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LineIcon(
          variant: icon,
          size: _iconSize,
          color: AppColors.goldBrass,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: style,
          ),
        ),
      ],
    );

    if (onTap == null) {
      return row;
    }

    return InkWell(
      onTap: onTap,
      child: row,
    );
  }
}

class _FooterNavButton extends StatelessWidget {
  const _FooterNavButton({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final FooterNavItem data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final labelColor =
        selected ? AppColors.goldBrass : Colors.white.withValues(alpha: 0.92);

    return Material(
      color:
          selected ? Colors.white.withValues(alpha: 0.08) : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LineIcon(
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
