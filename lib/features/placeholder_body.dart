import 'package:flutter/material.dart';

/// Shared skeleton section content for placeholder routes.
class WeddingSectionPlaceholder extends StatelessWidget {
  const WeddingSectionPlaceholder({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          style: textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        Placeholder(
          fallbackHeight: 180,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ],
    );
  }
}
