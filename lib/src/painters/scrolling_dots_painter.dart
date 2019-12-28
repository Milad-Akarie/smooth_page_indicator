import 'package:flutter/material.dart';

import 'indicator_painter.dart';

class ScrollingDotsPainter extends IndicatorPainter {
  final Color activeDotColor;
  final Paint _activePaint;

  ScrollingDotsPainter({
    @required this.activeDotColor,
    @required double offset,
    @required bool isRTL,
    @required double dotWidth,
    @required double dotHeight,
    @required double hSpacing,
    @required double vSpacing,
    @required double radius,
    @required Color dotColor,
    @required double strokeWidth,
    @required int count,
    @required PaintingStyle paintStyle,
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
          paintStyle: paintStyle,
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

    final bounds = _calcBounds(offset);

    final current = _calcBounds(offset.round()).left;
    final left = dotOffset < 0.15 ? current : bounds.left;

    final next = _calcBounds(offset.ceil()).right;
    final right = dotOffset > 0.85 ? next : bounds.right;
    RRect activeDot = RRect.fromLTRBR(left, bounds.top, right, bounds.bottom, dotRadius);

    canvas.drawRRect(activeDot, _activePaint);
  }

  Rect _calcBounds(num i) {
    final xPos = hSpacing / 2 + (i * (dotWidth + hSpacing));
    final yPos = (dotHeight + vSpacing) / 2;
    return Rect.fromLTRB(xPos, yPos - dotHeight / 2, xPos + dotWidth, yPos + dotWidth / 2);
  }


}
