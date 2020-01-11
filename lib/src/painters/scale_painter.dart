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

    final dotOffset = (offset - offset.toInt());

    for (int i = 0; i < count; i++) {
      final active = i == current;
      final bool isNext = i - 1 == current;

      final bounds = _calcBounds(size.height, i);
      RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);

      double scale = 0.0;
      if (active) {
        scale = effect.dotWidth * effect.scale -
            (effect.dotWidth * effect.scale * dotOffset);
      }
      if (isNext) {
        scale = effect.dotWidth * effect.scale * dotOffset;
      }

      final activeBounds = _calcBounds(size.height, i, scale);
      RRect activeRect = RRect.fromRectAndRadius(activeBounds,
          Radius.circular(effect.radius + effect.radius * effect.scale));
      canvas.drawRRect(activeRect, activePaint);
    }
  }

  Rect _calcBounds(double canvasHeight, num i, [double hScale = 0]) {
    final width = effect.dotWidth + hScale;
    final calculatedScale = width - effect.dotWidth;
    final height = effect.dotHeight + calculatedScale;
    final startingPoint = effect.dotWidth * effect.scale;
    final xPos = startingPoint / 2 -
        calculatedScale / 2 +
        (i * (effect.dotWidth + effect.spacing));
    final yPos = canvasHeight / 2;
    return Rect.fromLTRB(
        xPos, yPos - height / 2, xPos + width, yPos + height / 2);
  }
}
