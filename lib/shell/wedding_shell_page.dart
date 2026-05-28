import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../features/home/home_page.dart';
import '../router/app_router.gr.dart';
import '../theme/app_colors.dart';
import '../widgets/wedding_app_bar.dart';
import '../widgets/wedding_drawer.dart';
import '../widgets/wedding_footer.dart';

const _scrollPhysics = AlwaysScrollableScrollPhysics(
  parent: BouncingScrollPhysics(),
);

/// Height of the burgundy band revealed when bouncing past the bottom of the scroll.
double _bottomOverscrollBandHeight(BuildContext context) =>
    MediaQuery.sizeOf(context).height * 0.3;

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
    final activeRouteName = routerContext.router.current.name;
    final previousRouteName = useRef(activeRouteName);

    void scrollToTop() {
      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
      }
    }

    void scrollToTopAfterFrame() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToTop();
      });
    }

    useEffect(
      () {
        if (previousRouteName.value != activeRouteName) {
          previousRouteName.value = activeRouteName;
          scrollToTopAfterFrame();
        }

        return null;
      },
      [activeRouteName],
    );

    void goHome() {
      final isAlreadyHome = activeRouteName == HomeRoute.name;

      HomePage.push(routerContext);

      if (isAlreadyHome) {
        scrollToTopAfterFrame();
      }
    }

    void onNavigate(String routeName) {
      if (activeRouteName == routeName) {
        scrollToTopAfterFrame();
      }
    }

    return Scaffold(
      backgroundColor: AppColors.creamBackground,
      drawer: WeddingDrawer(
        routerContext: routerContext,
        onNavigate: onNavigate,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: AppColors.creamBackground),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: _bottomOverscrollBandHeight(context),
            child: const ColoredBox(color: AppColors.burgundyAccent),
          ),
          CustomScrollView(
            controller: scrollController,
            physics: _scrollPhysics,
            slivers: [
              WeddingAppBar(onHomeTap: goHome),
              SliverToBoxAdapter(
                child: ColoredBox(
                  color: AppColors.creamBackground,
                  child: _WeddingSectionTransition(
                    routeName: activeRouteName,
                    child: child,
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: WeddingFooter(
                  routerContext: routerContext,
                  onNavigate: onNavigate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeddingSectionTransition extends HookWidget {
  const _WeddingSectionTransition({
    required this.routeName,
    required this.child,
  });

  final String routeName;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 220),
      initialValue: 1,
    );

    final previousRouteName = useRef(routeName);

    final fadeAnimation = useMemoized(
      () => controller.drive(
        CurveTween(curve: Curves.easeOutCubic),
      ),
      [controller],
    );

    useEffect(
      () {
        if (previousRouteName.value != routeName) {
          previousRouteName.value = routeName;
          controller.forward(from: 0);
        }

        return null;
      },
      [routeName],
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: child,
    );
  }
}
