import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/countdown_contact.dart';
import '../../router/app_router.gr.dart';
import '../../theme/app_typography.dart';
import '../../widgets/gold_heart_rule.dart';
import '../../widgets/wedding_countdown.dart';

const _contacts = [
  CountdownContact(name: 'Alisha', phone: '07712 345678'),
  CountdownContact(name: 'Dawid', phone: '07925 456789'),
];

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
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const GoldHeartRule(),
              const SizedBox(height: 28),
              const _CountdownContactSection(),
            ],
          ),
        ),
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

class _CountdownContactSection extends StatelessWidget {
  const _CountdownContactSection();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'CONTACT US',
          textAlign: TextAlign.center,
          style: AppTypography.sectionCaps(scheme, fontSize: 13, letterSpacing: 2),
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < _contacts.length; i++) ...[
          Text(
            '${_contacts[i].name}: ${_contacts[i].phone}',
            textAlign: TextAlign.center,
            style: AppTypography.contactLine(scheme),
          ),
          if (i < _contacts.length - 1) const SizedBox(height: 6),
        ],
      ],
    );
  }
}
