import 'package:freezed_annotation/freezed_annotation.dart';

import '../../config/strapi_config.dart';

part 'cms_image.freezed.dart';
part 'cms_image.g.dart';

@freezed
class CmsImage with _$CmsImage {
  const CmsImage._();

  const factory CmsImage({
    required String url,
  }) = _CmsImage;

  factory CmsImage.fromJson(Map<String, dynamic> json) =>
      _$CmsImageFromJson(json);

  String get absoluteUrl => StrapiConfig.mediaUrl(url);
}
