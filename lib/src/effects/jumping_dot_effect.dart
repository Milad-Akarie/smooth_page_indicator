import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/jumping_dot_painter.dart';

import 'indicator_effect.dart';

/// Holds painting configuration to be used by [JumpingDotPainter]
class JumpingDotEffect extends BasicIndicatorEffect {
  /// The maximum scale the dot will hit while jumping
  final double jumpScale;

  /// The vertical offset of the jumping dot
  final double verticalOffset;

  /// Default constructor
  const JumpingDotEffect({
    super.activeDotColor = Colors.indigo,
    this.jumpScale = 1.4,
    this.verticalOffset = 0.0,
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 8.0,
    super.radius = 16,
    super.dotColor = Colors.grey,
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
  IndicatorPainter buildPainter(int count, double offset) {
    return JumpingDotPainter(count: count, offset: offset, effect: this);
  }
}
