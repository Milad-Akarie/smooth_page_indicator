import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/indicator_effect.dart';

abstract class IndicatorPainter extends CustomPainter {
  /// The raw offset from the [PageController].page
  /// This holds the directional offset
  final double offset;

  /// The count of pages
  final int count;

  // The provided effect is passed to this super class
  // to make some calculations and paint still dots
  final IndicatorEffect _effect;

  /// Inactive dot paint or base paint in one-color effects.
  final Paint dotPaint;

  /// The Radius of all dots
  final Radius dotRadius;

  IndicatorPainter(
    this.offset,
    this.count,
    this._effect,
  )   : assert(offset.ceil() < count, 'Current page is out of bounds'),
        dotRadius = Radius.circular(_effect.radius),
        dotPaint = Paint()
          ..color = _effect.dotColor
          ..style = _effect.paintStyle
          ..strokeWidth = _effect.strokeWidth;

  // The distance between dot lefts
  double get distance => _effect.dotWidth + _effect.spacing;

  void paintStillDots(Canvas canvas, Size size) {
    for (var i = 0; i < count; i++) {
      final xPos = (i * distance);
      final yPos = size.height / 2;
      final bounds = Rect.fromLTRB(xPos, yPos - _effect.dotHeight / 2,
          xPos + _effect.dotWidth, yPos + _effect.dotHeight / 2);
      var rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) {
    // only repaint if the raw offset changes
    return oldDelegate.offset != offset;
  }
}
