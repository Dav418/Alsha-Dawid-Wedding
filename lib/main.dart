import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Avoid font swaps during layout/animation on Flutter web.
  // Preload the exact families + weights used by AppTypography.
  await GoogleFonts.pendingFonts([
    GoogleFonts.alexBrush(),
    GoogleFonts.greatVibes(),
    GoogleFonts.montserrat(fontWeight: FontWeight.w400),
    GoogleFonts.montserrat(fontWeight: FontWeight.w500),
    GoogleFonts.montserrat(fontWeight: FontWeight.w600),
    GoogleFonts.montserrat(fontWeight: FontWeight.w700),
    GoogleFonts.playfairDisplay(fontWeight: FontWeight.w400),
    GoogleFonts.playfairDisplay(fontWeight: FontWeight.w500),
    GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
  ]);

  runApp(
    const ProviderScope(
      child: WeddingWebsiteApp(),
    ),
  );
}
