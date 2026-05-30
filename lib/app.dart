import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router_provider.dart';
import 'theme/app_theme.dart';

class WeddingWebsiteApp extends ConsumerWidget {
  const WeddingWebsiteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Alisha & Dawid',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      routerConfig: router.config(
        navigatorObservers: () => [
          AutoRouteObserver(),
        ],
      ),
    );
  }
}
