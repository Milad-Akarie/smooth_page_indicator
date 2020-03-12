import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/color_transition_painter.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';

import 'indicator_effect.dart';

class ColorTransitionEffect extends IndicatorEffect {
  // The active dot strokeWidth
  final double activeStrokeWidth;

  const ColorTransitionEffect({
    this.activeStrokeWidth = 1.5,
    double offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    Color activeDotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activeDotColor != null),
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
  IndicatorPainter buildPainter(int count, double offset, bool isRTL) {
    return TransitionPainter(count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}
