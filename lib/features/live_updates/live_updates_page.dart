import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../router/app_router.gr.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../widgets/gold_heart_rule.dart';
import '../../widgets/padlet_embed.dart';

@RoutePage()
class LiveUpdatesPage extends StatelessWidget {
  const LiveUpdatesPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const LiveUpdatesRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _LiveUpdatesHeader(),
          const SizedBox(height: 22),
          const GoldHeartRule(),
          const SizedBox(height: 22),
          const PadletEmbed(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _LiveUpdatesHeader extends StatelessWidget {
  const _LiveUpdatesHeader();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Live Updates',
          textAlign: TextAlign.center,
          style: AppTypography.scriptHero(scheme, fontSize: 48, height: 1.08),
        ),
        const SizedBox(height: 10),
        Text(
          'STAY UPDATED ON ALL THE DETAILS',
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
