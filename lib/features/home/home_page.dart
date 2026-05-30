import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../content/data/wedding_content.dart';
import '../../content/repositories/wedding_content_repository.dart';
import '../../router/app_router.gr.dart';
import '../../theme/app_typography.dart';
import '../../widgets/heart_divider.dart';
import '../../widgets/wedding_countdown.dart';
import '../../widgets/wedding_hero_invite_card.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const HomeRoute());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(weddingContentRepositoryProvider).requireValue;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeddingHeroInviteCard(
          child: _HomeInviteContent(content: content),
        ),
        const WeddingCountdown(),
        const _HomeWelcomeSection(),
      ],
    );
  }
}

class _HomeInviteContent extends StatelessWidget {
  const _HomeInviteContent({required this.content});

  final WeddingContent content;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final couple = content.couple;
    final event = content.event;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'TOGETHER WITH THEIR FAMILIES',
          textAlign: TextAlign.center,
          style: AppTypography.capsLabel(scheme),
        ),
        const SizedBox(height: 14),
        Text(
          couple.partner1Name,
          textAlign: TextAlign.center,
          style: AppTypography.scriptName(scheme),
        ),
        Text(
          '&',
          textAlign: TextAlign.center,
          style: AppTypography.scriptName(scheme, fontSize: 36),
        ),
        Text(
          couple.partner2Name,
          textAlign: TextAlign.center,
          style: AppTypography.scriptName(scheme),
        ),
        const SizedBox(height: 16),
        const HeartDivider(),
        const SizedBox(height: 16),
        Text(
          event.dateDisplay,
          textAlign: TextAlign.center,
          style: AppTypography.capsLabel(
            scheme,
            fontSize: 16,
            letterSpacing: 2,
            color: scheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        const HeartAccent(),
        const SizedBox(height: 10),
        Text(
          event.locationDisplay,
          textAlign: TextAlign.center,
          style: AppTypography.capsLabel(
            scheme,
            color: scheme.primary,
          ),
        ),
      ],
    );
  }
}

class _HomeWelcomeSection extends StatelessWidget {
  const _HomeWelcomeSection();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 28, 36, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome',
            textAlign: TextAlign.center,
            style: AppTypography.scriptHero(scheme, height: 1.1),
          ),
          const SizedBox(height: 12),
          const HeartAccent(),
          const SizedBox(height: 18),
          Text(
            "We're so excited to celebrate this special chapter with the "
            'people we love most. Here you\u2019ll find everything you need '
            'for our wedding weekend in October 2026.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySerif(scheme),
          ),
          const SizedBox(height: 20),
          Text(
            "We can't wait to celebrate with you.",
            textAlign: TextAlign.center,
            style: AppTypography.scriptQuote(scheme, height: 1.2),
          ),
          const SizedBox(height: 14),
          const HeartAccent(),
        ],
      ),
    );
  }
}
