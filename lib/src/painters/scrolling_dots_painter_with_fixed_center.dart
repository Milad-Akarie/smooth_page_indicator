import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Paints dots scrolling transition effect and considers
/// active dot to always be in the center
/// Live demo at
/// https://github.com/Milad-Akarie/smooth_page_indicator/blob/f7ee92e7413a31de77bfb487755d64a385d52a52/demo/scrolling-dots-2.gif
class ScrollingDotsWithFixedCenterPainter extends BasicIndicatorPainter {
  /// The painting configuration
  final ScrollingDotsEffect effect;

  /// Default constructor
  ScrollingDotsWithFixedCenterPainter({
    required this.effect,
    required int count,
    required double offset,
    required ThemeDefaults themeDefaults,
  }) : super(offset, count, effect, themeDefaults);

  @override
  void paint(Canvas canvas, Size size) {
    var current = offset.floor();
    var dotOffset = offset - current;
    var dotPaint = Paint()
      ..strokeWidth = effect.strokeWidth
      ..style = effect.paintStyle;

    for (var index = 0; index < count; index++) {
      var color = effectiveInactiveColor;
      if (index == current) {
        // ! Both a and b are non nullable
        color = Color.lerp(effectiveActiveColor, effectiveInactiveColor, dotOffset)!;
      } else if (index - 1 == current) {
        // ! Both a and b are non nullable
        color = Color.lerp(effectiveActiveColor, effectiveInactiveColor, 1 - dotOffset)!;
      }

      var scale = 1.0;
      final smallDotScale = effect.smallDotScale;
      final revDotOffset = 1 - dotOffset;
      final switchPoint = (effect.maxVisibleDots - 1) / 2;

      if (count > effect.maxVisibleDots) {
        if (index >= current - switchPoint && index <= current + (switchPoint + 1)) {
          if (index == (current + switchPoint)) {
            scale = smallDotScale + ((1 - smallDotScale) * dotOffset);
          } else if (index == current - (switchPoint - 1)) {
            scale = 1 - (1 - smallDotScale) * dotOffset;
          } else if (index == current - switchPoint) {
            scale = (smallDotScale * revDotOffset);
          } else if (index == current + (switchPoint + 1)) {
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

    final rRect = _calcBounds(size.height, size.width / 2, 0, effect.activeDotScale);
    canvas.drawRRect(
        rRect,
        Paint()
          ..color = effectiveActiveColor
          ..strokeWidth = effect.activeStrokeWidth
          ..style = PaintingStyle.stroke);
  }

  RRect _calcBounds(double canvasHeight, double startingPoint, num i, [double scale = 1.0]) {
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
