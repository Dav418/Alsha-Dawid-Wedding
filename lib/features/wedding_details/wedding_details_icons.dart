import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Gold line-art icons for the wedding details cards.
class WeddingDetailsIcon extends StatelessWidget {
  const WeddingDetailsIcon({
    super.key,
    required this.variant,
    this.size = 78,
    this.color = AppColors.goldBrass,
  });

  final WeddingDetailsIconVariant variant;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: switch (variant) {
          WeddingDetailsIconVariant.church => _ChurchIconPainter(color: color),
          WeddingDetailsIconVariant.manor => _ManorIconPainter(color: color),
          WeddingDetailsIconVariant.dress => _DressIconPainter(color: color),
          WeddingDetailsIconVariant.car => _CarIconPainter(color: color),
        },
      ),
    );
  }
}

enum WeddingDetailsIconVariant { church, manor, dress, car }

abstract class _LineIconPainter extends CustomPainter {
  _LineIconPainter({required this.color});

  final Color color;

  Paint strokePaint(double size) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = size * 0.028
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  void drawArch(
    Canvas canvas,
    Paint paint,
    Rect rect, {
    bool clockwise = false,
  }) {
    final path = Path()
      ..moveTo(rect.left, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.width / 2)
      ..arcToPoint(
        Offset(rect.right, rect.top + rect.width / 2),
        radius: Radius.circular(rect.width / 2),
        clockwise: clockwise,
      )
      ..lineTo(rect.right, rect.bottom);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _LineIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _ChurchIconPainter extends _LineIconPainter {
  _ChurchIconPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint(size.width);
    final w = size.width;
    final h = size.height;

    canvas.drawLine(Offset(w * 0.5, h * 0.03), Offset(w * 0.5, h * 0.11), paint);
    canvas.drawLine(Offset(w * 0.44, h * 0.07), Offset(w * 0.56, h * 0.07), paint);

    final steeple = Path()
      ..moveTo(w * 0.34, h * 0.36)
      ..lineTo(w * 0.5, h * 0.11)
      ..lineTo(w * 0.66, h * 0.36);
    canvas.drawPath(steeple, paint);

    canvas.drawLine(Offset(w * 0.1, h * 0.36), Offset(w * 0.9, h * 0.36), paint);

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.1, h * 0.36, w * 0.8, h * 0.54),
      Radius.circular(w * 0.02),
    );
    canvas.drawRRect(body, paint);

    drawArch(
      canvas,
      paint,
      Rect.fromLTWH(w * 0.37, h * 0.58, w * 0.26, h * 0.28),
    );

    drawArch(
      canvas,
      paint,
      Rect.fromLTWH(w * 0.16, h * 0.46, w * 0.14, h * 0.16),
    );
    drawArch(
      canvas,
      paint,
      Rect.fromLTWH(w * 0.7, h * 0.46, w * 0.14, h * 0.16),
    );
  }
}

class _ManorIconPainter extends _LineIconPainter {
  _ManorIconPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint(size.width);
    final w = size.width;
    final h = size.height;

    final roof = Path()
      ..moveTo(w * 0.08, h * 0.34)
      ..lineTo(w * 0.5, h * 0.1)
      ..lineTo(w * 0.92, h * 0.34);
    canvas.drawPath(roof, paint);

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.08, h * 0.34, w * 0.84, h * 0.56),
      Radius.circular(w * 0.02),
    );
    canvas.drawRRect(body, paint);

    final centerBlock = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.36, h * 0.22, w * 0.28, h * 0.18),
      Radius.circular(w * 0.015),
    );
    canvas.drawRRect(centerBlock, paint);

    canvas.drawLine(Offset(w * 0.08, h * 0.52), Offset(w * 0.92, h * 0.52), paint);

    drawArch(
      canvas,
      paint,
      Rect.fromLTWH(w * 0.41, h * 0.56, w * 0.18, h * 0.22),
    );

    canvas.drawLine(Offset(w * 0.2, h * 0.56), Offset(w * 0.2, h * 0.68), paint);
    canvas.drawLine(Offset(w * 0.8, h * 0.56), Offset(w * 0.8, h * 0.68), paint);

    final heart = Path()
      ..moveTo(w * 0.5, h * 0.66)
      ..cubicTo(
        w * 0.44,
        h * 0.58,
        w * 0.38,
        h * 0.64,
        w * 0.5,
        h * 0.74,
      )
      ..cubicTo(
        w * 0.62,
        h * 0.64,
        w * 0.56,
        h * 0.58,
        w * 0.5,
        h * 0.66,
      );
    canvas.drawPath(heart, paint);
  }
}

class _DressIconPainter extends _LineIconPainter {
  _DressIconPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint(size.width);
    final w = size.width;
    final h = size.height;

    final bodice = Path()
      ..moveTo(w * 0.36, h * 0.14)
      ..lineTo(w * 0.64, h * 0.14)
      ..lineTo(w * 0.68, h * 0.34)
      ..lineTo(w * 0.32, h * 0.34)
      ..close();
    canvas.drawPath(bodice, paint);

    final skirt = Path()
      ..moveTo(w * 0.32, h * 0.34)
      ..quadraticBezierTo(w * 0.18, h * 0.62, w * 0.14, h * 0.9)
      ..lineTo(w * 0.86, h * 0.9)
      ..quadraticBezierTo(w * 0.82, h * 0.62, w * 0.68, h * 0.34);
    canvas.drawPath(skirt, paint);

    final bowLeft = Path()
      ..moveTo(w * 0.5, h * 0.36)
      ..quadraticBezierTo(w * 0.34, h * 0.28, w * 0.28, h * 0.38)
      ..quadraticBezierTo(w * 0.38, h * 0.42, w * 0.5, h * 0.36);
    canvas.drawPath(bowLeft, paint);

    final bowRight = Path()
      ..moveTo(w * 0.5, h * 0.36)
      ..quadraticBezierTo(w * 0.66, h * 0.28, w * 0.72, h * 0.38)
      ..quadraticBezierTo(w * 0.62, h * 0.42, w * 0.5, h * 0.36);
    canvas.drawPath(bowRight, paint);

    canvas.drawLine(Offset(w * 0.5, h * 0.14), Offset(w * 0.5, h * 0.08), paint);
    canvas.drawCircle(Offset(w * 0.5, h * 0.06), w * 0.025, paint);
  }
}

class _CarIconPainter extends _LineIconPainter {
  _CarIconPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint(size.width);
    final w = size.width;
    final h = size.height;

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.08, h * 0.48, w * 0.84, h * 0.24),
      Radius.circular(w * 0.05),
    );
    canvas.drawRRect(body, paint);

    final cabin = Path()
      ..moveTo(w * 0.28, h * 0.48)
      ..lineTo(w * 0.38, h * 0.28)
      ..lineTo(w * 0.68, h * 0.28)
      ..lineTo(w * 0.76, h * 0.48);
    canvas.drawPath(cabin, paint);

    canvas.drawLine(Offset(w * 0.46, h * 0.28), Offset(w * 0.46, h * 0.48), paint);
    canvas.drawLine(Offset(w * 0.6, h * 0.28), Offset(w * 0.6, h * 0.48), paint);

    canvas.drawCircle(Offset(w * 0.26, h * 0.76), w * 0.1, paint);
    canvas.drawCircle(Offset(w * 0.74, h * 0.76), w * 0.1, paint);
  }
}
