import 'package:freezed_annotation/freezed_annotation.dart';

import 'food_course.dart';
import 'hygraph_image.dart';

part 'wedding_food_item.freezed.dart';
part 'wedding_food_item.g.dart';

@freezed
class WeddingFoodItem with _$WeddingFoodItem {
  const WeddingFoodItem._();

  const factory WeddingFoodItem({
    required String name,
    String? description,
    String? contains,
    String? allergens,
    String? spiceLevel,
    String? wikipediaUrl,
    String? course,
    HygraphImage? image,
  }) = _WeddingFoodItem;

  factory WeddingFoodItem.fromJson(Map<String, dynamic> json) =>
      _$WeddingFoodItemFromJson(json);

  FoodCourse? get parsedCourse => switch (course?.trim().toLowerCase()) {
        'starter' => FoodCourse.starter,
        'main' => FoodCourse.main,
        'dessert' => FoodCourse.dessert,
        _ => null,
      };

  String? get imageUrl {
    final value = image?.url.trim();

    if (value == null || value.isEmpty) {
      return null;
    }

    return value;
  }

  bool get hasDescription => description?.trim().isNotEmpty ?? false;

  bool get hasContains => contains?.trim().isNotEmpty ?? false;

  bool get hasAllergens => allergens?.trim().isNotEmpty ?? false;

  bool get hasSpiceLevel => spiceLevel?.trim().isNotEmpty ?? false;

  bool get hasWikipediaUrl => wikipediaUrl?.trim().isNotEmpty ?? false;
}
