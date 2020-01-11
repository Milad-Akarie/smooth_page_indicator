import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/effects/color_transition_effect.dart';

import 'indicator_painter.dart';

class TransitionPainter extends IndicatorPainter {
  final ColorTransitionEffect effect;

  TransitionPainter({
    @required this.effect,
    @required int count,
    @required double offset,
    @required bool isRTL,
  }) : super(offset, count, effect, isRTL);

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
    final dotPaint = Paint()
      ..strokeWidth = effect.strokeWidth
      ..style = effect.paintStyle;

    final dotOffset = offset - offset.toInt();

    for (int i = 0; i < count; i++) {
      Color color = effect.dotColor;
      if (i == current) {
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset);
      }
      if (i - 1 == current) {
        color =
            Color.lerp(effect.activeDotColor, effect.dotColor, 1.0 - dotOffset);
      }

      final bounds = _calcBounds(size.height, i);
      RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);

      canvas.drawRRect(rect, dotPaint..color = color);
    }
  }

  Rect _calcBounds(double canvasHeight, num i) {
    final xPos = (i * distance);
    final yPos = canvasHeight / 2;
    return Rect.fromLTRB(xPos, yPos - effect.dotHeight / 2,
        xPos + effect.dotWidth, yPos + effect.dotHeight / 2);
  }
}
