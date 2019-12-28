import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smooth_indicators/src/painters/simple_dot_painter.dart';

class SimpleDotIndicator extends AnimatedWidget {
  final PageController controller;
  final double dotWidth;
  final double dotHeight;
  final double hSpacing;
  final double vSpacing;
  final double radius;
  final Color dotColor;
  final Color activeDotColor;
  final bool isRTL;
  final int count;
  final double strokeWidth;
  final PaintingStyle paintStyle;
  final Size _size;

  SimpleDotIndicator({
    @required this.controller,
    @required this.count,
    this.dotColor = Colors.grey,
    this.paintStyle = PaintingStyle.fill,
    this.activeDotColor = Colors.indigo,
    this.isRTL = false,
    this.strokeWidth = 1.0,
    this.dotWidth = 16.0,
    this.dotHeight = 16.0,
    this.hSpacing = 12.0,
    this.vSpacing = 16.0,
    this.radius = 16.0,
    Key key,
  })  : assert(controller != null, 'controller must not be null'),
        assert(count != null && count > 0, 'count must not be null or less than 0'),
        assert(dotWidth != null && dotWidth > 0, 'dotWidth must not be null or less than 0'),
        assert(dotHeight != null && dotHeight > 0, 'dotHeight must not be null or less than 0'),
        assert(vSpacing != null && vSpacing > 0, 'vSpacing must not be null or less than 0'),
        assert(hSpacing != null && hSpacing > 0, 'hSpacing must not be null or less than 0'),
        _size = Size(((dotWidth + hSpacing) * count).toDouble(), dotHeight + vSpacing),
        super(listenable: controller, key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: _size,
      painter: SimpleDotPainter(
        offset: controller.page,
        count: count,
        isRTL: isRTL,
        activeDotColor: activeDotColor,
        dotWidth: dotWidth,
        dotHeight: dotHeight,
        hSpacing: hSpacing,
        vSpacing: vSpacing,
        dotColor: dotColor,
        strokeWidth: strokeWidth,
        radius: radius,
        paintStyle: paintStyle,
      ),
    );
  }
}
