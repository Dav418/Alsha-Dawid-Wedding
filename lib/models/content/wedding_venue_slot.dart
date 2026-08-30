import 'package:freezed_annotation/freezed_annotation.dart';

part 'wedding_venue_slot.freezed.dart';
part 'wedding_venue_slot.g.dart';

@freezed
class WeddingVenueSlot with _$WeddingVenueSlot {
  const factory WeddingVenueSlot({
    required String time,
    required List<String> addressLines,
  }) = _WeddingVenueSlot;

  factory WeddingVenueSlot.fromJson(Map<String, dynamic> json) =>
      _$WeddingVenueSlotFromJson(json);
}
