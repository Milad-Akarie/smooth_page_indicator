import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/indicator_effect.dart';

abstract class IndicatorPainter extends CustomPainter {
  final double _rawOffset;
  final double offset;
  final int count;
  final IndicatorEffect _effect;
  final Paint dotPaint;
  final Radius dotRadius;

  IndicatorPainter(
    this._rawOffset,
    this.count,
    this._effect,
  )   : dotRadius = Radius.circular(_effect.radius),
        dotPaint = Paint()
          ..color = _effect.dotColor
          ..style = _effect.paintStyle
          ..strokeWidth = _effect.strokeWidth,
        offset = _effect.isRTL ? (count - 1) - _rawOffset : _rawOffset;

  double get distance => _effect.dotWidth + _effect.spacing;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < count; i++) {
      final xPos = (i * distance);
      final yPos = size.height / 2;
      final bounds = Rect.fromLTRB(xPos, yPos - _effect.dotHeight / 2,
          xPos + _effect.dotWidth, yPos + _effect.dotHeight / 2);
      RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) {
    return oldDelegate._rawOffset != _rawOffset;
  }
}
