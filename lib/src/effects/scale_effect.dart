import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/scale_painter.dart';
import 'package:smooth_page_indicator/src/theme_defaults.dart';

import 'indicator_effect.dart';

/// Holds painting configuration to be used by [ScalePainter]
class ScaleEffect extends BasicIndicatorEffect {
  /// Inactive dots paint style (fill|stroke) defaults to fill.
  final PaintingStyle activePaintStyle;

  /// This is ignored if [activePaintStyle] is PaintStyle.fill
  final double activeStrokeWidth;

  /// [scale] is multiplied by [dotWidth] to resolve
  /// active dot scaling
  final double scale;

  /// Default constructor
  const ScaleEffect({
    super.activeDotColor,
    this.activePaintStyle = PaintingStyle.fill,
    this.scale = 1.4,
    this.activeStrokeWidth = 1.0,
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 10.0,
    super.radius = 16,
    super.dotColor,
    super.strokeWidth = 1.0,
    super.paintStyle = PaintingStyle.fill,
  });

  @override
  Size calculateSize(int count) {
    /// Add the scaled dot width to our size calculation
    final activeDotWidth = dotWidth * scale;
    final nonActiveCount = count - 1;
    return Size(
      (dotWidth * nonActiveCount) + (spacing * nonActiveCount) + activeDotWidth,
      activeDotWidth,
    );
  }

  @override
  IndicatorPainter buildPainter(
      int count, double offset, DefaultIndicatorColors indicatorColors) {
    return ScalePainter(
        count: count,
        offset: offset,
        effect: this,
        indicatorColors: indicatorColors);
  }

  @override
  ScaleEffect lerp(covariant ScaleEffect? other, double t) {
    if (other == null) return this;
    return ScaleEffect(
      activePaintStyle: t < 0.5 ? activePaintStyle : other.activePaintStyle,
      activeStrokeWidth: BasicIndicatorEffect.lerpDouble(
          activeStrokeWidth, other.activeStrokeWidth, t)!,
      scale: BasicIndicatorEffect.lerpDouble(scale, other.scale, t)!,
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
