import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/jumping_dot_effect.dart';

import 'indicator_painter.dart';

class JumpingDotPainter extends IndicatorPainter {
  final JumpingDotEffect effect;

  JumpingDotPainter({
    required this.effect,
    required int count,
    required double offset,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
    // paint still dots
    paintStillDots(canvas, size);
    final activeDotPainter = Paint()..color = effect.activeDotColor;
    final dotOffset = offset - offset.toInt();
    var scale = 1.0;
    if (dotOffset < .5) {
      scale = dotOffset * effect.elevation;
    } else {
      scale = (1 - dotOffset) * effect.elevation;
    }

    final xPos = (offset * (effect.dotWidth + effect.spacing));
    final yPos = (size.height) / 2;
    final height = effect.dotHeight + scale;
    final width = effect.dotWidth + scale;
    final scaleRatio = width / effect.dotWidth;
    final rRect = RRect.fromLTRBR(xPos, yPos - height / 2, xPos + width,
        yPos + height / 2, dotRadius * scaleRatio);

    canvas.drawRRect(rRect, activeDotPainter);
  }
}
