import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/expanding_dots_painter.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/theme_defaults.dart';

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
    super.activeDotColor,
    super.dotColor,
    super.strokeWidth = 1.0,
    super.paintStyle = PaintingStyle.fill,
  }) : assert(expansionFactor > 1);

  @override
  Size calculateSize(int count) {
    /// Add the expanded dot width to our size calculation
    return Size(((dotWidth + spacing) * (count - 1)) + (expansionFactor * dotWidth), dotHeight);
  }

  @override
  IndicatorPainter buildPainter(int count, double offset, DefaultIndicatorColors indicatorColors) {
    return ExpandingDotsPainter(count: count, offset: offset, effect: this, indicatorColors: indicatorColors);
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

  @override
  ExpandingDotsEffect lerp(covariant ExpandingDotsEffect? other, double t) {
    if (other == null) return this;
    return ExpandingDotsEffect(
      expansionFactor: BasicIndicatorEffect.lerpDouble(expansionFactor, other.expansionFactor, t)!,
      dotWidth: BasicIndicatorEffect.lerpDouble(dotWidth, other.dotWidth, t)!,
      dotHeight: BasicIndicatorEffect.lerpDouble(dotHeight, other.dotHeight, t)!,
      spacing: BasicIndicatorEffect.lerpDouble(spacing, other.spacing, t)!,
      radius: BasicIndicatorEffect.lerpDouble(radius, other.radius, t)!,
      dotColor: Color.lerp(dotColor, other.dotColor, t),
      activeDotColor: Color.lerp(activeDotColor, other.activeDotColor, t),
      strokeWidth: BasicIndicatorEffect.lerpDouble(strokeWidth, other.strokeWidth, t)!,
      paintStyle: t < 0.5 ? paintStyle : other.paintStyle,
    );
  }
}
