import 'package:freezed_annotation/freezed_annotation.dart';

part 'wedding_links.freezed.dart';
part 'wedding_links.g.dart';

@freezed
class WeddingLinks with _$WeddingLinks {
  const factory WeddingLinks({
    required String liveUpdatesUrl,
    required String venueMapQuery,
    required String rsvpUrl,
  }) = _WeddingLinks;

  factory WeddingLinks.fromJson(Map<String, dynamic> json) =>
      _$WeddingLinksFromJson(json);
}
