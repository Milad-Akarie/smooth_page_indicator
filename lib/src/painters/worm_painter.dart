import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/worm_effect.dart';

import 'indicator_painter.dart';

class WormPainter extends IndicatorPainter {
  final WormEffect effect;

  WormPainter({
    required this.effect,
    required int count,
    required double offset,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
//    super.paint(canvas, size);
    // paint still dots
    paintStillDots(canvas, size);
    final activeDotPaint = Paint()..color = effect.activeDotColor;
    final dotOffset = offset - offset.toInt();
    final worm = _calcBounds(size.height, offset.floor(), dotOffset * 2);
    canvas.drawRRect(worm, activeDotPaint);
  }

  RRect _calcBounds(double canvasHeight, num i, double dotOffset) {
    final xPos = (i * distance);
    final yPos = canvasHeight / 2;
    var left = xPos;
    var right = xPos +
        effect.dotWidth +
        (dotOffset * (effect.dotWidth + effect.spacing));
    if (dotOffset > 1) {
      right = xPos + effect.dotWidth + (1 * (effect.dotWidth + effect.spacing));
      left = xPos + ((effect.spacing + effect.dotWidth) * (dotOffset - 1));
    }
    return RRect.fromLTRBR(
      left,
      yPos - effect.dotHeight / 2,
      right,
      yPos + effect.dotHeight / 2,
      dotRadius,
    );
  }
}
