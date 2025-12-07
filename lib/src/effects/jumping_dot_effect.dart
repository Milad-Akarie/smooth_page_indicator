import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/jumping_dot_painter.dart';
import 'package:smooth_page_indicator/src/theme_defaults.dart';

import 'indicator_effect.dart';

/// Holds painting configuration to be used by [JumpingDotPainter]
class JumpingDotEffect extends BasicIndicatorEffect {
  /// The maximum scale the dot will hit while jumping
  final double jumpScale;

  /// The vertical offset of the jumping dot
  final double verticalOffset;

  /// Default constructor
  const JumpingDotEffect({
    super.activeDotColor,
    this.jumpScale = 1.4,
    this.verticalOffset = 0.0,
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 8.0,
    super.radius = 16,
    super.dotColor,
    super.strokeWidth = 1.0,
    super.paintStyle = PaintingStyle.fill,
  });

  @override
  Size calculateSize(int count) {
    return Size(
      dotWidth * count + (spacing * (count - 1)),
      max(dotHeight, dotHeight * jumpScale) + verticalOffset.abs(),
    );
  }

  @override
  IndicatorPainter buildPainter(int count, double offset, DefaultIndicatorColors indicatorColors) {
    return JumpingDotPainter(count: count, offset: offset, effect: this, indicatorColors: indicatorColors);
  }

  @override
  JumpingDotEffect lerp(covariant JumpingDotEffect? other, double t) {
    if (other == null) return this;
    return JumpingDotEffect(
      jumpScale: BasicIndicatorEffect.lerpDouble(jumpScale, other.jumpScale, t)!,
      verticalOffset: BasicIndicatorEffect.lerpDouble(verticalOffset, other.verticalOffset, t)!,
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
