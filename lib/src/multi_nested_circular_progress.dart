import 'package:flutter/material.dart';
import 'package:multi_nested_circular_progress/src/nested_rings_painter.dart';

class MultiNestedCircularProgress extends StatelessWidget {
  final double size;

  /// A list of progress values (0.0 → 1.0)
  final List<double> progresses;

  /// A list of ring colors (same length as progresses)
  final List<Color> colors;

  /// Thickness of each ring
  final double strokeWidth;

  /// Space between each ring
  final double gap;

  /// Widgets inside the center
  final Widget? child;

  ///Duration of Animation
  final int durationInMilliSeconds;

  const MultiNestedCircularProgress({
    super.key,
    required this.size,
    required this.progresses,
    required this.colors,
    this.strokeWidth = 5,
    this.durationInMilliSeconds = 900,

    this.gap = 15,
    this.child = const SizedBox.shrink(),
  }) : assert(progresses.length == colors.length,
            "Progress and color list must match");
            
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(progresses),
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: durationInMilliSeconds),
      curve: Curves.easeOut,
      builder: (context, animationValue, _) {
        // Apply animation multiplier to each progress
        final animatedProgresses =  progresses.map((p) => p * animationValue).toList();

        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: NestedRingsPainter(
                  progresses: animatedProgresses,  
                  colors: colors,
                  strokeWidth: strokeWidth,
                  gap: gap,
                ),
              ),

              LayoutBuilder(
                builder: (_, __) {
                  final totalRingThickness =
                      (progresses.length * strokeWidth) +
                      ((progresses.length - 1) * gap);

                  final innerSize =
                      size - (2 * totalRingThickness) - (2 * gap);

                  return SizedBox(
                    width: innerSize,
                    height: innerSize,
                    child: Center(child: child),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

}