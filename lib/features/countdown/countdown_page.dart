import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/countdown_contact.dart';
import '../../domain/countdown_nav_card.dart';
import '../../router/app_router.gr.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/gold_heart_rule.dart';
import '../../widgets/scenic_page_background.dart';
import '../../widgets/wedding_countdown.dart';
import 'countdown_nav_icons.dart';

const _navCards = [
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
    route: FaqRoute(),
  ),
];

const _contacts = [
  CountdownContact(name: 'Alisha', phone: '07712 345678'),
  CountdownContact(name: 'Dawid', phone: '07925 456789'),
];

const _navCardSize = 112.0;
const _navCardGap = 10.0;

@RoutePage()
class CountdownPage extends StatelessWidget {
  const CountdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScenicPageBackground(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const _CountdownScriptTitle(),
              const WeddingCountdown(showTitle: false),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
          sliver: SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _NavCardsRow(maxWidth: constraints.maxWidth),
                    const SizedBox(height: 28),
                    const GoldHeartRule(),
                    const SizedBox(height: 28),
                    const _CountdownContactSection(),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _CountdownScriptTitle extends StatelessWidget {
  const _CountdownScriptTitle();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fontSize = constraints.maxWidth < 360 ? 46.0 : 58.0;

          return Column(
            children: [
              Text(
                'Counting Down',
                textAlign: TextAlign.center,
                style: AppTypography.scriptHero(
                  scheme,
                  fontSize: fontSize,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'to Forever',
                textAlign: TextAlign.center,
                style: AppTypography.scriptHero(
                  scheme,
                  fontSize: fontSize,
                  height: 1.05,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NavCardsRow extends StatelessWidget {
  const _NavCardsRow({required this.maxWidth});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final rowWidth =
        _navCards.length * _navCardSize + (_navCards.length - 1) * _navCardGap;

    if (maxWidth >= rowWidth) {
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < _navCards.length; i++) ...[
              SizedBox(
                width: _navCardSize,
                height: _navCardSize,
                child: _CountdownNavCard(data: _navCards[i]),
              ),
              if (i < _navCards.length - 1) const SizedBox(width: _navCardGap),
            ],
          ],
        ),
      );
    }

    return SizedBox(
      height: _navCardSize,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _navCards.length,
        separatorBuilder: (_, __) => const SizedBox(width: _navCardGap),
        itemBuilder: (context, index) {
          return SizedBox(
            width: _navCardSize,
            height: _navCardSize,
            child: _CountdownNavCard(data: _navCards[index]),
          );
        },
      ),
    );
  }
}

class _CountdownNavCard extends StatelessWidget {
  const _CountdownNavCard({required this.data});

  final CountdownNavCard data;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: AppColors.creamBackground.withValues(alpha: 0.85),
      elevation: 0,
      shadowColor: AppColors.textCharcoal.withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.goldBrass.withValues(alpha: 0.28),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.router.navigate(data.route),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountdownNavIcon(variant: data.icon, size: 38),
              const SizedBox(height: 8),
              Text(
                data.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.navCardTitle(scheme),
              ),
              const SizedBox(height: 4),
              Text(
                data.subtitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.navCardSubtitle(scheme),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountdownContactSection extends StatelessWidget {
  const _CountdownContactSection();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'CONTACT US',
          textAlign: TextAlign.center,
          style: AppTypography.sectionCaps(scheme, fontSize: 13, letterSpacing: 2),
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < _contacts.length; i++) ...[
          Text(
            '${_contacts[i].name}: ${_contacts[i].phone}',
            textAlign: TextAlign.center,
            style: AppTypography.contactLine(scheme),
          ),
          if (i < _contacts.length - 1) const SizedBox(height: 6),
        ],
      ],
    );
  }
}
