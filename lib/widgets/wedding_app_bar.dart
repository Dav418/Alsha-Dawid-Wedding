import 'package:flutter/material.dart';

/// Compact app bar with a burger control that opens [Scaffold.drawer].
class WeddingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WeddingAppBar({
    super.key,
    this.title,
  });

  /// Optional title when you add names / lockup later.
  final Widget? title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        tooltip: 'Open menu',
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: title,
      centerTitle: false,
    );
  }
}
