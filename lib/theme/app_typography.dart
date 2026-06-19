import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  AppTypography._();

  static TextStyle scriptHero(
    ColorScheme scheme, {
    double fontSize = 52,
    double height = 1.05,
    Color? color,
  }) =>
      GoogleFonts.allura(
        fontSize: fontSize,
        height: height,
        color: color ?? scheme.primary,
      );

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

  static TextTheme textTheme(TextTheme base, ColorScheme scheme) {
    final montserrat = GoogleFonts.montserratTextTheme(base);
    final playfair = GoogleFonts.playfairDisplayTextTheme(montserrat);

    return playfair.copyWith(
      displayLarge: GoogleFonts.allura(
        fontSize: 56,
        color: scheme.onSurface,
      ),
      displayMedium: GoogleFonts.allura(
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
