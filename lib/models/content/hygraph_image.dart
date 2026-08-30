import 'package:freezed_annotation/freezed_annotation.dart';

part 'hygraph_image.freezed.dart';
part 'hygraph_image.g.dart';

@freezed
class HygraphImage with _$HygraphImage {
  const factory HygraphImage({
    required String url,
  }) = _HygraphImage;

  factory HygraphImage.fromJson(Map<String, dynamic> json) =>
      _$HygraphImageFromJson(json);
}
