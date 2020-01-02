import 'package:flutter/material.dart';

import 'effects/indicator_effect.dart';
import 'effects/worm_effect.dart';

class SmoothPageIndicator extends AnimatedWidget {
  final PageController controller;
  final IndicatorEffect effect;
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
      size: effect.calculateSize(count),
      painter: effect.buildPainter(count, controller.page ?? 0.0),
    );
  }
}
