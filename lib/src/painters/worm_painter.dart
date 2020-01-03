import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/worm_effect.dart';

import 'indicator_painter.dart';

class WormPainter extends IndicatorPainter {
  final WormEffect effect;

  WormPainter({
    @required this.effect,
    @required int count,
    @required double offset,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
    // paint still dots
    super.paint(canvas, size);
    final activeDotPaint = Paint()..color = effect.activeDotColor;
    final dotOffset = offset - offset.toInt();
    final bounds = _calcBounds(offset.floor(), dotOffset * 2);
    final worm = RRect.fromLTRBR(
        bounds.left, bounds.top, bounds.right, bounds.bottom, dotRadius);
    canvas.drawRRect(worm, activeDotPaint);
  }

  Rect _calcBounds(num i, [double dotOffset = 0]) {
    final xPos = (i * distance);
    final yPos = (effect.dotHeight) / 2;
    double left = xPos;
    double right = xPos +
        effect.dotWidth +
        (dotOffset * (effect.dotWidth + effect.spacing));
    if (dotOffset > 1) {
      right = xPos + effect.dotWidth + (1 * (effect.dotWidth + effect.spacing));
      left = xPos + ((effect.spacing + effect.dotWidth) * (dotOffset - 1));
    }
    return Rect.fromLTRB(
        left, yPos - effect.dotHeight / 2, right, yPos + effect.dotHeight / 2);
  }
}
