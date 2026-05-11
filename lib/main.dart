import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Avoid FOUT: home hero (and theme) use these families before first paint.
  await GoogleFonts.pendingFonts([
    GoogleFonts.playfairDisplay(),
    GoogleFonts.greatVibes(),
    GoogleFonts.montserrat(),
    GoogleFonts.alexBrush(),
    GoogleFonts.cormorantGaramond(),
  ]);
  runApp(const ProviderScope(child: WeddingInvoiceApp()));
}
