import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/extension/string_extension.dart';

part 'wedding_event.freezed.dart';
part 'wedding_event.g.dart';

@freezed
class WeddingEvent with _$WeddingEvent {
  const WeddingEvent._();

  const factory WeddingEvent({
    required String dateDisplay,
    required String locationDisplay,
    required DateTime countdownUtc,
  }) = _WeddingEvent;

  factory WeddingEvent.fromJson(Map<String, dynamic> json) =>
      _$WeddingEventFromJson(json);

  String get weddingDate => dateDisplay.withSuperscriptOrdinals();
}
