import 'package:freezed_annotation/freezed_annotation.dart';

part 'footer_nav_item.freezed.dart';

enum FooterNavAction {
  schedule,
  venueMap,
  liveUpdates,
}

@freezed
class FooterNavItem with _$FooterNavItem {
  const factory FooterNavItem({
    required FooterNavAction action,
    required String title,
  }) = _FooterNavItem;
}
