import 'package:flutter/material.dart';
import 'package:smooth_indicators/src/painters/indicator_painter.dart';
import 'package:smooth_indicators/src/painters/jumpting_dot_effect_painter.dart';

import 'indicator_effect.dart';

class JumpingDotEffect extends IndicatorEffect {
  final Color activeDotColor;
  final double elevation;

  const JumpingDotEffect({
    this.activeDotColor = Colors.indigo,
    this.elevation = 15.0,
    double offset,
    bool isRTL = false,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activeDotColor != null),
        assert(elevation != null),
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
  IndicatorPainter buildPainter(int count, double offset) {
    return JumpingDotPainter(count: count, offset: offset, effect: this);
  }
}
