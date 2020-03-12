import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'indicator_painter.dart';

class ScrollingDotsPainterInsta extends IndicatorPainter {
  final ScrollingDotsEffect effect;

  int switchPoint;
  int firstVisibleDot;
  int lastVisibleDot;
  bool inPreScrollRange;
  bool inAfterScrollRange;
  bool willStartScrolling;
  bool willStopScrolling;
  int current;
  ScrollingDotsPainterInsta({
    @required this.effect,
    @required int count,
    @required double offset,
    @required bool isRTL,
  }) : super(offset, count, effect, isRTL) {
    current = super.offset.floor();
    switchPoint = (effect.maxVisibleDots / 2).floor();
    firstVisibleDot = (current < switchPoint) ? 0 : min(current - switchPoint, count - effect.maxVisibleDots);
    lastVisibleDot = min(firstVisibleDot + effect.maxVisibleDots - 1, count - 1);
    inPreScrollRange = current < switchPoint;
    inAfterScrollRange = current >= (count - 1) - switchPoint;
    willStartScrolling = (current + 1) == switchPoint + 1;
    willStopScrolling = current + 1 == (count - 1) - switchPoint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final dotOffset = offset - offset.toInt();
    final dotPaint = Paint()
      ..strokeWidth = effect.strokeWidth
      ..style = effect.paintStyle;

    double drawingOffset = 0; // effect.spacing;

    for (int i = firstVisibleDot; i <= lastVisibleDot + 1; i++) {
      Color color = effect.dotColor;

      double scale = 1.0;
      if (i == current) {
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset);
        scale = 1.0 + effect.activeDotScale * (1.0 - dotOffset);
      } else if (i - 1 == current) {
        scale = 1.0 + effect.activeDotScale * dotOffset;
        color = Color.lerp(effect.activeDotColor, effect.dotColor, 1 - dotOffset);
      } else {
        scale = _calculateScaleAt(i);
      }

//      if (i == vi current + 2) {
//        scale = 0.5;
//      }
      final scaledWidth = (effect.dotWidth * scale);
      final height = (scaledWidth - effect.dotWidth) + effect.dotHeight;
      final yPos = size.height / 2;
      final hs = (effect.spacing * scale) / 2;

      final rRect = RRect.fromLTRBR(
        drawingOffset + hs,
        yPos - height / 2,
        drawingOffset + scaledWidth + hs,
        yPos + height / 2,
        dotRadius * scale,
      );

      canvas.drawRRect(rRect, dotPaint..color = color);

      drawingOffset = drawingOffset + ((effect.dotWidth * scale) + effect.spacing * scale);
    }
  }

  double _calculateScaleAt(int i) {
    double scale = 1.0;

    final dotOffset = offset - offset.toInt();
    if (i == firstVisibleDot) {
      if (inPreScrollRange) {
        scale = 1.0;
      } else if (inAfterScrollRange) {
        scale = 0.5;
      } else if (willStartScrolling) {
        scale = 1.0 * (1.0 - dotOffset);
      } else {
        scale = 0.5 * (1.0 - dotOffset);
      }
    } else if (i == firstVisibleDot + 1) {
      scale = (inPreScrollRange || inAfterScrollRange) ? 1.0 : 1.0 - dotOffset / 2;
    } else if (i == lastVisibleDot) {
      if (inPreScrollRange) {
        scale = 0.5;
      } else if (inAfterScrollRange) {
        scale = 1.0;
      } else {
        scale = 0.5 + (dotOffset / 2);
      }
    } else if (i == lastVisibleDot + 1) {
      if (inPreScrollRange || inAfterScrollRange) {
        scale = 0.0;
      } else if (willStopScrolling) {
        scale = 1.0 * dotOffset;
      } else {
        scale = 0.5 * dotOffset;
      }
    }
    return scale;
  }
}
