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
              onPressed: () => _openExternalRsvp(context, rsvpUrl),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  static Future<void> _openExternalRsvp(
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
          'If you are joining us for the church ceremony, the evening '
          'celebration, or both, we kindly ask that you RSVP so we can '
          'plan seating, catering, and your place in the day.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(scheme),
        ),
        const SizedBox(height: 18),
        Text(
          'Our RSVP is completed on a separate secure site. Please work '
          'through every step of the form until you reach the confirmation '
          'page — that is how we know your response has been received.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(scheme),
        ),
        const SizedBox(height: 18),
        Text(
          'The form will let you tell us which parts of the day you are '
          'attending, how many guests are in your party, and any details '
          'we should know ahead of time.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(
            scheme,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'When you are ready, use the button below to open RSVP in a '
          'new tab.',
          textAlign: TextAlign.center,
          style: AppTypography.scriptQuote(scheme, fontSize: 24, height: 1.3),
        ),
      ],
    );
  }
}
