import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/swap_effect.dart';

import 'indicator_painter.dart';

class SwapPainter extends IndicatorPainter {
  final SwapEffect effect;

  SwapPainter({
    required double offset,
    required this.effect,
    required int count,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
    final current = offset.floor();
    final dotOffset = offset - offset.floor();
    final activePaint = Paint()..color = effect.activeDotColor;
    for (var i = count - 1; i >= 0; i--) {
      var posOffset = i.toDouble();
      var paint = dotPaint;

      if (i == current) {
        paint = activePaint;
        posOffset = offset;
      } else if (i - 1 == current) {
        posOffset = i - dotOffset;
      }

      final xPos =
          effect.spacing / 2 + (posOffset * (effect.dotWidth + effect.spacing));
      final yPos = size.height / 2;
      final rRect = RRect.fromLTRBR(xPos, yPos - effect.dotHeight / 2,
          xPos + effect.dotWidth, yPos + effect.dotHeight / 2, dotRadius);

      canvas.drawRRect(rRect, paint);
    }
  }
}
