import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../widgets/line_icon.dart';

part 'footer_nav_item.freezed.dart';

@freezed
class FooterNavItem with _$FooterNavItem {
  const factory FooterNavItem({
    required String title,
    required String subtitle,
    required LineIconVariant icon,
    required PageRouteInfo<void> route,
  }) = _FooterNavItem;
}
