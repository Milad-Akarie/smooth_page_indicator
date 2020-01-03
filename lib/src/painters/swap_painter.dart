import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/swap_effect.dart';

import 'indicator_painter.dart';

class SwapPainter extends IndicatorPainter {
  final SwapEffect effect;

  SwapPainter({
    @required double offset,
    @required this.effect,
    @required int count,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
    for (int i = 0; i < count; i++) {
      final active = i == current;
      final dotOffset = offset - offset.toInt();
      final bool isNext = i - 1 == current;
      double posOffset = i.toDouble();
      Paint paint = dotPaint;

      if (active) {
        paint = Paint()..color = effect.activeDotColor;
        posOffset = offset;
      }
      if (isNext) {
        posOffset = i - dotOffset;
      }
      final bounds = _calcBounds(posOffset);
      RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, paint);
    }
  }

  Rect _calcBounds(num i) {
    final xPos = effect.spacing / 2 + (i * (effect.dotWidth + effect.spacing));
    final yPos = (effect.dotHeight) / 2;
    return Rect.fromLTRB(xPos, yPos - effect.dotHeight / 2, xPos + effect.dotWidth, yPos + effect.dotHeight / 2);
  }
}
