import 'package:flutter/material.dart';

import '../utils/extension/context_extension.dart';

/// Horizontal lines with a centered heart — uses [ColorScheme.tertiary].
class HeartDivider extends StatelessWidget {
  const HeartDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final gold = context.colorScheme.tertiary;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: gold.withValues(alpha: 0.55),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.favorite_rounded,
            size: 10,
            color: gold,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: gold.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}

/// Standalone heart accent — uses [ColorScheme.tertiary].
class HeartAccent extends StatelessWidget {
  const HeartAccent({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_rounded,
      size: 11,
      color: context.colorScheme.tertiary,
    );
  }
}
