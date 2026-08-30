import 'package:freezed_annotation/freezed_annotation.dart';

part 'wedding_couple.freezed.dart';
part 'wedding_couple.g.dart';

@freezed
class WeddingCouple with _$WeddingCouple {
  const WeddingCouple._();

  const factory WeddingCouple({
    required String partner1Name,
    required String partner2Name,
  }) = _WeddingCouple;

  factory WeddingCouple.fromJson(Map<String, dynamic> json) =>
      _$WeddingCoupleFromJson(json);

  String get siteTitle {
    final partner1First = partner1Name.split(' ').first;
    final partner2First = partner2Name.split(' ').first;

    return '$partner1First & $partner2First Wedding';
  }
}
