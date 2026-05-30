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
/// - **[Pinyon Script](https://fonts.google.com/specimen/Pinyon Script)** — finer hairlines,
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

  /// Large script page titles (“Our Story”, “Welcome”).
  static TextStyle scriptHero(
    ColorScheme scheme, {
    double fontSize = 52,
    double height = 1.05,
    Color? color,
  }) =>
      GoogleFonts.greatVibes(
        fontSize: fontSize,
        height: height,
        color: color ?? scheme.primary,
      );

  /// Script couple names and ampersand on the home invite card.
  static TextStyle scriptName(
    ColorScheme scheme, {
    double fontSize = 44,
    double height = 1,
    Color? color,
  }) =>
      GoogleFonts.greatVibes(
        fontSize: fontSize,
        height: height,
        color: color ?? scheme.primary,
      );

  /// Script pull quotes and closing lines.
  static TextStyle scriptQuote(
    ColorScheme scheme, {
    double fontSize = 30,
    double height = 1.35,
    Color? color,
  }) =>
      GoogleFonts.greatVibes(
        fontSize: fontSize,
        height: height,
        color: color ?? scheme.primary,
      );

  /// Uppercase Playfair labels (“THE PEOPLE BY OUR SIDE”, date lines).
  static TextStyle capsLabel(
    ColorScheme scheme, {
    double fontSize = 12,
    double letterSpacing = 2.6,
    double height = 1.25,
    Color? color,
    FontWeight fontWeight = FontWeight.w600,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: height,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        color: color ?? scheme.onSurfaceVariant,
      );

  /// Section headings in all caps (“BRIDESMAIDS”, “CONTACT US”).
  static TextStyle sectionCaps(
    ColorScheme scheme, {
    double fontSize = 14,
    double letterSpacing = 2.2,
    Color? color,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing,
        color: color ?? scheme.primary,
      );

  /// Body copy in Playfair Display.
  static TextStyle bodySerif(
    ColorScheme scheme, {
    double fontSize = 15,
    double height = 1.55,
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: height,
        fontWeight: fontWeight,
        color: color ?? scheme.primary,
      );

  /// Countdown banner title and numerals.
  static TextStyle countdownBannerTitle(
    ColorScheme scheme, {
    required double fontSize,
    bool compact = false,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1.3,
        fontWeight: FontWeight.w600,
        letterSpacing: compact ? 2.2 : 2.8,
        color: scheme.primary,
      );

  static TextStyle countdownNumber(
    ColorScheme scheme, {
    required double fontSize,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1,
        fontWeight: FontWeight.w500,
        color: scheme.primary,
      );

  static TextStyle countdownUnit(
    ColorScheme scheme, {
    required double fontSize,
    bool compact = false,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: compact ? 1.4 : 1.8,
        color: scheme.primary.withValues(alpha: 0.85),
      );

  /// Detail / nav card typography.
  static TextStyle cardTitleCaps(
    ColorScheme scheme, {
    double fontSize = 13,
    double letterSpacing = 1.8,
    Color? color,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing,
        color: color ?? scheme.primary,
      );

  static TextStyle cardTime(
    ColorScheme scheme, {
    double fontSize = 20,
    Color? color,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1.1,
        fontWeight: FontWeight.w600,
        color: color ?? scheme.primary,
      );

  static TextStyle cardBody(
    ColorScheme scheme, {
    double fontSize = 14.5,
    double height = 1.45,
    Color? color,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: height,
        fontWeight: FontWeight.w400,
        color: color ?? scheme.primary.withValues(alpha: 0.92),
      );

  static TextStyle navCardTitle(ColorScheme scheme, {Color? color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 11,
        height: 1.15,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: color ?? scheme.tertiary,
      );

  static TextStyle navCardSubtitle(ColorScheme scheme, {Color? color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 10,
        height: 1.3,
        fontWeight: FontWeight.w400,
        color: color ?? scheme.primary.withValues(alpha: 0.9),
      );

  static TextStyle contactLine(ColorScheme scheme) =>
      GoogleFonts.playfairDisplay(
        fontSize: 15,
        height: 1.45,
        fontWeight: FontWeight.w400,
        color: scheme.onSurfaceVariant,
      );

  /// FAQ accordion typography.
  static TextStyle faqQuestion(ColorScheme scheme) =>
      GoogleFonts.playfairDisplay(
        fontSize: 12.5,
        height: 1.35,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.4,
        color: scheme.primary,
      );

  static TextStyle faqToggle(ColorScheme scheme) => GoogleFonts.playfairDisplay(
        fontSize: 22,
        height: 1,
        fontWeight: FontWeight.w400,
        color: scheme.primary.withValues(alpha: 0.75),
      );

  static TextStyle faqAnswer(ColorScheme scheme) => GoogleFonts.playfairDisplay(
        fontSize: 14.5,
        height: 1.55,
        fontWeight: FontWeight.w400,
        color: scheme.onSurfaceVariant,
      );

  static TextStyle buttonLabel(
    ColorScheme scheme, {
    double fontSize = 12.5,
    double letterSpacing = 1.6,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing,
        color: scheme.onPrimary,
      );

  /// Timeline entry typography.
  static TextStyle timelineTitle(ColorScheme scheme) =>
      GoogleFonts.playfairDisplay(
        fontSize: 12.5,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.6,
        color: scheme.primary,
      );

  static TextStyle timelineBody(ColorScheme scheme) =>
      GoogleFonts.playfairDisplay(
        fontSize: 14.5,
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: scheme.onSurfaceVariant,
      );

  static TextStyle portraitName(ColorScheme scheme) =>
      GoogleFonts.playfairDisplay(
        fontSize: 13.5,
        height: 1.3,
        fontWeight: FontWeight.w500,
        color: scheme.onSurface,
      );

  static TextStyle portraitInitials(ColorScheme scheme) =>
      GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: scheme.primary.withValues(alpha: 0.55),
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
