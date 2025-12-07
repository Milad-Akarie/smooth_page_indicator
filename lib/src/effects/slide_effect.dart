import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/slide_painter.dart';
import 'package:smooth_page_indicator/src/theme_defaults.dart';

import 'indicator_effect.dart';

/// Holds painting configuration to be used by [SlidePainter]
class SlideEffect extends BasicIndicatorEffect {
  /// The effect variant
  ///
  /// defaults to [SlideType.normal]
  final SlideType type;

  /// Default constructor
  const SlideEffect({
    super.activeDotColor,
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 8.0,
    super.radius = 16,
    super.dotColor,
    super.strokeWidth = 1.0,
    super.paintStyle = PaintingStyle.fill,
    this.type = SlideType.normal,
  });

  @override
  IndicatorPainter buildPainter(int count, double offset, DefaultIndicatorColors indicatorColors) {
    return SlidePainter(count: count, offset: offset, effect: this, indicatorColors: indicatorColors);
  }

  @override
  SlideEffect lerp(covariant SlideEffect? other, double t) {
    if (other == null) return this;
    return SlideEffect(
      type: t < 0.5 ? type : other.type,
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

/// The Slide effect variants
enum SlideType {
  /// Paints regular dot sliding animation
  normal,

  /// Paints masked (under-layered) dot sliding animation
  slideUnder
}
