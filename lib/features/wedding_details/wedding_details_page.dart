import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/app/app_page.dart';
import '../../router/app_router.gr.dart';
import '../../utils/extension/context_extension.dart';
import '../../widgets/heart_divider.dart';
import '../../widgets/page_availability_gate.dart';
import 'timeline/wedding_day_timeline.dart';
import '../../models/wedding_details/wedding_timeline_data.dart';

@RoutePage()
class WeddingDetailsPage extends HookWidget {
  const WeddingDetailsPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const WeddingDetailsRoute());
  }

  @override
  Widget build(BuildContext context) {
    return PageAvailabilityGate(
      page: AppPage.itinerary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
        child: WeddingDayTimeline(
          topChild: Column(
            children: [
              const _DetailsHeader(),
              SizedBox(height: 40),
              Text(
                'Below is a guide to the main events of the day, from the ceremony to the evening celebration. Please use this as a gentle overview of what to expect, while allowing a little flexibility for the natural flow of the day.',
                textAlign: TextAlign.center,
                style: context.bodySerif(),
              ),
              SizedBox(height: 40),
              HeartDivider(),
              SizedBox(height: 40),
            ],
          ),
          entries: weddingDayTimelineEntries,
          trailingChild: Column(
            children: [
              SizedBox(height: 40),
              HeartDivider(),
              SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  style: context.bodySerif(),
                  children: [
                    TextSpan(
                      text: 'Dress Code',
                      style: context.bodySerif().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const TextSpan(
                      text:
                          ' - Formal Attire. Think elegant, timeless, and occasion-worthy. We encourage guests to dress comfortably while embracing the joy and significance of this auspicious occasion.',
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              HeartDivider(),
              SizedBox(height: 12),
              Text(
                'Your presence is the greatest gift of all. However, if you wish to honour us with a gift, a contribution towards our future together would be greatly appreciated.',
                textAlign: TextAlign.center,
                style: context.bodySerif(),
              ),
              SizedBox(height: 24),
              Center(
                child: FilledButton(
                  onPressed: () async {
                    final uri = Uri.parse(
                      'https://pay.collctiv.com/alisha-and-dawid-wedding-53094',
                    );
                    final opened = await context.openExternalUrl(uri);
                    if (!opened && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Could not open the gift link.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(168, 44),
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Send us a gift',
                    style: context.buttonLabel(),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailsHeader extends StatelessWidget {
  const _DetailsHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Wedding Details',
          textAlign: TextAlign.center,
          style: context.scriptHero(),
        ),
        const SizedBox(height: 10),
        const HeartDivider(),
      ],
    );
  }
}
