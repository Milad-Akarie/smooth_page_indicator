import 'package:flutter/material.dart';

import '../painters/color_transition_painter.dart';
import '../painters/indicator_painter.dart';
import '../theme_defaults.dart';
import 'indicator_effect.dart';

/// Holds painting configuration to be used by [TransitionPainter]
class ColorTransitionEffect extends BasicIndicatorEffect {
  /// The active dot strokeWidth
  final double activeStrokeWidth;

  /// Default constructor
  const ColorTransitionEffect({
    this.activeStrokeWidth = 1.5,
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 8.0,
    super.radius = 16,
    super.dotColor,
    super.activeDotColor,
    super.strokeWidth = 1.0,
    super.paintStyle = PaintingStyle.fill,
  });

  @override
  IndicatorPainter buildPainter(int count, double offset, DefaultIndicatorColors indicatorColors) {
    return TransitionPainter(
      count: count,
      offset: offset,
      effect: this,
      indicatorColors: indicatorColors,
    );
  }

  @override
  ColorTransitionEffect lerp(covariant ColorTransitionEffect? other, double t) {
    if (other == null) return this;
    return ColorTransitionEffect(
      activeStrokeWidth: BasicIndicatorEffect.lerpDouble(activeStrokeWidth, other.activeStrokeWidth, t)!,
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
