import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../router/app_router.gr.dart';
import '../../theme/app_typography.dart';
import '../../widgets/wedding_countdown.dart';

const _durationPresets = [5, 10, 15, 30, 60];

@RoutePage()
class CountdownTestPage extends HookWidget {
  const CountdownTestPage({super.key});

  static void push(BuildContext context) {
    context.router.navigate(const CountdownTestRoute());
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final durationSeconds = useState(10);
    final activeTarget = useState<DateTime?>(null);
    final runId = useState(0);

    void startCountdown() {
      activeTarget.value = DateTime.now().add(
        Duration(seconds: durationSeconds.value),
      );
      runId.value++;
    }

    void resetCountdown() {
      activeTarget.value = null;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
          child: Text(
            'Countdown Test',
            textAlign: TextAlign.center,
            style: AppTypography.scriptHero(
              scheme,
              fontSize: 46,
              height: 1.05,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
          child: Text(
            'Pick a duration, start the timer, and watch confetti when it hits zero.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySerif(scheme),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (final seconds in _durationPresets)
                ChoiceChip(
                  label: Text('${seconds}s'),
                  selected: durationSeconds.value == seconds,
                  onSelected: activeTarget.value == null
                      ? (_) => durationSeconds.value = seconds
                      : null,
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: activeTarget.value == null ? startCountdown : null,
                child: const Text('Start countdown'),
              ),
              if (activeTarget.value != null) ...[
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: resetCountdown,
                  child: const Text('Reset'),
                ),
              ],
            ],
          ),
        ),
        if (activeTarget.value != null) ...[
          const SizedBox(height: 24),
          WeddingCountdown(
            key: ValueKey('${activeTarget.value!.millisecondsSinceEpoch}-${runId.value}'),
            showTitle: true,
            target: activeTarget.value,
          ),
        ],
      ],
    );
  }
}
