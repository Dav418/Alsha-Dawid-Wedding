import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';
import 'content/data/wedding_content.dart';
import 'content/repositories/wedding_content_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

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

  final weddingContent = await loadWeddingContentFromAssets();

  runApp(
    ProviderScope(
      overrides: [
        weddingContentRepositoryProvider.overrideWith(
          () => _PreloadedWeddingContentRepository(weddingContent),
        ),
      ],
      child: const WeddingWebsiteApp(),
    ),
  );
}

class _PreloadedWeddingContentRepository extends WeddingContentRepository {
  _PreloadedWeddingContentRepository(this._content);

  final WeddingContent _content;

  @override
  Future<WeddingContent> build() async => _content;
}
