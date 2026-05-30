import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'heart_divider.dart';
import 'wedding_confetti_overlay.dart';

/// Full-width wedding countdown banner — counts down to 17 October 2026 by default.
class WeddingCountdown extends HookWidget {
  const WeddingCountdown({
    super.key,
    this.showTitle = true,
    this.target,
  });

  /// When false, only the heart rules and timer are shown.
  final bool showTitle;

  /// When set, counts down to this moment instead of the wedding day.
  final DateTime? target;

  static final DateTime weddingDay = DateTime(2026, 10, 17);

  @override
  Widget build(BuildContext context) {
    final weddingTarget = target ?? weddingDay;
    final targetKey = weddingTarget.millisecondsSinceEpoch;
    final remaining = useState(_remainingUntil(weddingTarget));
    final reachedZero = useRef(false);
    final confettiController = useWeddingConfettiController();

    useWeddingConfettiOverlay(context, confettiController);

    useEffect(
      () {
        reachedZero.value = false;
        remaining.value = _remainingUntil(weddingTarget);
        return null;
      },
      [targetKey],
    );

    useEffect(
      () {
        final timer = Timer.periodic(
          const Duration(seconds: 1),
          (_) {
            final next = _remainingUntil(weddingTarget);

            if (next != remaining.value) {
              remaining.value = next;
            }
          },
        );

        return timer.cancel;
      },
      [targetKey],
    );

    useEffect(
      () {
        if (remaining.value == Duration.zero && !reachedZero.value) {
          reachedZero.value = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            confettiController.play();
          });
        }

        return null;
      },
      [remaining.value, confettiController],
    );

    final scheme = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 360;
    final numberSize = compact ? 34.0 : (width < 520 ? 42.0 : 48.0);
    final labelSize = compact ? 9.0 : 10.0;
    final titleSize = compact ? 11.0 : 12.5;
    final celebrationSize = compact ? 38.0 : (width < 520 ? 46.0 : 54.0);
    final isComplete = remaining.value == Duration.zero;

    final days = remaining.value.inDays;
    final hours = remaining.value.inHours.remainder(24);
    final minutes = remaining.value.inMinutes.remainder(60);
    final seconds = remaining.value.inSeconds.remainder(60);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.creamBackground,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            compact ? 16 : 28,
            showTitle ? (compact ? 28 : 36) : (compact ? 16 : 20),
            compact ? 16 : 28,
            compact ? 28 : 36,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showTitle) ...[
                Text(
                  'COUNTING DOWN TO FOREVER',
                  textAlign: TextAlign.center,
                  style: AppTypography.countdownBannerTitle(
                    scheme,
                    fontSize: titleSize,
                    compact: compact,
                  ),
                ),
                SizedBox(height: compact ? 18 : 22),
              ],
              const HeartDivider(),
              SizedBox(height: compact ? 20 : 26),
              if (isComplete)
                Text(
                  "Let's get married",
                  textAlign: TextAlign.center,
                  style: AppTypography.scriptHero(
                    scheme,
                    fontSize: celebrationSize,
                    height: 1.05,
                  ),
                )
              else
                _CountdownRow(
                  days: days,
                  hours: hours,
                  minutes: minutes,
                  seconds: seconds,
                  numberSize: numberSize,
                  labelSize: labelSize,
                  compact: compact,
                ),
              SizedBox(height: compact ? 20 : 26),
              const HeartDivider(),
            ],
          ),
        ),
      ),
    );
  }

  static Duration _remainingUntil(DateTime target) {
    final diff = target.difference(DateTime.now());

    if (diff.isNegative) {
      return Duration.zero;
    }

    return diff;
  }
}

class _CountdownRow extends StatelessWidget {
  const _CountdownRow({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.numberSize,
    required this.labelSize,
    required this.compact,
  });

  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final double numberSize;
  final double labelSize;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final unitStyle = AppTypography.countdownUnit(
      scheme,
      fontSize: labelSize,
      compact: compact,
    );
    final numberStyle = AppTypography.countdownNumber(
      scheme,
      fontSize: numberSize,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _CountdownCell(
          value: '$days',
          label: 'DAYS',
          numberStyle: numberStyle,
          unitStyle: unitStyle,
          compact: compact,
        ),
        _CountdownDivider(compact: compact),
        _CountdownCell(
          value: _pad(hours),
          label: 'HRS',
          numberStyle: numberStyle,
          unitStyle: unitStyle,
          compact: compact,
        ),
        _CountdownDivider(compact: compact),
        _CountdownCell(
          value: _pad(minutes),
          label: 'MINS',
          numberStyle: numberStyle,
          unitStyle: unitStyle,
          compact: compact,
        ),
        _CountdownDivider(compact: compact),
        _CountdownCell(
          value: _pad(seconds),
          label: 'SECS',
          numberStyle: numberStyle,
          unitStyle: unitStyle,
          compact: compact,
        ),
      ],
    );
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}

class _CountdownCell extends StatelessWidget {
  const _CountdownCell({
    required this.value,
    required this.label,
    required this.numberStyle,
    required this.unitStyle,
    required this.compact,
  });

  final String value;
  final String label;
  final TextStyle numberStyle;
  final TextStyle unitStyle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: numberStyle),
          SizedBox(height: compact ? 6 : 8),
          Text(label, style: unitStyle),
        ],
      ),
    );
  }
}

class _CountdownDivider extends StatelessWidget {
  const _CountdownDivider({
    required this.compact,
  });

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 1,
      height: compact ? 44 : 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.tertiary.withValues(alpha: 0.45),
        ),
      ),
    );
  }
}
