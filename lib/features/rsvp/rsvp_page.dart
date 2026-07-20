import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../models/app/app_page.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/heart_divider.dart';
import '../../widgets/page_availability_gate.dart';
import '../../utils/extension/context_extension.dart';

@RoutePage()
class RsvpPage extends StatelessWidget {
  const RsvpPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const RsvpRoute());
  }

  @override
  Widget build(BuildContext context) {
    return PageAvailabilityGate(
      page: AppPage.rsvp,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _RsvpHeader(),
            const SizedBox(height: 28),
            const HeartDivider(),
            const SizedBox(height: 28),
            Image.asset(
              'lib/assets/bouncer_dog.png',
              height: 280,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(height: 24),
            Text(
              'RSVPs are now closed',
              textAlign: TextAlign.center,
              style: context.bodySerif(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Our four-legged German shepherd is on duty, and we\'re afraid '
              'the guest list is firmly sealed. If you\'re just arriving '
              'at this page, we\'re sorry to say it\'s a little too late '
              'to RSVP — and without a response, we\'re unable to include '
              'you on the day.',
              textAlign: TextAlign.center,
              style: context.bodySerif(),
            ),
            const SizedBox(height: 18),
            Text(
              'If you believe this is a mistake or your plans have changed, '
              'please reach out to us directly and we\'ll do our best to help.',
              textAlign: TextAlign.center,
              style: context.bodySerif(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _RsvpHeader extends StatelessWidget {
  const _RsvpHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'RSVP',
          textAlign: TextAlign.center,
          style: context.scriptHero(),
        ),
        const SizedBox(height: 10),
        Text(
          'GUEST LIST CLOSED',
          textAlign: TextAlign.center,
          style: context.capsLabel(
            color: context.sageGreen,
          ),
        ),
      ],
    );
  }
}
