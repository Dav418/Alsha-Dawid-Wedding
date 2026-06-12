import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../content/repositories/wedding_content_repository.dart';
import '../../router/app_router.gr.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../utils/open_external_url.dart';
import '../../widgets/heart_divider.dart';
import '../../widgets/wedding_action_button.dart';

@RoutePage()
class RsvpPage extends ConsumerWidget {
  const RsvpPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const RsvpRoute());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rsvpUrl =
        ref.watch(weddingContentRepositoryProvider).requireValue.links.rsvpUrl;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _RsvpHeader(),
          const SizedBox(height: 28),
          const HeartDivider(),
          const SizedBox(height: 28),
          const _RsvpIntro(),
          const SizedBox(height: 32),
          Center(
            child: WeddingActionButton(
              label: 'RESPOND ONLINE',
              onPressed: () => openExternalRsvp(context, rsvpUrl),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  static Future<void> openExternalRsvp(
    BuildContext context,
    String url,
  ) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('RSVP link is not configured yet.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    final opened = await openExternalUrl(uri);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the RSVP page.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _RsvpHeader extends StatelessWidget {
  const _RsvpHeader();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'RSVP',
          textAlign: TextAlign.center,
          style: AppTypography.scriptHero(scheme),
        ),
        const SizedBox(height: 10),
        Text(
          'LET US KNOW YOU\'RE COMING',
          textAlign: TextAlign.center,
          style: AppTypography.capsLabel(
            scheme,
            color: AppColors.sageGreen,
          ),
        ),
      ],
    );
  }
}

class _RsvpIntro extends StatelessWidget {
  const _RsvpIntro();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'We are so excited to celebrate our wedding day with the people '
          'we love most.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(scheme),
        ),
        const SizedBox(height: 18),
        Text(
          'Before you RSVP, please note that you will be asked two '
          'separate questions. One will ask whether you will be attending '
          'the church ceremony, and the other will ask whether you will be '
          'joining us for the evening celebration.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(scheme),
        ),
        const SizedBox(height: 18),
        Text(
          'This helps us understand which parts of the day each guest will '
          'be joining us for, so we can plan everything properly, including '
          'seating, timings, catering, and making sure everyone is included '
          'in the right part of the day.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(scheme),
        ),
        const SizedBox(height: 18),
        Text(
          'To make the RSVP form easier to complete, guests under 18 have '
          'been grouped with their family. Parents or guardians can RSVP '
          'on behalf of children in their family group.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(scheme),
        ),
        const SizedBox(height: 18),
        Text(
          'Guests aged 18 or over have their own RSVP entry and will need '
          'to complete their own response separately.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(
            scheme,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'When you click the RSVP button, the form will open in a new tab. '
          'Please complete the form all the way through until you reach the '
          'final confirmation screen. Your RSVP is only submitted once you '
          'see that confirmation screen.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(
            scheme,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'After that, it is safe to close the RSVP tab and return to our '
          'wedding website.',
          textAlign: TextAlign.center,
          style: AppTypography.scriptQuote(scheme, fontSize: 24, height: 1.3),
        ),
      ],
    );
  }
}
