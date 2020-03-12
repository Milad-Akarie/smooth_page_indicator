import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/scrolling_dots_painter_insta.dart';

import 'indicator_effect.dart';

class ScrollingDotsEffect extends IndicatorEffect {
  // The active dot strokeWidth
  final double activeStrokeWidth;

  /// [activeDotScale] is multiplied by [dotWidth] to resolve
  /// active dot scaling
  final double activeDotScale;

  // must be an odd number
  final int maxVisibleDots;

  const ScrollingDotsEffect({
    this.activeStrokeWidth = 1.5,
    this.activeDotScale = 0.3,
    this.maxVisibleDots = 5,
    double offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    Color activeDotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activeStrokeWidth != null),
        assert(activeDotScale != null),
        assert(activeDotScale >= 0.0),
        assert(maxVisibleDots >= 3 && maxVisibleDots % 2 != 0),
        super(
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          spacing: spacing,
          radius: radius,
          strokeWidth: strokeWidth,
          paintStyle: paintStyle,
          dotColor: dotColor,
          activeDotColor: activeDotColor,
        );

  @override
  Size calculateSize(int count) {
    final dotNum = min(count, maxVisibleDots);
    // Add the scaled dot width to our size calculation
    final scaledWidth = dotWidth + (dotWidth * activeDotScale) - dotWidth;
//    return Size((dotWidth + spacing) * ((dotNum + 1)), dotHeight + scaledWidth);
    return Size((dotWidth + spacing) * ((dotNum)), dotHeight + scaledWidth);
  }

  @override
  IndicatorPainter buildPainter(int count, double offset, bool isRTL) {
    return ScrollingDotsPainterInsta(count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}
