import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../content/data/wedding_content.dart';
import '../../content/repositories/wedding_content_repository.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/heart_divider.dart';
import '../../widgets/line_icon.dart';

@RoutePage()
class WeddingDetailsPage extends ConsumerWidget {
  const WeddingDetailsPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const WeddingDetailsRoute());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(weddingContentRepositoryProvider).requireValue;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 560;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _DetailsHeader(),
              const SizedBox(height: 28),
              _VenueDetailCard(
                icon: LineIconVariant.church,
                title: 'CEREMONY',
                slot: content.ceremony,
              ),
              const SizedBox(height: 16),
              _VenueDetailCard(
                icon: LineIconVariant.manor,
                title: 'RECEPTION',
                slot: content.reception,
              ),
              const SizedBox(height: 16),
              if (compact)
                const Column(
                  children: [
                    _CompactDetailCard(
                      icon: LineIconVariant.dress,
                      title: 'DRESS CODE',
                      body:
                          'Formal / Black Tie Optional. Think romantic autumn elegance.',
                      swatches: _dressCodeSwatches,
                    ),
                    SizedBox(height: 16),
                    _CompactDetailCard(
                      icon: LineIconVariant.car,
                      title: 'TRANSPORT',
                      body:
                          'Parking available on site. Rickmansworth Station is a 5 minute drive.',
                      swatches: [],
                    ),
                  ],
                )
              else
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _CompactDetailCard(
                        icon: LineIconVariant.dress,
                        title: 'DRESS CODE',
                        body:
                            'Formal / Black Tie Optional. Think romantic autumn elegance.',
                        swatches: _dressCodeSwatches,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _CompactDetailCard(
                        icon: LineIconVariant.car,
                        title: 'TRANSPORT',
                        body:
                            'Parking available on site. Rickmansworth Station is a 5 minute drive.',
                        swatches: [],
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

const _dressCodeSwatches = [
  AppColors.dustyRose,
  AppColors.sageGreen,
  AppColors.deepForest,
  AppColors.burgundyAccent,
];

class _DetailsHeader extends StatelessWidget {
  const _DetailsHeader();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Wedding Details',
          textAlign: TextAlign.center,
          style: AppTypography.scriptHero(scheme),
        ),
        const SizedBox(height: 10),
        Text(
          "HERE'S WHAT TO EXPECT",
          textAlign: TextAlign.center,
          style: AppTypography.capsLabel(
            scheme,
            color: scheme.primary,
          ),
        ),
        const SizedBox(height: 14),
        const HeartDivider(),
      ],
    );
  }
}

class _VenueDetailCard extends StatelessWidget {
  const _VenueDetailCard({
    required this.icon,
    required this.title,
    required this.slot,
  });

  final LineIconVariant icon;
  final String title;
  final WeddingVenueSlot slot;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _DetailsCardShell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LineIcon(variant: icon, size: 86),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.cardTitleCaps(scheme),
                ),
                const SizedBox(height: 6),
                Text(
                  slot.time,
                  style: AppTypography.cardTime(scheme),
                ),
                const SizedBox(height: 8),
                ...slot.addressLines.map(
                  (line) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      line,
                      style: AppTypography.cardBody(scheme),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactDetailCard extends StatelessWidget {
  const _CompactDetailCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.swatches,
  });

  final LineIconVariant icon;
  final String title;
  final String body;
  final List<Color> swatches;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _DetailsCardShell(
      child: Column(
        children: [
          LineIcon(variant: icon, size: 72),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.cardTitleCaps(scheme),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            textAlign: TextAlign.center,
            style: AppTypography.cardBody(scheme, fontSize: 14, height: 1.5),
          ),
          if (swatches.isNotEmpty) ...[
            const SizedBox(height: 18),
            _ColorSwatchRow(colors: swatches),
          ],
        ],
      ),
    );
  }
}

class _DetailsCardShell extends StatelessWidget {
  const _DetailsCardShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.creamBackground.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.goldBrass.withValues(alpha: 0.32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
        child: child,
      ),
    );
  }
}

class _ColorSwatchRow extends StatelessWidget {
  const _ColorSwatchRow({required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final color in colors)
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.goldBrass.withValues(alpha: 0.25),
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.35),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
