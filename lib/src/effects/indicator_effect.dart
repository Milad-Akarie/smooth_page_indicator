import 'package:flutter/material.dart';
import 'package:smooth_indicators/src/painters/indicator_painter.dart';

abstract class IndicatorEffect {
  final bool isRTL;
  final double dotWidth;
  final double dotHeight;
  final double spacing;
  final double radius;
  final Color dotColor;
  final PaintingStyle paintStyle;
  final double strokeWidth;

  const IndicatorEffect({
    @required this.strokeWidth,
    @required this.isRTL,
    @required this.dotWidth,
    @required this.dotHeight,
    @required this.spacing,
    @required this.radius,
    @required this.dotColor,
    @required this.paintStyle,
  })  : assert(isRTL != null),
        assert(radius != null),
        assert(dotColor != null || paintStyle != null || strokeWidth != null),
        assert(dotWidth != null),
        assert(dotHeight != null),
        assert(spacing != null),
        assert(dotWidth >= 0 && dotHeight >= 0 && spacing >= 0 && strokeWidth >= 0);

  IndicatorPainter buildPainter(int count, double offset);

  double get fullWidth => dotWidth + strokeWidth;
  double get fullHeight => dotHeight + strokeWidth;

  Size calculateSize(int count) {
    return Size(fullWidth * count + (spacing * (count - 1)), fullHeight);
  }
}
