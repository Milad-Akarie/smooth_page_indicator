import 'package:flutter/material.dart';
import 'package:smooth_indicators/src/painters/expanding_dots_painter.dart';

class ExpendingDotsIndicator extends AnimatedWidget {
  final PageController controller;
  final double expansionFactor;
  final double dotWidth;
  final double dotHeight;
  final double hSpacing;
  final double vSpacing;
  final double radius;
  final Color dotColor = Colors.indigo;
  final int count;
  final bool isRTL;
  final PaintingStyle paintStyle = PaintingStyle.fill;
  final Size _size;

  ExpendingDotsIndicator({
    @required this.controller,
    @required this.count,
    this.expansionFactor = 3,
    this.dotWidth = 16.0,
    this.dotHeight = 16.0,
    this.hSpacing = 8.0,
    this.vSpacing = 16.0,
    this.radius = 16.0,
    this.isRTL = false,
    Key key,
  })  :
        assert(controller != null, 'controller must not be null'),
        assert(count != null && count > 0, 'count must not be null or less than 0'),
        assert(dotWidth != null && dotWidth > 0, 'dotWidth must not be null or less than 0'),
        assert(dotHeight != null && dotHeight > 0, 'dotHeight must not be null or less than 0'),
        assert(vSpacing != null && vSpacing > 0, 'vSpacing must not be null or less than 0'),
        assert(hSpacing != null && hSpacing > 0, 'hSpacing must not be null or less than 0'),
        _size = Size(((dotWidth + hSpacing) * count).toDouble() + dotWidth * (expansionFactor - 1), dotHeight + vSpacing),
        super(listenable: controller, key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: _size,
      painter: ExpandingDotsPainter(
        offset: controller.page,
        count: count,
        isRTL: isRTL,
        expansionFactor: expansionFactor,
        dotWidth: dotWidth,
        dotHeight: dotHeight,
        hSpacing: hSpacing,
        vSpacing: vSpacing,
        dotColor: dotColor,
        radius: radius,
        strokeWidth: 1.0,
        paintStyle: paintStyle,
      ),
    );
  }
}
