import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/indicator_painter.dart';
import 'package:smooth_page_indicator/src/painters/scrolling_dots_painter.dart';
import 'package:smooth_page_indicator/src/painters/scrolling_dots_painter_with_fixed_center.dart';
import 'package:smooth_page_indicator/src/theme_defaults.dart';

import 'indicator_effect.dart';

/// Holds painting configuration to be used by [ScrollingDotsPainter]
/// or [ScrollingDotsWithFixedCenterPainter]
class ScrollingDotsEffect extends BasicIndicatorEffect {
  /// The active dot strokeWidth
  /// this is ignored if [fixedCenter] is false
  final double activeStrokeWidth;

  /// [activeDotScale] is multiplied by [dotWidth] to resolve
  /// active dot scaling
  final double activeDotScale;

  /// [smallDotScale] is multiplied by [dotWidth] to resolve
  /// side dots
  final double smallDotScale;

  /// The max number of dots to display at a time
  /// if count is <= [maxVisibleDots] [maxVisibleDots] = count
  /// must be an odd number that's >= 5
  final int maxVisibleDots;

  /// if True the old center dot style will be used
  final bool fixedCenter;

  /// Default constructor
  const ScrollingDotsEffect({
    this.activeStrokeWidth = 1.5,
    this.activeDotScale = 1.3,
    this.smallDotScale = 0.66,
    this.maxVisibleDots = 5,
    this.fixedCenter = false,
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 8.0,
    super.radius = 16,
    super.dotColor,
    super.activeDotColor,
    super.strokeWidth = 1.0,
    super.paintStyle = PaintingStyle.fill,
  })  : assert(activeDotScale >= 0.0),
        assert(maxVisibleDots >= 5 && maxVisibleDots % 2 != 0);

  @override
  Size calculateSize(int count) {
    /// Add the scaled dot width to our size calculation
    var width = (dotWidth + spacing) * (min(count, maxVisibleDots));
    if (fixedCenter && count <= maxVisibleDots) {
      width = ((count * 2) - 1) * (dotWidth + spacing);
    }
    return Size(width, dotHeight * activeDotScale);
  }

  @override
  int hitTestDots(double dx, int count, double current) {
    final switchPoint = (maxVisibleDots / 2).floor();
    if (fixedCenter) {
      return super.hitTestDots(dx, count, current) - switchPoint + current.floor();
    } else {
      final firstVisibleDot = (current < switchPoint || count - 1 < maxVisibleDots)
          ? 0
          : min(current - switchPoint, count - maxVisibleDots).floor();
      final lastVisibleDot = min(firstVisibleDot + maxVisibleDots, count - 1).floor();
      var offset = 0.0;
      for (var index = firstVisibleDot; index <= lastVisibleDot; index++) {
        if (dx <= (offset += dotWidth + spacing)) {
          return index;
        }
      }
    }
    return -1;
  }

  @override
  BasicIndicatorPainter buildPainter(int count, double offset, ThemeDefaults themeDefaults) {
    if (fixedCenter) {
      assert(
        offset.ceil() < count,
        'ScrollingDotsWithFixedCenterPainter does not support infinite looping.',
      );
      return ScrollingDotsWithFixedCenterPainter(
        count: count,
        offset: offset,
        effect: this,
        themeDefaults: themeDefaults,
      );
    } else {
      return ScrollingDotsPainter(
        count: count,
        offset: offset,
        effect: this,
        themeDefaults: themeDefaults,
      );
    }
  }
}
