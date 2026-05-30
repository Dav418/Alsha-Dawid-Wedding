import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Entry point for app theming — colors live in [AppColors], type roles in [AppTypography].
abstract final class AppTheme {
  static ThemeData get light => _build(brightness: Brightness.light);

  static ThemeData get dark => _build(brightness: Brightness.dark);

  static ThemeData _build({required Brightness brightness}) {
    final seeded = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: brightness,
    );
    final scheme = seeded.copyWith(
      surface: brightness == Brightness.light
          ? AppColors.creamBackground
          : seeded.surface,
      primary: AppColors.burgundyAccent,
      secondary: AppColors.sageGreen,
      tertiary: AppColors.goldBrass,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      visualDensity: VisualDensity.standard,
      scaffoldBackgroundColor: brightness == Brightness.light
          ? AppColors.creamBackground
          : scheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        shadowColor: brightness == Brightness.light
            ? AppColors.textCharcoal.withValues(alpha: 0.14)
            : Colors.black.withValues(alpha: 0.35),
        backgroundColor: brightness == Brightness.light
            ? AppColors.creamBackground
            : scheme.surface,
        foregroundColor: brightness == Brightness.light
            ? AppColors.textCharcoal
            : scheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.sageGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
    );

    return base.copyWith(
      textTheme: AppTypography.textTheme(base.textTheme, scheme),
    );
  }
}
