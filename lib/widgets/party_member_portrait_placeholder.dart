import 'package:flutter/material.dart';

import '../utils/extension/context_extension.dart';

/// Shown when a party member portrait asset is missing.
class PartyMemberPortraitPlaceholder extends StatelessWidget {
  const PartyMemberPortraitPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.dustyRose.withValues(alpha: 0.28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest.shortestSide;
          final iconSize = size * 0.52;
          final questionSize = (context.portraitInitials().fontSize ?? 28) * 0.62;

          return Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: iconSize,
                color: context.textCharcoal.withValues(alpha: 0.34),
              ),
              Positioned(
                right: size * 0.2,
                bottom: size * 0.16,
                child: Text(
                  '?',
                  style: context.portraitInitials().copyWith(
                    fontSize: questionSize,
                    color: context.textCharcoal.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
