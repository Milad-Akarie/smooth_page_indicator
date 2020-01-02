import 'package:flutter/material.dart';
import 'package:smooth_indicators/src/effects/scale_effect.dart';

import 'indicator_painter.dart';

class ScaleEffectPainter extends IndicatorPainter {
  final ScaleEffect effect;

  ScaleEffectPainter({
    @required double offset,
    @required this.effect,
    @required int count,
  }) : super(offset, count, effect);

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
        scale = effect.dotWidth * effect.scale - (effect.dotWidth * effect.scale * dotOffset);
      }
      if (isNext) {
        scale = effect.dotWidth * effect.scale * dotOffset;
      }

      final activeBounds = _calcBounds(size.height, i, scale);
      RRect activeRect =
          RRect.fromRectAndRadius(activeBounds, Radius.circular(effect.radius + effect.radius * effect.scale));
      canvas.drawRRect(activeRect, activePaint);
    }
  }

  Rect _calcBounds(double canvasHeight, num i, [double hScale = 0]) {
    final width = effect.dotWidth + hScale;
    final calculatedScale = width - effect.dotWidth;
    final height = effect.dotHeight + calculatedScale;
    final startPoint = effect.dotWidth * effect.scale;
    final xPos = startPoint / 4 + (effect.spacing + effect.dotWidth) / 2 + (i * (effect.dotWidth + effect.spacing));
    final yPos = canvasHeight / 2;
    return Rect.fromLTRB(xPos - width / 2, yPos - height / 2, xPos + width / 2, yPos + height / 2);
  }
}
