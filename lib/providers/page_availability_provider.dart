import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../content/repositories/wedding_content_repository.dart';
import '../models/app/app_page.dart';

part 'page_availability_provider.g.dart';

@riverpod
class PageAvailability extends _$PageAvailability {
  @override
  Map<AppPage, bool> build() {
    final permissions =
        ref.watch(weddingContentRepositoryProvider).requireValue.permissions;

    return {
      for (final page in AppPage.values)
        page: switch (permissions[page.name]) {
          final bool value => value,
          _ => throw StateError(
              'Missing or invalid permission for "${page.name}".',
            ),
        },
    };
  }

  void setWorking(AppPage page, bool isWorking) {
    state = {
      ...state,
      page: isWorking,
    };
  }
}

bool isPageWorking(
  Map<AppPage, bool> availability,
  AppPage page,
) {
  return availability[page]!;
}
