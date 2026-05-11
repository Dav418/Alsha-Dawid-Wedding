import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../assets/home/home_decor_assets.dart';
import '../../widgets/wedding_hero_invite_card.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (scaffoldContext) {
          return Center(
            child: WeddingHeroInviteCard(
              imageAssetPath: HomeDecorAssets.monogramAdWreath,
              child: _HomeInviteContent(
                onEnter: () => Scaffold.maybeOf(scaffoldContext)?.openDrawer(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HomeInviteContent extends StatelessWidget {
  const _HomeInviteContent({required this.onEnter});

  final VoidCallback onEnter;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text(
          'TOGETHER WITH THEIR FAMILIES',
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 12,
            height: 1.25,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.6,
            color: scheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Alisha Fernandes',
          textAlign: TextAlign.center,
          style: GoogleFonts.greatVibes(
            fontSize: 44,
            height: 1,
            color: scheme.primary,
          ),
        ),
        Text(
          '&',
          textAlign: TextAlign.center,
          style: GoogleFonts.greatVibes(
            fontSize: 36,
            height: 1,
            color: scheme.primary,
          ),
        ),
        Text(
          'Dawid Gorski',
          textAlign: TextAlign.center,
          style: GoogleFonts.greatVibes(
            fontSize: 44,
            height: 1,
            color: scheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        _GoldHeartRule(scheme: scheme),
        const SizedBox(height: 16),
        Text(
          '17 OCTOBER 2026',
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 16,
            height: 1.2,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            color: scheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        _SingleGoldHeart(scheme: scheme),
        const SizedBox(height: 10),
        Text(
          'RICKMANSWORTH, UK',
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 12,
            height: 1.25,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.6,
            color: scheme.primary,
          ),
        ),
        const SizedBox(height: 22),
        SizedBox(
          width: 174,
          height: 44,
          child: FilledButton(
            onPressed: onEnter,
            style: FilledButton.styleFrom(
              elevation: 3,
              shadowColor: scheme.shadow.withValues(alpha: 0.22),
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'ENTER OUR WEDDING',
              style: GoogleFonts.playfairDisplay(
                fontSize: 12.5,
                height: 1,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.6,
                color: scheme.onSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GoldHeartRule extends StatelessWidget {
  const _GoldHeartRule({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final gold = scheme.tertiary;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: gold.withValues(alpha: 0.55),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.favorite_rounded,
            size: 10,
            color: gold,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: gold.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}

class _SingleGoldHeart extends StatelessWidget {
  const _SingleGoldHeart({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_rounded,
      size: 11,
      color: scheme.tertiary,
    );
  }
}
