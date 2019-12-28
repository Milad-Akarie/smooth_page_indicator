import 'package:flutter/material.dart';

import 'indicator_painter.dart';

class ExpandingDotsPainter extends IndicatorPainter {
  final double expansionFactor;
  final double _activeDotWidth;

  ExpandingDotsPainter({
    this.expansionFactor,
    double offset,
    bool isRTL,
    double dotWidth,
    double dotHeight,
    double hSpacing,
    double vSpacing,
    double radius,
    double strokeWidth,
    Color dotColor,
    int count,
    PaintingStyle paintStyle,
  })  : _activeDotWidth = dotWidth * expansionFactor,
        super(
          rawOffset: offset,
          isRTL: isRTL,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          hSpacing: hSpacing,
          vSpacing: vSpacing,
          radius: radius,
          strokeWidth: strokeWidth,
          count: count,
          paintStyle: paintStyle,
          dotColor: dotColor,
        );

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();

    double lastPos = -hSpacing / 2;
    for (int i = 0; i < count; i++) {
      final active = i == current;
      final dotOffset = offset - offset.toInt();
      final expansion = (dotOffset / 2 * ((_activeDotWidth - dotWidth) / .5));
      final bool isNext = i - 1 == current;
      final bounds = _calcBounds(lastPos, i, active, isNext, expansion);
      lastPos = bounds.right;
      RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  Rect _calcBounds(double startingPoint, num i, bool isActive, bool isNext, double expansion) {
    final xPos = startingPoint + hSpacing;
    double width = dotWidth;
    if (isActive) {
      width = _activeDotWidth - expansion;
    } else if (isNext) {
      width = dotWidth + expansion;
    }
    final yPos = (dotWidth + vSpacing) / 2;
    return Rect.fromLTRB(xPos, yPos - dotHeight / 2, xPos + width, yPos + dotHeight / 2);
  }
}
