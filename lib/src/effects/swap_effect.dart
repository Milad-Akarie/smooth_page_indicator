import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/swap_painter.dart';
import 'package:smooth_page_indicator/src/theme_defaults.dart';

import 'indicator_effect.dart';

/// Holds painting configuration to be used by [SwapPainter]
class SwapEffect extends BasicIndicatorEffect {
  /// The effect variant
  ///
  /// defaults to [SwapType.normal]
  final SwapType type;

  /// Default constructor
  const SwapEffect({
    super.activeDotColor,
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 8.0,
    super.radius = 16,
    super.dotColor,
    super.strokeWidth = 1.0,
    this.type = SwapType.normal,
    super.paintStyle = PaintingStyle.fill,
  });

  @override
  Size calculateSize(int count) {
    var height = dotHeight;
    if (type == SwapType.zRotation) {
      height += height * .2;
    } else if (type == SwapType.yRotation) {
      height += dotWidth + spacing;
    }
    return Size(dotWidth * count + (spacing * count), height);
  }

  @override
  IndicatorPainter buildPainter(
      int count, double offset, DefaultIndicatorColors indicatorColors) {
    return SwapPainter(
        count: count,
        offset: offset,
        effect: this,
        indicatorColors: indicatorColors);
  }

  @override
  SwapEffect lerp(covariant SwapEffect? other, double t) {
    if (other == null) return this;
    return SwapEffect(
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

/// The swap effect variants
enum SwapType {
  /// Swaps dots in the x axi (flat)
  normal,

  /// Swaps dots in the y axi with a rotation effect
  yRotation,

  /// Swaps dots in the x axi and scales active-dot (3d-ish)
  zRotation
}
