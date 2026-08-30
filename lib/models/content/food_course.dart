enum FoodCourse {
  starter,
  main,
  dessert;

  String get displayName => switch (this) {
        FoodCourse.starter => 'STARTER',
        FoodCourse.main => 'MAIN',
        FoodCourse.dessert => 'DESSERT',
      };
}
