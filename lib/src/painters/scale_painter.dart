import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/scale_effect.dart';

import 'indicator_painter.dart';

class ScalePainter extends IndicatorPainter {
  final ScaleEffect effect;

  ScalePainter({
    @required double offset,
    @required this.effect,
    @required int count,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
    var current = offset.floor();
    var activePaint = Paint()
      ..color = effect.dotColor
      ..style = effect.activePaintStyle
      ..strokeWidth = effect.activeStrokeWidth;

    var dotOffset = offset - current;
    var activeScale = effect.scale - 1.0;

    for (var index = 0; index < count; index++) {
      canvas.drawRRect(_calcBounds(size.height, index), dotPaint);
      var color = effect.dotColor;
      var scale = 0.0;
      if (index == current) {
        scale = (effect.scale) - (activeScale * dotOffset);
        color = Color.lerp(effect.activeDotFillColor ?? effect.activeDotColor,
            effect.dotColor, dotOffset);
      } else if (index - 1 == current) {
        scale = 1.0 + (activeScale * dotOffset);
        color = Color.lerp(effect.activeDotFillColor ?? effect.activeDotColor,
            effect.dotColor, 1.0 - dotOffset);
      }

      if (effect.activeDotFillColor != null) {
        canvas.drawRRect(
            _calcBounds(size.height, index), dotPaint..color = color);
      }
      canvas.drawRRect(
          _calcBounds(size.height, index, scale), activePaint..color = color);
    }
  }

  RRect _calcBounds(double canvasHeight, num offset, [double scale = 1.0]) {
    var width = effect.dotWidth * scale;
    var height = effect.dotHeight * scale;
    var startingPoint = effect.dotWidth + effect.spacing / 2;
    var xPos = startingPoint / 2 -
        width / 2 +
        (offset * (effect.dotWidth + effect.spacing));
    var yPos = canvasHeight / 2;
    return RRect.fromLTRBR(xPos, yPos - height / 2, xPos + width,
        yPos + height / 2, dotRadius * scale);
  }
}
