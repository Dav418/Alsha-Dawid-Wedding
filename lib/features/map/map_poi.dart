import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_poi.freezed.dart';

enum MapPoiCategory { hotel, pub }

@freezed
class MapPoi with _$MapPoi {
  const MapPoi._();

  const factory MapPoi({
    required String id,
    required String title,
    required String address,
    required String description,
    required double latitude,
    required double longitude,
    required String googleMapsUrl,
    required MapPoiCategory category,
  }) = _MapPoi;

  LatLng get latLng => LatLng(latitude, longitude);

  String get categoryLabel => switch (category) {
        MapPoiCategory.hotel => 'HOTEL',
        MapPoiCategory.pub => 'PUB & HOTEL',
      };
}
