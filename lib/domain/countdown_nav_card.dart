import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../features/countdown/countdown_nav_icons.dart';

part 'countdown_nav_card.freezed.dart';

@freezed
class CountdownNavCard with _$CountdownNavCard {
  const factory CountdownNavCard({
    required String title,
    required String subtitle,
    required CountdownNavIconVariant icon,
    required PageRouteInfo<void> route,
  }) = _CountdownNavCard;
}
