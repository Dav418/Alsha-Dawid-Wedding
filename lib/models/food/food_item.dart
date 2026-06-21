import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_item.freezed.dart';

enum FoodCourse { starter, main, dessert }

enum FoodCulture { polish, goan }

@freezed
class FoodItem with _$FoodItem {
  const factory FoodItem({
    required String name,
    required String description,
    required String contains,
    required String allergens,
    required String spiceLevel,
    required String wikipediaUrl,
    String? imageAsset,
    required FoodCourse course,
    required FoodCulture culture,
  }) = _FoodItem;
}
