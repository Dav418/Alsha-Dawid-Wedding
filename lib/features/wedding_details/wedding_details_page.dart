import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../router/app_router.gr.dart';
import '../../theme/app_typography.dart';
import '../../widgets/heart_divider.dart';
import 'timeline/wedding_day_timeline.dart';
import 'wedding_timeline_data.dart';

@RoutePage()
class WeddingDetailsPage extends HookWidget {
  const WeddingDetailsPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const WeddingDetailsRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _DetailsHeader(),
          const SizedBox(height: 28),
          WeddingDayTimeline(
            entries: weddingDayTimelineEntries,
            trailingChild: Column(
              children: const [
                HeartDivider(),
                SizedBox(height: 12),
                Text(
                  'Here\'s the end of this timeline for now, hope you enjoyed!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
        const HeartDivider(),
      ],
    );
  }
}
