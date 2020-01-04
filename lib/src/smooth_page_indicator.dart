import 'package:flutter/material.dart';

import 'effects/indicator_effect.dart';
import 'effects/worm_effect.dart';
import 'painters/indicator_painter.dart';

class SmoothPageIndicator extends AnimatedWidget {
  // a PageView controller to listen for page offset updates
  final PageController controller;

  /// holds effect configuration to be used in the [IndicatorPainter]
  final IndicatorEffect effect;

  /// the count of children in [PageView]
  final int count;

  SmoothPageIndicator({
    @required this.controller,
    @required this.count,
    this.effect = const WormEffect(),
    Key key,
  })  : assert(controller != null),
        assert(effect != null),
        assert(count != null),
        super(listenable: controller, key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // different effects have different sizes
      // so we calculate size based on the provided effect
      size: effect.calculateSize(count),
      // rebuild the painter with the new offset every time it updates
      painter: effect.buildPainter(count, controller.page ?? 0.0),
    );
  }
}
