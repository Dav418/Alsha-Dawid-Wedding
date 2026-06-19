import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/app_page.dart';
import '../../router/app_router.gr.dart';
import '../../theme/app_typography.dart';
import '../../widgets/heart_divider.dart';
import '../../widgets/page_availability_gate.dart';
import 'bank_details_section.dart';
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
    final scheme = Theme.of(context).colorScheme;
    return PageAvailabilityGate(
      page: AppPage.itinerary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _DetailsHeader(),
            WeddingDayTimeline(
              entries: weddingDayTimelineEntries,
              trailingChild: Column(
                children: [
                  HeartDivider(),
                  // SizedBox(height: 12),
                  // Text(
                  //   'Dress Code',
                  //   textAlign: TextAlign.center,
                  //   style: AppTypography.capsLabel(
                  //     scheme,
                  //     color: AppColors.sageGreen,
                  //     fontSize: 28,
                  //   ),
                  // ),
                  // SizedBox(height: 12),
                  // HeartDivider(),
                  SizedBox(height: 12),
                  Text(
                    'Dress Code - Formal Attire. Think elegant, timeless, and occasion-worthy. We encourage guests to dress comfortably while embracing the joy and significance of this auspicious occasion.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySerif(scheme),
                  ),
                  SizedBox(height: 12),
                  HeartDivider(),
                  SizedBox(height: 12),
                  Text(
                    'Your presence is the greatest gift of all. However, if you wish to honour us with a gift, a contribution towards our future together would be greatly appreciated.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySerif(scheme),
                  ),
                  SizedBox(height: 24),
                  const BankDetailsSection(),
                ],
              ),
            ),
          ],
        ),
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
