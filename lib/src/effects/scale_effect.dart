import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/scale_painter.dart';

import 'indicator_effect.dart';

class ScaleEffect extends IndicatorEffect {
  final PaintingStyle activePaintStyle;
  final double activeStrokeWidth;
  final double scale;

  const ScaleEffect({
    this.activePaintStyle = PaintingStyle.fill,
    this.scale = 0.3,
    this.activeStrokeWidth = 1.0,
    double offset,
    bool isRTL = false,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 16.0,
    double radius = 16,
    Color dotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activePaintStyle != null),
        assert(scale != null),
        assert(activeStrokeWidth != null),
        super(
          isRTL: isRTL,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          spacing: spacing,
          radius: radius,
          strokeWidth: strokeWidth,
          paintStyle: paintStyle,
          dotColor: dotColor,
        );

  @override
  Size calculateSize(int count) {
    final scaledWidth = (dotWidth + (dotWidth * scale)) - dotWidth;
    return Size((dotWidth * count) + (spacing * (count - 1)) + scaledWidth,
        (dotHeight + scaledWidth));
  }

  @override
  IndicatorPainter buildPainter(int count, double offset) {
    return ScalePainter(count: count, offset: offset, effect: this);
  }
}
