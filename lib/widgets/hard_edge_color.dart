import 'package:flutter/material.dart';

class HardEdgeColor extends StatelessWidget {
  const HardEdgeColor({
    required this.color,
    this.child,
    super.key,
  });

  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HardEdgeColorPainter(color),
      child: child ?? const SizedBox.expand(),
    );
  }
}

class _HardEdgeColorPainter extends CustomPainter {
  const _HardEdgeColorPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..isAntiAlias = false;

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(_HardEdgeColorPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
