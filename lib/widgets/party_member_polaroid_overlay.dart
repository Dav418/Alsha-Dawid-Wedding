import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../models/content/wedding_content.dart';
import '../utils/cursed_text.dart';
import '../utils/extension/context_extension.dart';
import 'party_member_portrait_placeholder.dart';

/// Full-screen polaroid detail for a wedding party member portrait.
void showPartyMemberPolaroid(
  BuildContext context, {
  required WeddingPartyMember member,
  required String assetPath,
  required String cursedSeed,
}) {
  showGeneralDialog<void>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _PartyMemberPolaroidOverlay(
        member: member,
        assetPath: assetPath,
        cursedSeed: cursedSeed,
      );
    },
    // Animate only the polaroid inside the overlay; backdrop blur is full-screen.
    transitionBuilder: (context, animation, secondaryAnimation, child) => child,
  );
}

class _PartyMemberPolaroidOverlay extends StatelessWidget {
  const _PartyMemberPolaroidOverlay({
    required this.member,
    required this.assetPath,
    required this.cursedSeed,
  });

  final WeddingPartyMember member;
  final String assetPath;
  final String cursedSeed;

  @override
  Widget build(BuildContext context) {
    final routeAnimation =
        ModalRoute.of(context)?.animation ?? kAlwaysCompleteAnimation;
    final polaroidAnimation = CurvedAnimation(
      parent: routeAnimation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    final width = (MediaQuery.sizeOf(context).width * 0.78).clamp(240.0, 300.0);
    final imageHeight = width * 0.92;
    final displayName = member.hasName
        ? member.displayName
        : CursedText.name(seed: cursedSeed);
    final caption = member.hasBio
        ? member.bio!.trim()
        : CursedText.bio(seed: cursedSeed);

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: routeAnimation,
            builder: (context, _) {
              final t = Curves.easeOut.transform(routeAnimation.value);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: 12 * t,
                    sigmaY: 12 * t,
                  ),
                  child: ColoredBox(
                    color: context.textCharcoal.withValues(alpha: 0.32 * t),
                  ),
                ),
              );
            },
          ),
          FadeTransition(
            opacity: polaroidAnimation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.86, end: 1).animate(polaroidAnimation),
              child: SafeArea(
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: AnimatedBuilder(
                      animation: routeAnimation,
                      builder: (context, _) {
                        final t = Curves.easeOut.transform(routeAnimation.value);
                        return Transform.rotate(
                          angle: -0.025,
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                              color: context.polaroidWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: context.textCharcoal
                                      .withValues(alpha: 0.2 * t),
                                  blurRadius: 24,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            padding:
                                EdgeInsets.fromLTRB(12, 12, 12, width * 0.14),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: Image.asset(
                                    assetPath,
                                    width: width - 24,
                                    height: imageHeight,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => SizedBox(
                                      width: width - 24,
                                      height: imageHeight,
                                      child: const PartyMemberPortraitPlaceholder(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: width * 0.07),
                                Text(
                                  displayName,
                                  textAlign: TextAlign.center,
                                  style: member.hasName
                                      ? context.scriptQuote(
                                          fontSize: 26,
                                          height: 1.15,
                                        )
                                      : CursedText.polaroidNameStyle(
                                          context.colorScheme,
                                        ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  caption,
                                  textAlign: TextAlign.center,
                                  style: member.hasBio
                                      ? context.timelineBody().copyWith(
                                          fontSize: 13,
                                          height: 1.45,
                                          color: context.textCharcoal
                                              .withValues(alpha: 0.78),
                                        )
                                      : CursedText.polaroidBioStyle(
                                          context.colorScheme,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
