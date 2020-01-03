import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/slide_effect.dart';

import 'indicator_painter.dart';

class SlidePainter extends IndicatorPainter {
  final SlideEffect effect;

  SlidePainter({
    @required this.effect,
    @required int count,
    @required double offset,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
    // paint still dots
    super.paint(canvas, size);

    final activeDotPainter = Paint()..color = effect.activeDotColor;
    final bounds = _calcBounds(size.height, offset);
    RRect activeDot = RRect.fromRectAndRadius(bounds, dotRadius);
    canvas.drawRRect(activeDot, activeDotPainter);
  }

  Rect _calcBounds(double canvasHeight, num i) {
    final xPos = effect.strokeWidth / 2 + (i * distance);
    final yPos = canvasHeight / 2;
    return Rect.fromLTRB(xPos, yPos - effect.dotHeight / 2,
        xPos + effect.dotWidth, yPos + effect.dotHeight / 2);
  }
}
