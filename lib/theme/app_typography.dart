import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  AppTypography._();

  static TextStyle scriptHero({
    required Color color,
    double fontSize = 52,
    double height = 1.05,
  }) =>
      GoogleFonts.allura(
        fontSize: fontSize,
        height: height,
        color: color,
      );

  static TextStyle scriptQuote({
    required Color color,
    double fontSize = 30,
    double height = 1.35,
  }) =>
      GoogleFonts.greatVibes(
        fontSize: fontSize,
        height: height,
        color: color,
      );

  static TextStyle capsLabel({
    required Color color,
    double fontSize = 12,
    double letterSpacing = 2.6,
    double height = 1.25,
    FontWeight fontWeight = FontWeight.w600,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: height,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle sectionCaps({
    required Color color,
    double fontSize = 14,
    double letterSpacing = 2.2,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle bodySerif({
    required Color color,
    double fontSize = 15,
    double height = 1.55,
    FontWeight fontWeight = FontWeight.w400,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: height,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle countdownBannerTitle({
    required Color color,
    required double fontSize,
    bool compact = false,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1.3,
        fontWeight: FontWeight.w600,
        letterSpacing: compact ? 2.2 : 2.8,
        color: color,
      );

  static TextStyle countdownNumber({
    required Color color,
    required double fontSize,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle countdownUnit({
    required Color color,
    required double fontSize,
    bool compact = false,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: compact ? 1.4 : 1.8,
        color: color,
      );

  static TextStyle cardTitleCaps({
    required Color color,
    double fontSize = 13,
    double letterSpacing = 1.8,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle cardTime({
    required Color color,
    double fontSize = 20,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1.1,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle cardBody({
    required Color color,
    double fontSize = 14.5,
    double height = 1.45,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: height,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle navCardTitle({required Color color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 11,
        height: 1.15,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: color,
      );

  static TextStyle navCardSubtitle({required Color color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 10,
        height: 1.3,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle contactLine({required Color color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 15,
        height: 1.45,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle faqQuestion({required Color color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 12.5,
        height: 1.35,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.4,
        color: color,
      );

  static TextStyle faqToggle({required Color color}) => GoogleFonts.playfairDisplay(
        fontSize: 22,
        height: 1,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle faqAnswer({required Color color}) => GoogleFonts.playfairDisplay(
        fontSize: 14.5,
        height: 1.55,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle buttonLabel({
    required Color color,
    double fontSize = 12.5,
    double letterSpacing = 1.6,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        height: 1,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle timelineTitle({required Color color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 12.5,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.6,
        color: color,
      );

  static TextStyle timelineBody({required Color color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 14.5,
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle portraitName({required Color color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 13.5,
        height: 1.3,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle portraitInitials({required Color color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
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
