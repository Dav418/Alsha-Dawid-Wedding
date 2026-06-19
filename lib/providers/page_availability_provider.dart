import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/app_page.dart';

part 'page_availability_provider.g.dart';

@riverpod
class PageAvailability extends _$PageAvailability {
  @override
  Map<AppPage, bool> build() => Map.of(defaultPageAvailability);

  void setWorking(AppPage page, bool isWorking) {
    state = {
      ...state,
      page: isWorking,
    };
  }
}

bool isPageWorking(Map<AppPage, bool> availability, AppPage page) {
  return availability[page] ?? true;
}
