import 'package:flutter/material.dart';

import 'indicator_painter.dart';

class BouncingDotPainter extends IndicatorPainter {
  final Color activeDotColor;
  final Paint _activePaint;
  final double bounciness;

  BouncingDotPainter({
    @required this.bounciness,
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
    double expansion = 0;
    if (dotOffset < .5) {
      expansion = dotOffset * bounciness;
    } else {
      expansion = (1 - dotOffset) * bounciness;
    }

    final bounds = _calcBounds(offset, expansion);

    RRect activeDot = RRect.fromLTRBR(bounds.left, bounds.top, bounds.right, bounds.bottom, dotRadius);
    canvas.drawRRect(activeDot, _activePaint);
  }

  Rect _calcBounds(num i, [double expansion = 0]) {
    final xPos = hSpacing / 2 + (i * (dotWidth + hSpacing));
    final yPos = (dotHeight + vSpacing) / 2;
    final height = dotHeight + expansion;
    final width = dotWidth + expansion;
    return Rect.fromLTRB(xPos, yPos - height / 2, xPos + width, yPos + height / 2);
  }
}
