import 'package:flutter/material.dart';

import '../models/app_page.dart';
import '../theme/app_typography.dart';
import 'heart_divider.dart';

class UnderConstructionWidget extends StatelessWidget {
  const UnderConstructionWidget({
    required this.page,
    super.key,
  });

  final AppPage page;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 32, 36, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            page.displayName,
            textAlign: TextAlign.center,
            style: AppTypography.sectionCaps(scheme, fontSize: 16),
          ),
          const SizedBox(height: 16),
          const HeartDivider(),
          const SizedBox(height: 24),
          Image.asset(
            'lib/assets/paws_at_work.png',
            height: 300,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(height: 20),
          Text(
            'Under Construction',
            textAlign: TextAlign.center,
            style: AppTypography.scriptHero(scheme, fontSize: 40, height: 1.1),
          ),
          const SizedBox(height: 16),
          const HeartAccent(),
          const SizedBox(height: 20),
          Text(
            'This page is still being prepared. Please check back soon.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySerif(scheme),
          ),
        ],
      ),
    );
  }
}
