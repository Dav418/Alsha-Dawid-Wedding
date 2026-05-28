import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../router/app_router.gr.dart';
import '../../theme/app_typography.dart';
import '../../widgets/wedding_countdown.dart';

@RoutePage()
class CountdownPage extends StatelessWidget {
  const CountdownPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const CountdownRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _CountdownScriptTitle(),
        const WeddingCountdown(showTitle: false),
      ],
    );
  }
}

class _CountdownScriptTitle extends StatelessWidget {
  const _CountdownScriptTitle();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fontSize = constraints.maxWidth < 360 ? 46.0 : 58.0;

          return Column(
            children: [
              Text(
                'Counting Down',
                textAlign: TextAlign.center,
                style: AppTypography.scriptHero(
                  scheme,
                  fontSize: fontSize,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'to Forever',
                textAlign: TextAlign.center,
                style: AppTypography.scriptHero(
                  scheme,
                  fontSize: fontSize,
                  height: 1.05,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
