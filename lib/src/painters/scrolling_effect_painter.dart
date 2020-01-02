import 'package:flutter/material.dart';
import 'package:smooth_indicators/src/effects/scrolling_dots_effect.dart';

import 'indicator_painter.dart';

class ScrollingDotsPainter extends IndicatorPainter {
  final ScrollingDotsEffect effect;

  ScrollingDotsPainter({
    @required this.effect,
    @required int count,
    @required double offset,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
    for (int i = 0; i < count; i++) {
      final dotOffset = offset - offset.toInt();
      Color color = effect.dotColor;
      if (i == current) {
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset);
      }
      if (i - 1 == current) {
        color = Color.lerp(effect.activeDotColor, effect.dotColor, 1 - dotOffset);
      }

      double width = effect.dotWidth;

      final bounds = _calcBounds(size.height, size.width / 2 - (offset * (width + effect.spacing)), i);
      RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      final dotPaint = Paint()
        ..color = color
        ..strokeWidth = effect.strokeWidth
        ..style = effect.paintStyle;
      canvas.drawRRect(rect, dotPaint);
    }

    final bounds = _calcBounds(size.height, size.width / 2, 0, effect.activeDotScale);
    RRect rect =
        RRect.fromRectAndRadius(bounds, Radius.circular(effect.radius + effect.radius * effect.activeDotScale));
    canvas.drawRRect(
        rect,
        Paint()
          ..color = effect.activeDotColor
          ..strokeWidth = effect.activeStrokeWidth
          ..style = PaintingStyle.stroke);
  }

  Rect _calcBounds(double canvasHeight, double startingPoint, num i, [double scale = 0]) {
    final newWidth = effect.dotWidth + (effect.dotWidth * scale);
    final height = (newWidth - effect.dotWidth) + effect.dotHeight;

    final xPos = startingPoint + (newWidth + effect.spacing) * i;
    final yPos = canvasHeight / 2;
    print(yPos);
    return Rect.fromLTRB(xPos - newWidth / 2, yPos - height / 2, xPos + newWidth / 2, yPos + height / 2);
  }
}
