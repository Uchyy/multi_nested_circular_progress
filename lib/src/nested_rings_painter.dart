
import 'package:flutter/material.dart';

class NestedRingsPainter extends CustomPainter {
  final List<double> progresses;
  final List<Color> colors;
  final double strokeWidth;
  final double gap;

  NestedRingsPainter({
    required this.progresses,
    required this.colors,
    required this.strokeWidth,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    // Starting outer radius
    double radius = (size.width / 2) - strokeWidth / 2;

    for (int i = 0; i < progresses.length; i++) {
      final progress = progresses[i].clamp(0.0, 1.0);
      final color = colors[i];

      // Background ring
      final backgroundPaint = Paint()
        ..color = Colors.grey.shade300
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      // Progress ring
      final progressPaint = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      // Draw base circle
      canvas.drawCircle(center, radius, backgroundPaint);

      // Draw arc
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -90 * (3.14159 / 180),
        progress * 2 * 3.14159,
        false,
        progressPaint,
      );

      // Next ring goes inward
      radius -= (strokeWidth + gap);
    }
  }

  @override
  bool shouldRepaint(covariant NestedRingsPainter oldDelegate) {
    return oldDelegate.progresses != progresses ||
        oldDelegate.colors != colors;
  }
}
