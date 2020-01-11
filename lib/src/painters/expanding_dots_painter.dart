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
    double lastPos = -effect.spacing;
    final dotOffset = offset - offset.toInt();

    for (int i = 0; i < count; i++) {
      final active = i == current;
      final bool isNext = i - 1 == current;
      final bounds =
          _calcBounds(lastPos, size.height, i, active, isNext, dotOffset);
      lastPos = bounds.right;
      RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  Rect _calcBounds(double startingPoint, double canvasHeight, num i,
      bool isActive, bool isNext, double dotOffset) {
    final activeDotWidth = effect.dotWidth * effect.expansionFactor;
    final expansion =
        (dotOffset / 2 * ((activeDotWidth - effect.dotWidth) / .5));

    final xPos = startingPoint + effect.spacing;
    double width = effect.dotWidth;
    if (isActive) {
      width = activeDotWidth - expansion;
    } else if (isNext) {
      width = effect.dotWidth + expansion;
    }
    final yPos = canvasHeight / 2;
    return Rect.fromLTRB(xPos, yPos - effect.dotHeight / 2, xPos + width,
        yPos + effect.dotHeight / 2);
  }
}
