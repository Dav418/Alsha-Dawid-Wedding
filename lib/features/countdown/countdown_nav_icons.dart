import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Gold line-art icons for countdown page navigation cards.
class CountdownNavIcon extends StatelessWidget {
  const CountdownNavIcon({
    super.key,
    required this.variant,
    this.size = 52,
    this.color = AppColors.goldBrass,
  });

  final CountdownNavIconVariant variant;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: switch (variant) {
          CountdownNavIconVariant.calendar => _CalendarIconPainter(color: color),
          CountdownNavIconVariant.mapPin => _MapPinIconPainter(color: color),
          CountdownNavIconVariant.megaphone => _MegaphoneIconPainter(color: color),
        },
      ),
    );
  }
}

enum CountdownNavIconVariant { calendar, mapPin, megaphone }

abstract class _LineIconPainter extends CustomPainter {
  _LineIconPainter({required this.color});

  final Color color;

  Paint strokePaint(double size) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = size * 0.028
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  @override
  bool shouldRepaint(covariant _LineIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _CalendarIconPainter extends _LineIconPainter {
  _CalendarIconPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint(size.width);
    final w = size.width;
    final h = size.height;

    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.14, h * 0.2, w * 0.72, h * 0.68),
      Radius.circular(w * 0.05),
    );
    canvas.drawRRect(body, paint);

    canvas.drawLine(Offset(w * 0.14, h * 0.34), Offset(w * 0.86, h * 0.34), paint);

    canvas.drawLine(Offset(w * 0.3, h * 0.12), Offset(w * 0.3, h * 0.26), paint);
    canvas.drawLine(Offset(w * 0.7, h * 0.12), Offset(w * 0.7, h * 0.26), paint);

    canvas.drawLine(Offset(w * 0.34, h * 0.5), Offset(w * 0.66, h * 0.5), paint);
    canvas.drawLine(Offset(w * 0.34, h * 0.64), Offset(w * 0.58, h * 0.64), paint);

    final star = Path()
      ..moveTo(w * 0.72, h * 0.58)
      ..lineTo(w * 0.74, h * 0.64)
      ..lineTo(w * 0.8, h * 0.64)
      ..lineTo(w * 0.75, h * 0.68)
      ..lineTo(w * 0.77, h * 0.74)
      ..lineTo(w * 0.72, h * 0.7)
      ..lineTo(w * 0.67, h * 0.74)
      ..lineTo(w * 0.69, h * 0.68)
      ..lineTo(w * 0.64, h * 0.64)
      ..lineTo(w * 0.7, h * 0.64)
      ..close();
    canvas.drawPath(star, paint);
  }
}

class _MapPinIconPainter extends _LineIconPainter {
  _MapPinIconPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint(size.width);
    final w = size.width;
    final h = size.height;

    final pin = Path()
      ..moveTo(w * 0.5, h * 0.92)
      ..cubicTo(
        w * 0.18,
        h * 0.58,
        w * 0.18,
        h * 0.28,
        w * 0.5,
        h * 0.18,
      )
      ..cubicTo(
        w * 0.82,
        h * 0.28,
        w * 0.82,
        h * 0.58,
        w * 0.5,
        h * 0.92,
      );
    canvas.drawPath(pin, paint);

    canvas.drawCircle(Offset(w * 0.5, h * 0.38), w * 0.1, paint);
  }
}

class _MegaphoneIconPainter extends _LineIconPainter {
  _MegaphoneIconPainter({required super.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = strokePaint(size.width);
    final w = size.width;
    final h = size.height;

    final horn = Path()
      ..moveTo(w * 0.18, h * 0.42)
      ..lineTo(w * 0.46, h * 0.28)
      ..lineTo(w * 0.82, h * 0.16)
      ..lineTo(w * 0.82, h * 0.72)
      ..lineTo(w * 0.46, h * 0.6)
      ..close();
    canvas.drawPath(horn, paint);

    final handle = Path()
      ..moveTo(w * 0.24, h * 0.48)
      ..lineTo(w * 0.24, h * 0.72)
      ..quadraticBezierTo(w * 0.24, h * 0.82, w * 0.34, h * 0.82)
      ..lineTo(w * 0.42, h * 0.82);
    canvas.drawPath(handle, paint);

    canvas.drawLine(Offset(w * 0.86, h * 0.28), Offset(w * 0.94, h * 0.22), paint);
    canvas.drawLine(Offset(w * 0.86, h * 0.5), Offset(w * 0.96, h * 0.5), paint);
    canvas.drawLine(Offset(w * 0.86, h * 0.72), Offset(w * 0.94, h * 0.78), paint);
  }
}
