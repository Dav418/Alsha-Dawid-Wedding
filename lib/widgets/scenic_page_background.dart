import 'package:flutter/material.dart';

/// Decoration layer behind [child]. Scroll/safe-area live in the page when needed.
class ScenicPageBackground extends StatelessWidget {
  const ScenicPageBackground({
    super.key,
    required this.child,
    this.decorations = const [],
  });

  final Widget child;
  final List<Widget> decorations;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        ...decorations,
        Positioned.fill(child: child),
      ],
    );
  }
}
