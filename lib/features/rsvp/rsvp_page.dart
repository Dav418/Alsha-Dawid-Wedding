import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alisha_dawid_wedding_website/assets/home/wedding_assets.dart';

import '../../content/repositories/wedding_content_repository.dart';
import '../../router/app_router.gr.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../utils/open_external_url.dart';
import '../../widgets/heart_divider.dart';

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
          Semantics(
            button: true,
            label: 'RSVP',
            child: InkWell(
              onTap: () => openExternalRsvp(context, rsvpUrl),
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                WeddingAssets.rsvpButton,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            'Please RSVP by 17th July 2026. ',
            textAlign: TextAlign.center,
            style: AppTypography.bodySerif(
              Theme.of(context).colorScheme,
              fontWeight: FontWeight.w600,
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
          'When filling out the response form, please read each question carefully '
          'as you will be asked to confirm '
          'your attendance for each part of the event separately. ',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(scheme),
        ),
        const SizedBox(height: 18),
        Text(
          'You can respond for yourself, as well as '
          'for any other guests listed in your group. ',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(scheme),
        ),
        const SizedBox(height: 18),
        Text(
          'When you click the RSVP button, the form will open in a new tab. '
          'Please complete the form all the way through until you reach the '
          'final confirmation screen. After that, it is safe to close the '
          'RSVP tab and return to our wedding website.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySerif(scheme),
        ),
      ],
    );
  }
}
