import 'package:flutter/material.dart';

/// All named colors for the wedding UI — use these instead of inline [Color] literals.
///
/// Tuned to the **high-res home page** mockup (cream paper, dahlias, sage ribbons, gold seal).
abstract final class AppColors {
  AppColors._();

  /// Drives [ColorScheme.fromSeed]; aligns primary tones with the burgundy accent world.
  static const Color seed = burgundyAccent;

  /// Page background — textured cream paper.
  static const Color creamBackground = Color(0xFFF5F2ED);

  /// Ribbons, leaves, primary CTA button (“Enter our wedding”).
  static const Color sageGreen = Color(0xFF7A846B);

  /// Dahlias, couple names in script, deep floral accents.
  static const Color burgundyAccent = Color(0xFF5E1D24);

  /// Dusty rose / peach roses in florals.
  static const Color dustyRose = Color(0xFFD4A59A);

  /// Monogram wreath, hearts, candlesticks, seal details.
  static const Color goldBrass = Color(0xFFB59A5D);

  /// Body copy on cream (soft black).
  static const Color textCharcoal = Color(0xFF333333);

  /// Mauve from earlier iterations — keep if you need secondary UI accents.
  static const Color mauveLegacy = Color(0xFF6B4E71);
}
