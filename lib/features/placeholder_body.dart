import 'package:flutter/material.dart';

import '../utils/extension/context_extension.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: context.textTheme.headlineSmall?.copyWith(
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        Placeholder(
          fallbackHeight: 180,
          color: context.colorScheme.outlineVariant,
        ),
      ],
    );
  }
}
