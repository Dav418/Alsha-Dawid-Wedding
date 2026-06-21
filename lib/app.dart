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

    if (contentAsync.hasError) {
      final error = contentAsync.error!;
      return MaterialApp(
        key: const ValueKey('error-app'),
        title: 'Oops',
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
      );
    }

    final isLoading = contentAsync.isLoading;
    final content = contentAsync.valueOrNull;
    final siteTitle = content?.couple.siteTitle;

    return MaterialApp.router(
      key: const ValueKey('wedding-app'),
      title: siteTitle ?? 'Loading...',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        final routedChild = isLoading
            ? const SizedBox.shrink()
            : (child ?? const SizedBox.shrink());

        final app = Title(
          title: siteTitle ?? 'Loading...',
          color: Colors.black,
          child: routedChild,
        );

        if (!isLoading) {
          return app;
        }

        return Stack(
          children: [
            app,
            const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        );
      },
      routerConfig: router.config(
        navigatorObservers: () => [
          AutoRouteObserver(),
        ],
      ),
    );
  }
}
