import 'package:flutter/material.dart';

abstract class IndicatorPainter extends CustomPainter {
  final Paint dotPaint;
  final double offset;
  final Radius dotRadius;
  final bool isRTL;
  final double rawOffset;
  final double dotWidth;
  final double dotHeight;
  final double hSpacing;
  final double vSpacing;
  final double radius;
  final Color dotColor;
  final int count;
  final PaintingStyle paintStyle;
  final double strokeWidth;

  IndicatorPainter({
    @required this.rawOffset,
    @required this.strokeWidth,
    @required this.isRTL,
    @required this.dotWidth,
    @required this.dotHeight,
    @required this.hSpacing,
    @required this.vSpacing,
    @required this.radius,
    @required this.dotColor,
    @required this.count,
    @required this.paintStyle,
  })  : assert(isRTL != null, 'isRTL must not be null'),
        assert(radius != null || radius < 0, 'radius must not be null or less than 0'),
        assert(dotColor != null && paintStyle != null && strokeWidth != null, "dotColor, paintStyle and strokeWidth must not be null "),
        assert(strokeWidth > 0, 'strokeWidth must not be less than 0'),
        assert(rawOffset != null && rawOffset.ceil() < count , 'current page index is bigger bigger than total count'),
        offset = _getDirectionalOffset(isRTL, count, rawOffset),
        dotRadius = Radius.circular(radius),
        dotPaint = Paint()
          ..color = dotColor
          ..style = paintStyle
          ..strokeWidth = strokeWidth;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return (oldDelegate as IndicatorPainter).rawOffset != rawOffset;
  }

  static double _getDirectionalOffset(bool isRTL, int count, double rawOffset) {
    if (isRTL) {
      return (count - 1) - (rawOffset ?? 0.0);
    } else
      return rawOffset ?? 0.0;
  }
}
