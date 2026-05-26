import 'package:flutter/material.dart';

/// Horizontal gold lines with a centered heart — uses [ColorScheme.tertiary].
class GoldHeartRule extends StatelessWidget {
  const GoldHeartRule({super.key});

  @override
  Widget build(BuildContext context) {
    final gold = Theme.of(context).colorScheme.tertiary;

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

/// Standalone gold heart accent — uses [ColorScheme.tertiary].
class SingleGoldHeart extends StatelessWidget {
  const SingleGoldHeart({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_rounded,
      size: 11,
      color: Theme.of(context).colorScheme.tertiary,
    );
  }
}
