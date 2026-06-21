import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../content/repositories/wedding_content_repository.dart';
import '../models/app/app_page.dart';
import '../models/shell/drawer_menu_entry.dart';
import '../providers/page_availability_provider.dart';
import '../utils/extension/context_extension.dart';

class WeddingDrawer extends ConsumerWidget {
  const WeddingDrawer({
    required this.routerContext,
    required this.onNavigate,
    super.key,
  });

  final BuildContext routerContext;
  final void Function(String routeName) onNavigate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveUpdatesUrl = ref
        .watch(weddingContentRepositoryProvider)
        .requireValue
        .links
        .liveUpdatesUrl;
    final availability = ref.watch(pageAvailabilityProvider);
    final menu = DrawerMenuEntry.partitionByAvailability(availability);

    final availableTiles = <Widget>[];
    for (final entry in menu.available) {
      availableTiles.add(
        entry.when(
          page: (page) => _Tile(
            page: page,
            routerContext: routerContext,
            onNavigate: onNavigate,
          ),
          liveUpdates: () => ListTile(
            title: Text(
              'LIVE UPDATES',
              style: context.textTheme.titleSmall?.copyWith(
                letterSpacing: 0.8,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () async {
              Navigator.of(context).pop();
              await context.openExternalUrl(Uri.parse(liveUpdatesUrl));
            },
          ),
        ),
      );
    }

    final underConstructionTiles = <Widget>[
      for (final entry in menu.underConstruction)
        entry.when(
          page: (page) => _Tile(
            page: page,
            routerContext: routerContext,
            onNavigate: onNavigate,
          ),
          liveUpdates: () => const SizedBox.shrink(),
        ),
    ];

    return Drawer(
      backgroundColor: context.colorScheme.surface,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: context.colorScheme.outlineVariant),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Menu',
                  style: context.textTheme.titleLarge?.copyWith(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            ...availableTiles,
            ...underConstructionTiles,
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.page,
    required this.routerContext,
    required this.onNavigate,
  });

  final AppPage page;
  final BuildContext routerContext;
  final void Function(String routeName) onNavigate;

  @override
  Widget build(BuildContext context) {
    final active = routerContext.router.current.name;
    final routeName = page.routeName;
    final selected = active == routeName;

    return ListTile(
        selected: selected,
        selectedTileColor:
            context.colorScheme.primaryContainer.withValues(alpha: 0.35),
        title: Text(
          page.displayName,
          style: context.textTheme.titleSmall?.copyWith(
            letterSpacing: 0.8,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        onTap: () {
          page.push(routerContext);
          Navigator.of(context).pop();
          onNavigate(routeName);
        });
  }
}
