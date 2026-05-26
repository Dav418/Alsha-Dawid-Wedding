import 'package:flutter/material.dart';

/// Scrollable page shell using slivers — decorations sit behind [CustomScrollView].
class ScenicPageBackground extends StatelessWidget {
  const ScenicPageBackground({
    super.key,
    required this.slivers,
    this.decorations = const [],
    this.bottomPadding = 32,
  });

  /// Single content block with standard page padding.
  ScenicPageBackground.content({
    super.key,
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(24, 16, 24, 0),
    this.decorations = const [],
    this.bottomPadding = 32,
  }) : slivers = [
          SliverPadding(
            padding: padding,
            sliver: SliverToBoxAdapter(child: child),
          ),
        ];

  final List<Widget> slivers;
  final List<Widget> decorations;
  final double bottomPadding;

  static const scrollPhysics = AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        ...decorations,
        CustomScrollView(
          physics: scrollPhysics,
          slivers: [
            ...slivers,
            SliverPadding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              sliver: const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
          ],
        ),
      ],
    );
  }
}
