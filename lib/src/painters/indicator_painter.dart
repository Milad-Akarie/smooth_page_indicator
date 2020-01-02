import 'package:flutter/material.dart';
import 'package:smooth_indicators/src/effects/indicator_effect.dart';

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

  double get distance => _effect.dotWidth + _effect.spacing + _effect.strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    for (int i = 0; i < count; i++) {
      final xPos = _effect.strokeWidth / 2 + (i * distance);
      print(xPos + _effect.dotWidth);
      final yPos = size.height / 2;
      final bounds =
          Rect.fromLTRB(xPos, yPos - _effect.dotHeight / 2, xPos + _effect.dotWidth, yPos + _effect.dotHeight / 2);
      RRect rect = RRect.fromRectAndRadius(bounds, dotRadius);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) {
    return oldDelegate._rawOffset != _rawOffset;
  }
}
