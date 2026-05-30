import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'content/repositories/wedding_content_repository.dart';
import 'router/app_router_provider.dart';
import 'theme/app_theme.dart';

class WeddingWebsiteApp extends ConsumerWidget {
  const WeddingWebsiteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterControllerProvider);
    final contentAsync = ref.watch(weddingContentRepositoryProvider);

    return contentAsync.when(
      loading: () => MaterialApp(
        theme: AppTheme.light,
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, _) => MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Could not load wedding content.\n$error',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      data: (content) => MaterialApp.router(
        title: content.couple.siteTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        themeMode: ThemeMode.light,
        routerConfig: router.config(
          navigatorObservers: () => [
            AutoRouteObserver(),
          ],
        ),
      ),
    );
  }
}
