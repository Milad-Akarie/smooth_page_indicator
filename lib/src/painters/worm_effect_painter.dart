import 'package:flutter/material.dart';

import 'indicator_painter.dart';

class WormEffectPainter extends IndicatorPainter {
  final Color activeDotColor;
  final Paint _activePaint;

  WormEffectPainter({
    this.activeDotColor,
    double offset,
    bool isRTL,
    double dotWidth,
    double dotHeight,
    double hSpacing,
    double vSpacing,
    double radius,
    Color dotColor,
    double strokeWidth,
    PaintingStyle paintingStyle,
    int count,
    PaintingStyle paintStyle,
  })  : _activePaint = Paint()..color = activeDotColor,
        super(
          rawOffset: offset,
          isRTL: isRTL,
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          hSpacing: hSpacing,
          vSpacing: vSpacing,
          radius: radius,
          count: count,
          strokeWidth: strokeWidth,
          paintStyle: paintingStyle,
          dotColor: dotColor,
        );

  @override
  void paint(Canvas canvas, Size size) {

    for (int i = 0; i < count; i++) {
      final bounds = _calcBounds(i);
      RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
    final dotOffset = offset - offset.toInt();
    final bounds = _calcBounds(offset.floor(), dotOffset * 2);
    final worm = RRect.fromLTRBR(bounds.left, bounds.top, bounds.right, bounds.bottom, dotRadius);
    canvas.drawRRect(worm, _activePaint);
  }

  Rect _calcBounds(num i, [double dotOffset = 0]) {
    final xPos = hSpacing / 2 + (i * (dotWidth + hSpacing));
    final yPos = (dotHeight + vSpacing) / 2;
    double left = xPos;
    double right = xPos + dotWidth + (dotOffset * (dotWidth + hSpacing));
    if (dotOffset > 1) {
      right = xPos + dotWidth + (1 * (dotWidth + hSpacing));
      left = xPos + ((hSpacing + dotWidth) * (dotOffset - 1));
    }
    return Rect.fromLTRB(left, yPos - dotHeight / 2, right, yPos + dotHeight / 2);
  }
}
