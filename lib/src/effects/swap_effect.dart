import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/swap_painter.dart';

import 'indicator_effect.dart';

/// Holds painting configuration to be used by [SwapPainter]
class SwapEffect extends BasicIndicatorEffect {
  /// The effect variant
  ///
  /// defaults to [SwapType.normal]
  final SwapType type;

  /// Default constructor
  const SwapEffect({
    super.activeDotColor = Colors.indigo,
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 8.0,
    super.radius = 16,
    super.dotColor = Colors.grey,
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
  IndicatorPainter buildPainter(int count, double offset) {
    return SwapPainter(count: count, offset: offset, effect: this);
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
