import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Paints a color change transition effect between active
/// and non-active dots
///
/// Live demo at
/// https://github.com/Milad-Akarie/smooth_page_indicator/blob/f7ee92e7413a31de77bfb487755d64a385d52a52/demo/color-transition.gif
class TransitionPainter extends BasicIndicatorPainter {
  /// The painting configuration
  final ColorTransitionEffect effect;

  /// Default constructor
  TransitionPainter({
    required this.effect,
    required int count,
    required double offset,
    required ThemeDefaults themeDefaults,
  }) : super(offset, count, effect, themeDefaults);

  @override
  void paint(Canvas canvas, Size size) {
    final current = offset.floor();
    final dotPaint = Paint()
      ..strokeWidth = effect.strokeWidth
      ..style = effect.paintStyle;

    final dotOffset = offset - current;
    for (var i = 0; i < count; i++) {
      var color = effectiveInactiveColor;
      if (i == current) {
        // ! Both a and b are non nullable
        color = Color.lerp(effectiveActiveColor, effectiveInactiveColor, dotOffset)!;
        dotPaint.strokeWidth = max(effect.activeStrokeWidth * (1 - dotOffset), effect.strokeWidth);
      } else if (i - 1 == current || (i == 0 && offset > count - 1)) {
        // ! Both a and b are non nullable
        dotPaint.strokeWidth = max(effect.activeStrokeWidth * dotOffset, effect.strokeWidth);
        color = Color.lerp(effectiveActiveColor, effectiveInactiveColor, 1.0 - dotOffset)!;
      } else {
        dotPaint.strokeWidth = effect.strokeWidth;
        color = effectiveInactiveColor;
      }

      final xPos = (i * distance);
      final yPos = size.height / 2;
      final rRect = RRect.fromLTRBR(
        xPos,
        yPos - effect.dotHeight / 2,
        xPos + effect.dotWidth,
        yPos + effect.dotHeight / 2,
        dotRadius,
      );
      canvas.drawRRect(rRect, dotPaint..color = color);
    }
  }
}
