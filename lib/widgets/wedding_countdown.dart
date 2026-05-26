import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'gold_heart_rule.dart';

/// Full-width wedding countdown banner — counts down to 17 October 2026.
class WeddingCountdown extends StatefulWidget {
  const WeddingCountdown({super.key, this.showTitle = true});

  /// When false, only the heart rules and timer are shown.
  final bool showTitle;

  static final DateTime _weddingDay = DateTime(2026, 10, 17);

  @override
  State<WeddingCountdown> createState() => _WeddingCountdownState();
}

class _WeddingCountdownState extends State<WeddingCountdown> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final now = DateTime.now();
    final end = WeddingCountdown._weddingDay;
    final diff = end.difference(now);
    final next = diff.isNegative ? Duration.zero : diff;
    if (next != _remaining) {
      setState(() => _remaining = next);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final days = _remaining.inDays;
    final hours = _remaining.inHours.remainder(24);
    final minutes = _remaining.inMinutes.remainder(60);
    final seconds = _remaining.inSeconds.remainder(60);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final compact = width < 360;
        final numberSize = compact ? 34.0 : (width < 520 ? 42.0 : 48.0);
        final labelSize = compact ? 9.0 : 10.0;
        final titleSize = compact ? 11.0 : 12.5;

        return DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.creamBackground,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                compact ? 16 : 28,
                widget.showTitle
                    ? (compact ? 28 : 36)
                    : (compact ? 16 : 20),
                compact ? 16 : 28,
                compact ? 28 : 36,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.showTitle) ...[
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
      },
    );
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

    Widget cell(String value, String label, {bool showDivider = true}) {
      return Expanded(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(value, style: numberStyle),
                  SizedBox(height: compact ? 6 : 8),
                  Text(label, style: unitStyle),
                ],
              ),
            ),
            if (showDivider)
              Container(
                width: 1,
                height: compact ? 44 : 52,
                color: scheme.tertiary.withValues(alpha: 0.45),
              ),
          ],
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          cell('$days', 'DAYS'),
          cell(_pad(hours), 'HRS'),
          cell(_pad(minutes), 'MINS'),
          cell(_pad(seconds), 'SECS', showDivider: false),
        ],
      ),
    );
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}
