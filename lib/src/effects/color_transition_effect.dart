import 'package:flutter/material.dart';

import '../painters/color_transition_painter.dart';
import '../painters/indicator_painter.dart';
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
    super.dotColor = Colors.grey,
    super.activeDotColor = Colors.indigo,
    super.strokeWidth = 1.0,
    super.paintStyle = PaintingStyle.fill,
  });

  @override
  IndicatorPainter buildPainter(int count, double offset) {
    return TransitionPainter(count: count, offset: offset, effect: this);
  }
}
