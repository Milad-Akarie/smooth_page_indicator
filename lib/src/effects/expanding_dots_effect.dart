import 'package:flutter/material.dart';
import 'package:smooth_indicators/src/painters/expanding_dots_painter.dart';
import 'package:smooth_indicators/src/painters/indicator_painter.dart';

import 'indicator_effect.dart';

class ExpandingDotsEffect extends IndicatorEffect {
  final double expansionFactor;

  const ExpandingDotsEffect({
    this.expansionFactor = 3,
    double offset,
    bool isRTL = false,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double vSpace = 16.0,
    double radius = 16,
    Color dotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(expansionFactor != null),
        assert(expansionFactor > 1),
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
    return Size(((fullWidth) * count) + (spacing * (count - 1)) * (expansionFactor - 1), fullHeight);
  }

  @override
  IndicatorPainter buildPainter(int count, double offset) {
    return ExpandingDotsPainter(count: count, offset: offset, effect: this);
  }
}
