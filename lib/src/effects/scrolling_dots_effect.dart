import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/scrolling_dots_painter.dart';

import 'indicator_effect.dart';

class ScrollingDotsEffect extends IndicatorEffect {
  // The active dot color
  final Color activeDotColor;

  // The active dot strokeWidth
  final double activeStrokeWidth;

  /// [activeDotScale] is multiplied by [dotWidth] to resolve
  /// active dot scaling
  final double activeDotScale;

  const ScrollingDotsEffect({
    this.activeDotColor = Colors.indigo,
    this.activeStrokeWidth = 1.5,
    this.activeDotScale = 0.3,
    double offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activeDotColor != null),
        assert(activeStrokeWidth != null),
        assert(activeDotScale != null),
        assert(activeDotScale >= 0.0),
        super(
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
    // Add the scaled dot width to our size calculation
    final scaledWidth = dotWidth + (dotWidth * activeDotScale) - dotWidth;
    return Size(
        (dotWidth + spacing) * ((count * 2) - 1), dotHeight + scaledWidth);
  }

  @override
  IndicatorPainter buildPainter(int count, double offset, bool isRTL) {
    return ScrollingDotsPainter(
        count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}
