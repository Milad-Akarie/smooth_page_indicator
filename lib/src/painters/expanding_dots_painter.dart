import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/expanding_dots_effect.dart';

import 'indicator_painter.dart';

class ExpandingDotsPainter extends IndicatorPainter {
  final ExpandingDotsEffect effect;

  ExpandingDotsPainter({
    @required double offset,
    @required this.effect,
    @required int count,
    @required bool isRTL,
  }) : super(offset, count, effect, isRTL);

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
    double drawingOffset = -effect.spacing;
    final dotOffset = offset - current;

    for (int i = 0; i < count; i++) {
      Color color = effect.dotColor;
      final activeDotWidth = effect.dotWidth * effect.expansionFactor;
      final expansion =
          (dotOffset / 2 * ((activeDotWidth - effect.dotWidth) / .5));
      final xPos = drawingOffset + effect.spacing;
      double width = effect.dotWidth;
      if (i == current) {
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset);
        width = activeDotWidth - expansion;
      } else if (i - 1 == current) {
        width = effect.dotWidth + expansion;
        color =
            Color.lerp(effect.activeDotColor, effect.dotColor, 1.0 - dotOffset);
      }
      final yPos = size.height / 2;
      final rRect = RRect.fromLTRBR(
        xPos,
        yPos - effect.dotHeight / 2,
        xPos + width,
        yPos + effect.dotHeight / 2,
        dotRadius,
      );
      drawingOffset = rRect.right;
      canvas.drawRRect(rRect, dotPaint..color = color);
    }
  }
}
