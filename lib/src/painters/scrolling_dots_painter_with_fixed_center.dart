import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'indicator_painter.dart';

class ScrollingDotsWithFixedCenterPainter extends IndicatorPainter {
  final ScrollingDotsEffect effect;

  ScrollingDotsWithFixedCenterPainter({
    @required this.effect,
    @required int count,
    @required double offset,
    @required bool isRTL,
  }) : super(offset, count, effect, isRTL);

  @override
  void paint(Canvas canvas, Size size) {
    final int current = offset.floor();
    final dotOffset = offset - current;
    final dotPaint = Paint()
      ..strokeWidth = effect.strokeWidth
      ..style = effect.paintStyle;

    for (int index = 0; index < count; index++) {
      Color color = effect.dotColor;
      if (index == current) {
        color = Color.lerp(effect.activeDotColor, effect.dotColor, dotOffset);
      } else if (index - 1 == current) {
        color =
            Color.lerp(effect.activeDotColor, effect.dotColor, 1 - dotOffset);
      }

      double scale = 1.0;
      final smallDotScale = 0.66;
      final revDotOffset = 1 - dotOffset;
      final centerAnchor = (effect.maxVisibleDots - 1) / 2;

      if (count > effect.maxVisibleDots) {
        if (index >= current - centerAnchor &&
            index <= current + (centerAnchor + 1)) {
          if (index == (current + centerAnchor)) {
            scale = smallDotScale + ((1 - smallDotScale) * dotOffset);
          } else if (index == current - (centerAnchor - 1)) {
            scale = 1 - (1 - smallDotScale) * dotOffset;
          } else if (index == current - centerAnchor) {
            scale = (smallDotScale * revDotOffset);
          } else if (index == current + (centerAnchor + 1)) {
            scale = (smallDotScale * dotOffset);
          }
        } else {
          continue;
        }
      }

      final rRect = _calcBounds(
        size.height,
        size.width / 2 - (offset * (effect.dotWidth + effect.spacing)),
        index,
        scale,
      );

      canvas.drawRRect(rRect, dotPaint..color = color);
    }

    final rRect =
        _calcBounds(size.height, size.width / 2, 0, effect.activeDotScale);
    canvas.drawRRect(
        rRect,
        Paint()
          ..color = effect.activeDotColor
          ..strokeWidth = effect.activeStrokeWidth
          ..style = PaintingStyle.stroke);
  }

  RRect _calcBounds(double canvasHeight, double startingPoint, num i,
      [double scale = 1.0]) {
    final scaledWidth = effect.dotWidth * scale;
    final scaledHeight = effect.dotHeight * scale;

    final xPos = startingPoint + (effect.dotWidth + effect.spacing) * i;
    final yPos = canvasHeight / 2;
    return RRect.fromLTRBR(
      xPos - scaledWidth / 2,
      yPos - scaledHeight / 2,
      xPos + scaledWidth / 2,
      yPos + scaledHeight / 2,
      dotRadius * scale,
    );
  }
}
