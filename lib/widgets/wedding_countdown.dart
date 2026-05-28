import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'gold_heart_rule.dart';

/// Full-width wedding countdown banner — counts down to 17 October 2026.
class WeddingCountdown extends HookWidget {
  const WeddingCountdown({
    super.key,
    this.showTitle = true,
  });

  /// When false, only the heart rules and timer are shown.
  final bool showTitle;

  static final DateTime _weddingDay = DateTime(2026, 10, 17);

  @override
  Widget build(BuildContext context) {
    final remaining = useState(_remainingUntilWedding());

    useEffect(
      () {
        final timer = Timer.periodic(
          const Duration(seconds: 1),
          (_) {
            final next = _remainingUntilWedding();

            if (next != remaining.value) {
              remaining.value = next;
            }
          },
        );

        return timer.cancel;
      },
      const [],
    );

    final scheme = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 360;
    final numberSize = compact ? 34.0 : (width < 520 ? 42.0 : 48.0);
    final labelSize = compact ? 9.0 : 10.0;
    final titleSize = compact ? 11.0 : 12.5;

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
              const GoldHeartRule(),
              SizedBox(height: compact ? 20 : 26),
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
              const GoldHeartRule(),
            ],
          ),
        ),
      ),
    );
  }

  static Duration _remainingUntilWedding() {
    final diff = _weddingDay.difference(DateTime.now());

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
