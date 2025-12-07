import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/worm_painter.dart';
import 'package:smooth_page_indicator/src/theme_defaults.dart';

import 'indicator_effect.dart';

/// Holds painting configuration to be used by [WormPainter]
class WormEffect extends BasicIndicatorEffect {
  /// The effect variant
  ///
  /// defaults to [WormType.normal]
  final WormType type;

  /// Default constructor
  const WormEffect({
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 8.0,
    super.radius = 16,
    super.dotColor,
    super.activeDotColor,
    super.strokeWidth = 1.0,
    super.paintStyle = PaintingStyle.fill,
    this.type = WormType.normal,
  });

  @override
  IndicatorPainter buildPainter(
      int count, double offset, DefaultIndicatorColors indicatorColors) {
    return WormPainter(
        count: count,
        offset: offset,
        effect: this,
        indicatorColors: indicatorColors);
  }

  @override
  WormEffect lerp(covariant WormEffect? other, double t) {
    if (other == null) return this;
    return WormEffect(
      type: t < 0.5 ? type : other.type,
      dotWidth: BasicIndicatorEffect.lerpDouble(dotWidth, other.dotWidth, t)!,
      dotHeight:
          BasicIndicatorEffect.lerpDouble(dotHeight, other.dotHeight, t)!,
      spacing: BasicIndicatorEffect.lerpDouble(spacing, other.spacing, t)!,
      radius: BasicIndicatorEffect.lerpDouble(radius, other.radius, t)!,
      dotColor: Color.lerp(dotColor, other.dotColor, t),
      activeDotColor: Color.lerp(activeDotColor, other.activeDotColor, t),
      strokeWidth:
          BasicIndicatorEffect.lerpDouble(strokeWidth, other.strokeWidth, t)!,
      paintStyle: t < 0.5 ? paintStyle : other.paintStyle,
    );
  }
}

/// The Worm effect variants
enum WormType {
  /// Draws normal worm animation
  normal,

  /// Draws a thin worm animation
  thin,

  /// Draws normal worm animation that looks like
  /// it's under the background
  underground,

  /// Draws a thing worm animation that looks like
  /// it's under the background
  thinUnderground,
}
