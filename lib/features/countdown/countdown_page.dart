import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../models/app/app_page.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/page_availability_gate.dart';
import '../../widgets/wedding_countdown.dart';
import '../../utils/extension/context_extension.dart';

@RoutePage()
class CountdownPage extends StatelessWidget {
  const CountdownPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const CountdownRoute());
  }

  @override
  Widget build(BuildContext context) {
    return PageAvailabilityGate(
      page: AppPage.countdown,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CountdownScriptTitle(),
          WeddingCountdown(showTitle: false),
        ],
      ),
    );
  }
}

class _CountdownScriptTitle extends StatelessWidget {
  const _CountdownScriptTitle();

  @override
  Widget build(BuildContext context) {

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
                style: context.scriptHero(
                  fontSize: fontSize,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'to Forever',
                textAlign: TextAlign.center,
                style: context.scriptHero(
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
