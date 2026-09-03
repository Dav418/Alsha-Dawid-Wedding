import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../content/repositories/vendors_repository.dart';
import '../content/repositories/wedding_content_repository.dart';
import 'website_refresh_platform.dart';

part 'website_refresh.g.dart';

@riverpod
class WebsiteRefresh extends _$WebsiteRefresh {
  @override
  void build() {}

  Future<void> refresh() async {
    if (kIsWeb) {
      reloadWebsitePage();
      return;
    }

    ref.invalidate(weddingContentRepositoryProvider);
    ref.invalidate(vendorsRepositoryProvider);
    await Future.wait([
      ref.read(weddingContentRepositoryProvider.future),
      ref.read(vendorsRepositoryProvider.future),
    ]);
  }
}
