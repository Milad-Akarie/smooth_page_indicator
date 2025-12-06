import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/expanding_dots_painter.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';

import 'indicator_effect.dart';

/// Holds painting configuration to be used by [ExpandingDotsPainter]
class ExpandingDotsEffect extends BasicIndicatorEffect {
  /// This is multiplied by [dotWidth] to calculate
  /// the width of the expanded dot.
  final double expansionFactor;

  /// Default constructor
  const ExpandingDotsEffect({
    this.expansionFactor = 3,
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 8.0,
    super.radius = 16.0,
    super.activeDotColor = Colors.indigo,
    super.dotColor = Colors.grey,
    super.strokeWidth = 1.0,
    super.paintStyle = PaintingStyle.fill,
  }) : assert(expansionFactor > 1);

  @override
  Size calculateSize(int count) {
    /// Add the expanded dot width to our size calculation
    return Size(((dotWidth + spacing) * (count - 1)) + (expansionFactor * dotWidth), dotHeight);
  }

  @override
  IndicatorPainter buildPainter(int count, double offset) {
    return ExpandingDotsPainter(count: count, offset: offset, effect: this);
  }

  @override
  int hitTestDots(double dx, int count, double current) {
    var anchor = -spacing / 2;
    for (var index = 0; index < count; index++) {
      var widthBound = (index == current ? (dotWidth * expansionFactor) : dotWidth) + spacing;
      if (dx <= (anchor += widthBound)) {
        return index;
      }
    }
    return -1;
  }
}
