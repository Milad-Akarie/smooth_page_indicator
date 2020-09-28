import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/scale_painter.dart';

import 'indicator_effect.dart';

class ScaleEffect extends IndicatorEffect {
  // Inactive dots paint style (fill|stroke) defaults to fill.
  final PaintingStyle activePaintStyle;

  /// This is ignored if [activePaintStyle] is PaintStyle.fill
  final double activeStrokeWidth;

  /// [scale] is multiplied by [dotWidth] to resolve
  /// active dot scaling
  final double scale;

  final Color activeDotFillColor;

  const ScaleEffect({
    this.activeDotFillColor,
    Color activeDotColor = Colors.indigo,
    this.activePaintStyle = PaintingStyle.fill,
    this.scale = 1.4,
    this.activeStrokeWidth = 1.0,
    double offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 10.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activePaintStyle != null),
        assert(scale != null),
        assert(activeStrokeWidth != null),
        super(
            dotWidth: dotWidth,
            dotHeight: dotHeight,
            spacing: spacing,
            radius: radius,
            strokeWidth: strokeWidth,
            paintStyle: paintStyle,
            dotColor: dotColor,
            activeDotColor: activeDotColor);

  @override
  Size calculateSize(int count) {
    // Add the scaled dot width to our size calculation
    final scaledWidth = (dotWidth + (dotWidth * scale)) - dotWidth;
    return Size((dotWidth * count) + (spacing * (count - 1)) + scaledWidth,
        (dotHeight + scaledWidth));
  }

  @override
  IndicatorPainter buildPainter(int count, double offset) {
    return ScalePainter(count: count, offset: offset, effect: this);
  }
}
