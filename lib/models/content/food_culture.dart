enum FoodCulture {
  polish,
  goan;

  String get displayName => switch (this) {
        FoodCulture.polish => 'POLISH',
        FoodCulture.goan => 'GOAN',
      };
}
