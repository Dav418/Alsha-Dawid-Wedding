import 'package:alisha_dawid_wedding_website/assets/home/wedding_assets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../content/data/wedding_content.dart';
import '../../content/repositories/wedding_content_repository.dart';
import '../../models/app_page.dart';
import '../../router/app_router.gr.dart';
import '../../features/rsvp/rsvp_page.dart';
import '../../features/secret/secret_page.dart';
import '../../widgets/heart_divider.dart';
import '../../widgets/page_availability_gate.dart';
import '../../widgets/wedding_countdown.dart';
import '../../widgets/wedding_hero_invite_card.dart';
import '../../utils/extension/context_extension.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const HomeRoute());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(weddingContentRepositoryProvider).requireValue;

    return PageAvailabilityGate(
      page: AppPage.home,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _HomeHeroInviteCard(content: content),
          Semantics(
            button: true,
            label: 'RSVP',
            child: InkWell(
              onTap: () => RsvpPage.push(context),
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                WeddingAssets.rsvpButton,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const WeddingCountdown(),
          const _HomeWelcomeSection(),
        ],
      ),
    );
  }
}

class _HomeHeroInviteCard extends HookWidget {
  const _HomeHeroInviteCard({required this.content});

  final WeddingContent content;

  static const _secretTapCount = 10;

  @override
  Widget build(BuildContext context) {
    final sealTapCount = useState(0);

    void onSealTap() {
      sealTapCount.value++;
      if (sealTapCount.value >= _secretTapCount) {
        sealTapCount.value = 0;
        SecretPage.push(context);
      }
    }

    return WeddingHeroInviteCard(
      imageAssetPath: WeddingAssets.seal,
      onImageTap: onSealTap,
      child: _HomeInviteContent(content: content),
    );
  }
}

class _HomeInviteContent extends StatelessWidget {
  const _HomeInviteContent({required this.content});

  final WeddingContent content;

  @override
  Widget build(BuildContext context) {
    final couple = content.couple;
    final event = content.event;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 14),
        Text(
          couple.partner1Name,
          textAlign: TextAlign.center,
          style: context.scriptHero( fontSize: 44, height: 1),
        ),
        Text(
          '&',
          textAlign: TextAlign.center,
          style: context.scriptHero( fontSize: 36, height: 1),
        ),
        Text(
          couple.partner2Name,
          textAlign: TextAlign.center,
          style: context.scriptHero( fontSize: 44, height: 1),
        ),
        const SizedBox(height: 16),
        const HeartDivider(),
        const SizedBox(height: 16),
        Text(
          event.weddingDate,
          textAlign: TextAlign.center,
          style: context.capsLabel(
            fontSize: 16,
            letterSpacing: 2,
            color: context.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        const HeartAccent(),
        const SizedBox(height: 10),
        Text(
          event.locationDisplay,
          textAlign: TextAlign.center,
          style: context.capsLabel(
            color: context.colorScheme.primary,
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 28, 36, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome',
            textAlign: TextAlign.center,
            style: context.scriptHero( height: 1.1),
          ),
          const SizedBox(height: 12),
          const HeartAccent(),
          const SizedBox(height: 18),
          Text(
            "We're so excited to celebrate this special chapter with the "
            'people we love most. Here you\u2019ll find everything you need '
            'for our wedding day in October 2026.',
            textAlign: TextAlign.center,
            style: context.bodySerif(),
          ),
          const SizedBox(height: 20),
          Text(
            "We can't wait to celebrate with you!",
            textAlign: TextAlign.center,
            style: context.scriptQuote( height: 1.2, fontSize: 28),
          ),
          const SizedBox(height: 28),
          const HeartAccent(),
        ],
      ),
    );
  }
}
