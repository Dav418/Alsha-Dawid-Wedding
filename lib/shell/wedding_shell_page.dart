import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../widgets/wedding_app_bar.dart';
import '../widgets/wedding_drawer.dart';

@RoutePage()
class WeddingShellPage extends StatelessWidget {
  const WeddingShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (routerContext, child) {
        return Scaffold(
          drawer: WeddingDrawer(routerContext: routerContext),
          appBar: const WeddingAppBar(),
          body: child,
        );
      },
    );
  }
}
