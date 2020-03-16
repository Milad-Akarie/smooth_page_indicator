import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/scale_effect.dart';

import 'indicator_painter.dart';

class ScalePainter extends IndicatorPainter {
  final ScaleEffect effect;

  ScalePainter({
    @required double offset,
    @required this.effect,
    @required int count,
    @required bool isRTL,
  }) : super(offset, count, effect, isRTL);

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
    final activePaint = Paint()
      ..color = effect.dotColor
      ..style = effect.activePaintStyle
      ..strokeWidth = effect.activeStrokeWidth;

    final dotOffset = offset - current;
    final activeScale = effect.scale - 1.0;

    for (int index = 0; index < count; index++) {
      canvas.drawRRect(_calcBounds(size.height, index), dotPaint);
      Color color = effect.dotColor;
      double scale = 0.0;
      if (index == current) {
        scale = effect.scale - (activeScale * dotOffset);
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset);
      } else if (index - 1 == current) {
        scale = 1.0 + (activeScale * dotOffset);
        color =
            Color.lerp(effect.activeDotColor, effect.dotColor, 1.0 - dotOffset);
      }
      canvas.drawRRect(
          _calcBounds(size.height, index, scale), activePaint..color = color);
    }
  }

  RRect _calcBounds(double canvasHeight, num offset, [double scale = 1.0]) {
    final width = effect.dotWidth * scale;
    final height = effect.dotHeight * scale;
    final startingPoint = effect.dotWidth * effect.scale;
    final xPos = startingPoint / 2 -
        width / 2 +
        (offset * (effect.dotWidth + effect.spacing));
    final yPos = canvasHeight / 2;
    return RRect.fromLTRBR(xPos, yPos - height / 2, xPos + width,
        yPos + height / 2, dotRadius * scale);
  }
}
