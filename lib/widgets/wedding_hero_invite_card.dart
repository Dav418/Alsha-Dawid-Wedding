import 'dart:async';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../domain/invite_card_shape.dart';

class WeddingHeroInviteCard extends StatefulWidget {
  const WeddingHeroInviteCard({
    required this.imageAssetPath,
    required this.child,
    super.key,
    this.maxWidth = 382,
    this.animateOnMount = true,
  });

  final String imageAssetPath;
  final Widget child;
  final double maxWidth;
  final bool animateOnMount;

  @override
  State<WeddingHeroInviteCard> createState() => _WeddingHeroInviteCardState();
}

class _WeddingHeroInviteCardState extends State<WeddingHeroInviteCard>
    with
        SingleTickerProviderStateMixin,
        AutoRouteAwareStateMixin<WeddingHeroInviteCard> {
  late final AnimationController _controller;

  int _animationToken = 0;

  static const _shape = InviteCardShape();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 760),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_playAnimation());
    });
  }

  @override
  void didUpdateWidget(covariant WeddingHeroInviteCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.imageAssetPath != widget.imageAssetPath ||
        oldWidget.animateOnMount != widget.animateOnMount) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(_playAnimation());
      });
    }
  }

  @override
  void didPush() {
    unawaited(_playAnimation());
  }

  @override
  void didPopNext() {
    unawaited(_playAnimation());
  }

  @override
  void didInitTabRoute(TabPageRoute? previousRoute) {
    unawaited(_playAnimation());
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {
    unawaited(_playAnimation());
  }

  Future<void> _playAnimation() async {
    if (!mounted) {
      return;
    }

    _animationToken++;
    final currentToken = _animationToken;

    if (!widget.animateOnMount) {
      _controller.value = 1;
      return;
    }

    _controller
      ..stop()
      ..value = 0;

    try {
      await precacheImage(
        AssetImage(widget.imageAssetPath),
        context,
      );
    } catch (_) {
      // Still run the animation if the image fails to precache.
    }

    if (!mounted || currentToken != _animationToken) {
      return;
    }

    await _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final card = Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widget.maxWidth),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: ClipPath(
                      clipper: const _InviteCardClipper(shape: _shape),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _InviteCardPainter(
                        shape: _shape,
                        paperFill: scheme.surface.withValues(alpha: 0.86),
                        outerFrame: scheme.outline.withValues(alpha: 0.95),
                        innerFrame:
                            scheme.outlineVariant.withValues(alpha: 0.7),
                        cardShadow: scheme.shadow.withValues(alpha: 0.16),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    height: 100,
                    child: Image.asset(
                      widget.imageAssetPath,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 132, 36, 28),
                    child: widget.child,
                  ),
                ],
              ),
            ),
          ),
        );

        if (!widget.animateOnMount || _controller.isCompleted) {
          return card;
        }

        final animationValue = _controller.value;

        final opacityProgress = (animationValue / 0.45).clamp(0.0, 1.0);
        final opacity = Curves.easeOut.transform(opacityProgress);

        final scale = TweenSequence<double>(
          [
            TweenSequenceItem(
              tween: Tween<double>(
                begin: 0.96,
                end: 1.018,
              ).chain(
                CurveTween(curve: Curves.easeOutCubic),
              ),
              weight: 70,
            ),
            TweenSequenceItem(
              tween: Tween<double>(
                begin: 1.018,
                end: 1,
              ).chain(
                CurveTween(curve: Curves.easeOut),
              ),
              weight: 30,
            ),
          ],
        ).transform(animationValue);

        final slideY = Tween<double>(
          begin: 8,
          end: 0,
        ).transform(
          Curves.easeOutCubic.transform(animationValue),
        );

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, slideY),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.center,
              filterQuality: FilterQuality.low,
              child: card,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationToken++;
    _controller.dispose();
    super.dispose();
  }
}

class _InviteCardPainter extends CustomPainter {
  const _InviteCardPainter({
    required this.shape,
    required this.paperFill,
    required this.outerFrame,
    required this.innerFrame,
    required this.cardShadow,
  });

  final InviteCardShape shape;
  final Color paperFill;
  final Color outerFrame;
  final Color innerFrame;
  final Color cardShadow;

  @override
  void paint(Canvas canvas, Size size) {
    final outerPath = _buildInvitePath(size, shape);

    final innerInset = 3.2;
    final innerShape = shape.inset(innerInset);
    final innerPath = _buildInvitePath(
      Size(size.width - innerInset * 2, size.height - innerInset * 2),
      innerShape,
    ).shift(Offset(innerInset, innerInset));

    canvas.drawShadow(
      outerPath,
      cardShadow,
      13,
      false,
    );

    canvas.drawPath(
      outerPath,
      Paint()
        ..color = paperFill
        ..style = PaintingStyle.fill
        ..isAntiAlias = true,
    );

    canvas.drawPath(
      outerPath,
      Paint()
        ..color = outerFrame
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..isAntiAlias = true,
    );

    canvas.drawPath(
      innerPath,
      Paint()
        ..color = innerFrame
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.75
        ..isAntiAlias = true,
    );
  }

  @override
  bool shouldRepaint(covariant _InviteCardPainter oldDelegate) {
    return oldDelegate.shape != shape ||
        oldDelegate.paperFill != paperFill ||
        oldDelegate.outerFrame != outerFrame ||
        oldDelegate.innerFrame != innerFrame ||
        oldDelegate.cardShadow != cardShadow;
  }
}

class _InviteCardClipper extends CustomClipper<Path> {
  const _InviteCardClipper({required this.shape});

  final InviteCardShape shape;

  @override
  Path getClip(Size size) {
    return _buildInvitePath(size, shape);
  }

  @override
  bool shouldReclip(covariant _InviteCardClipper oldClipper) {
    return oldClipper.shape != shape;
  }
}

Path _buildInvitePath(Size size, InviteCardShape shape) {
  final w = size.width;
  final h = size.height;
  final r = shape.cornerRadius;
  final sy = shape.shoulderY;
  final cx = w / 2;
  final archHalfWidth = shape.archWidth / 2;
  final archTopY = sy - shape.archHeight;

  final leftArchJoin = cx - archHalfWidth;
  final rightArchJoin = cx + archHalfWidth;

  return Path()
    ..moveTo(r, sy)
    ..lineTo(leftArchJoin, sy)
    ..cubicTo(
      cx - archHalfWidth * 0.55,
      archTopY,
      cx + archHalfWidth * 0.55,
      archTopY,
      rightArchJoin,
      sy,
    )
    ..lineTo(w - r, sy)
    ..quadraticBezierTo(w, sy, w, sy + r)
    ..lineTo(w, h - r)
    ..quadraticBezierTo(w, h, w - r, h)
    ..lineTo(r, h)
    ..quadraticBezierTo(0, h, 0, h - r)
    ..lineTo(0, sy + r)
    ..quadraticBezierTo(0, sy, r, sy)
    ..close();
}
