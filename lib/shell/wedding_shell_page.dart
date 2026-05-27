import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../features/home/home_page.dart';
import '../widgets/wedding_app_bar.dart';
import '../widgets/wedding_drawer.dart';

const _scrollPhysics = AlwaysScrollableScrollPhysics(
  parent: BouncingScrollPhysics(),
);

@RoutePage()
class WeddingShellPage extends StatelessWidget {
  const WeddingShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      builder: (routerContext, child) {
        return _WeddingShellScaffold(
          routerContext: routerContext,
          child: child,
        );
      },
    );
  }
}

class _WeddingShellScaffold extends HookWidget {
  const _WeddingShellScaffold({
    required this.routerContext,
    required this.child,
  });

  final BuildContext routerContext;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    void goHome() {
      HomePage.push(routerContext);
      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
      }
    }

    return Scaffold(
      drawer: WeddingDrawer(routerContext: routerContext),
      body: CustomScrollView(
        controller: scrollController,
        physics: _scrollPhysics,
        slivers: [
          WeddingAppBar(onHomeTap: goHome),
          SliverToBoxAdapter(
            child: UnconstrainedBox(
              alignment: Alignment.topCenter,
              constrainedAxis: Axis.horizontal,
              clipBehavior: Clip.none,
              child: child,
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 32),
            sliver: SliverToBoxAdapter(child: SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}
