import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';

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
        assert(dotWidth >= 0 &&
            dotHeight >= 0 &&
            spacing >= 0 &&
            strokeWidth >= 0);

  IndicatorPainter buildPainter(int count, double offset);

  Size calculateSize(int count) {
    return Size(dotWidth * count + (spacing * (count - 1)), dotHeight);
  }
}
