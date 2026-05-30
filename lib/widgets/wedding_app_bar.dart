import 'package:flutter/material.dart';

import '../assets/home/wedding_assets.dart';

/// Collapsing [SliverAppBar] for the shell [CustomScrollView].
class WeddingAppBar extends StatelessWidget {
  const WeddingAppBar({super.key, required this.onHomeTap});

  final VoidCallback onHomeTap;

  static const expandedHeight = 136.0;

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;

    return SliverAppBar(
      pinned: true,
      expandedHeight: expandedHeight,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        tooltip: 'Open menu',
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _MonogramLockup(
                  height: (constraints.maxHeight - 48).clamp(34.0, 88.0),
                  onTap: onHomeTap,
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: appBarTheme.backgroundColor,
      foregroundColor: appBarTheme.foregroundColor,
      elevation: appBarTheme.elevation,
      scrolledUnderElevation: appBarTheme.scrolledUnderElevation,
      shadowColor: appBarTheme.shadowColor,
      surfaceTintColor: appBarTheme.surfaceTintColor,
    );
  }
}

class _MonogramLockup extends StatelessWidget {
  const _MonogramLockup({required this.height, required this.onTap});

  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Home',
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Image.asset(
              WeddingAssets.monogramAdWreath,
              height: height,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
