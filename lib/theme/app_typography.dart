import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Fonts aligned to the concept art. **Couple names** use script (not serif) on the home hero.
///
/// **Similar Google Fonts** (all free via `google_fonts`):
/// - **[Alex Brush](https://fonts.google.com/specimen/Alex+Brush)** — default for names; thin
///   brush strokes, closest overall to delicate invite script.
/// - **[Great Vibes](https://fonts.google.com/specimen/Great+Vibes)** — more swash/flourish;
///   reads more “dramatic.”
/// - **[Allura](https://fonts.google.com/specimen/Allura)** — slightly more formal, upright.
/// - **[Pinyon Script](https://fonts.google.com/specimen/Pinyon+Script)** — finer hairlines,
///   vintage formal.
///
/// **Exact font ID:** crop the names → [WhatTheFont](https://www.myfonts.com/pages/whatthefont).
abstract final class AppTypography {
  AppTypography._();

  /// Couple names — flowing script (hero card). Uses **Alex Brush** (switch to
  /// `GoogleFonts.greatVibes` / `allura` / `pinyonScript` here if you prefer).
  static TextStyle names(ColorScheme scheme) => GoogleFonts.alexBrush(
        fontSize: 40,
        height: 1.2,
        color: AppColors.burgundyAccent,
      );

  /// Section titles — high-contrast serif (“Our Story”, “Wedding Details”).
  static TextStyle sectionTitle(ColorScheme scheme) =>
      GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: scheme.onSurface,
      );

  /// Nav / caps labels / countdown numerals — clean sans.
  static TextStyle labelCaps(ColorScheme scheme) => GoogleFonts.montserrat(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
        color: scheme.onSurface,
      );

  /// Date & venue lines under names — readable sans, not script.
  static TextStyle metaLine(ColorScheme scheme) => GoogleFonts.montserrat(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
        color: AppColors.textCharcoal.withValues(alpha: 0.85),
      );

  /// Small supporting line (“Together with their families”).
  static TextStyle overlineMuted(ColorScheme scheme) => GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.4,
        color: scheme.onSurface.withValues(alpha: 0.65),
      );

  /// Builds a full [TextTheme] from Material baseline + Google Fonts.
  static TextTheme textTheme(TextTheme base, ColorScheme scheme) {
    final montserrat = GoogleFonts.montserratTextTheme(base);
    final playfair = GoogleFonts.playfairDisplayTextTheme(montserrat);

    return playfair.copyWith(
      displayLarge: GoogleFonts.alexBrush(
        fontSize: 56,
        color: scheme.onSurface,
      ),
      displayMedium: GoogleFonts.alexBrush(
        fontSize: 44,
        color: scheme.onSurface,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: scheme.onSurface,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: scheme.onSurface,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 16,
        height: 1.5,
        color: AppColors.textCharcoal,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 14,
        height: 1.45,
        color: AppColors.textCharcoal,
      ),
      labelLarge: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: scheme.onSurface,
      ),
    );
  }
}
