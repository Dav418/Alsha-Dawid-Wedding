import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import 'bank_details_data.dart';

class BankDetailsSection extends HookWidget {
  const BankDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final region = useState(BankAccountRegion.english);
    final account = bankAccounts[region.value]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _BankRegionPillSwitch(
          selected: region.value,
          onChanged: (value) => region.value = value,
        ),
        const SizedBox(height: 24),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.creamBackground.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.goldBrass.withValues(alpha: 0.22),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.textCharcoal.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < account.fields.length; i++) ...[
                  _BankDetailLine(field: account.fields[i]),
                  if (i < account.fields.length - 1) const SizedBox(height: 14),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BankRegionPillSwitch extends StatelessWidget {
  const _BankRegionPillSwitch({
    required this.selected,
    required this.onChanged,
  });

  final BankAccountRegion selected;
  final ValueChanged<BankAccountRegion> onChanged;

  static const _options = [
    (BankAccountRegion.polish, 'POLISH'),
    (BankAccountRegion.english, 'ENGLISH'),
    (BankAccountRegion.indian, 'INDIAN'),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final selectedIndex = _options.indexWhere((option) => option.$1 == selected);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.creamBackground.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.goldBrass.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textCharcoal.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final segmentWidth = constraints.maxWidth / _options.length;

            return Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  left: selectedIndex * segmentWidth,
                  top: 0,
                  bottom: 0,
                  width: segmentWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        BoxShadow(
                          color: scheme.primary.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (final (value, label) in _options)
                      _BankPillOption(
                        label: label,
                        selected: selected == value,
                        onTap: () => onChanged(value),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BankPillOption extends StatelessWidget {
  const _BankPillOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.capsLabel(
                scheme,
                fontSize: 10.5,
                letterSpacing: 1.6,
                color: selected ? scheme.onPrimary : scheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BankDetailLine extends StatelessWidget {
  const _BankDetailLine({required this.field});

  final BankDetailField field;

  Future<void> _copyValue(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: field.value));
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${field.label} copied'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final labelStyle = AppTypography.faqQuestion(scheme);
    final valueStyle = AppTypography.faqAnswer(scheme);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              style: valueStyle,
              children: [
                TextSpan(text: '${field.label}: ', style: labelStyle),
                TextSpan(text: field.value),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () => _copyValue(context),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              Icons.copy_rounded,
              size: 18,
              color: scheme.primary.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}
