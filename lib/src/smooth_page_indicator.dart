import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'effects/indicator_effect.dart';
import 'effects/worm_effect.dart';
import 'painters/indicator_painter.dart';

typedef OnDotClicked = void Function(int index);

class SmoothPageIndicator extends StatelessWidget {
  // Typically a PageView controller to listen for page offset updates
  final Animation controller;

  /// Holds effect configuration to be used in the [IndicatorPainter]
  final IndicatorEffect effect;

  /// layout direction vertical || horizontal
  final Axis axisDirection;

  /// The number of children in [PageView]
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page direction will be flipped
  final TextDirection textDirection;

  /// on dot clicked callback
  final OnDotClicked onDotClicked;

  SmoothPageIndicator({
    @required this.controller,
    @required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect = const WormEffect(),
    Key key,
  })  : assert(controller != null),
        assert(effect != null),
        assert(count != null),
        super(key: key);

  static noController({
    @required int count,
    @required int activeIndex,
    Axis axisDirection = Axis.horizontal,
    TextDirection textDirection,
    OnDotClicked onDotClicked,
    IndicatorEffect effect = const WormEffect(),
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOut,
  }) {
    return _CustomPageIndicator(
      count: count,
      activeIndex: activeIndex,
      axisDirection: axisDirection,
      textDirection: textDirection,
      effect: effect,
      onDotClicked: onDotClicked,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
    );
  }

  Widget build(BuildContext context) {
    // if textDirection is not provided use the nearest directionality up the widgets tree;
    final isRTL = (textDirection ?? Directionality.of(context)) == TextDirection.rtl;

    // different effects have different sizes
    // so we calculate size based on the provided effect
    var calculatedSize = effect.calculateSize(count);

    return RotatedBox(
      quarterTurns: axisDirection == Axis.vertical ? 1 : isRTL ? 2 : 0,
      child: GestureDetector(
        onTapUp: _onTap,
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return CustomPaint(
                size: calculatedSize,
                // rebuild the painter with the new offset every time it updates
                painter: effect.buildPainter(count, controller.value.toDouble()),
              );
            }),
      ),
    );
  }

  void _onTap(details) {
    if (onDotClicked != null) {
      var index = effect.hitTestDots(
        details.localPosition.dx,
        count,
        controller.value as double,
      );
      if (index != -1) {
        onDotClicked(index);
      }
    }
  }
}

class _CustomPageIndicator extends StatefulWidget {
  final int activeIndex;

  /// Holds effect configuration to be used in the [IndicatorPainter]
  final IndicatorEffect effect;

  /// layout direction vertical || horizontal
  final Axis axisDirection;

  /// The number of children in [PageView]
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page direction will be flipped
  final TextDirection textDirection;

  /// On dot clicked callback
  final Function(int index) onDotClicked;

  /// Passed to animateTo function in [AnimationController]
  /// when animating to active index
  final Duration animationDuration;

  /// Passed to animateTo function in [AnimationController]
  /// when animating to active index
  final Curve animationCurve;

  _CustomPageIndicator({
    @required this.activeIndex,
    @required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect = const WormEffect(),
    this.animationCurve,
    this.animationDuration,
    Key key,
  })  : assert(effect != null),
        assert(activeIndex != null),
        assert(count != null),
        assert(animationDuration != null),
        assert(animationCurve != null),
        super(key: key);

  @override
  __CustomPageIndicatorState createState() => __CustomPageIndicatorState();
}

class __CustomPageIndicatorState extends State<_CustomPageIndicator> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: widget.activeIndex.toDouble(),
      lowerBound: 0.0,
      upperBound: widget.count.toDouble(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void didUpdateWidget(_CustomPageIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeIndex != oldWidget.activeIndex) {
      _animationController.animateTo(
        widget.activeIndex.toDouble(),
        duration: widget.animationDuration,
        curve: widget.animationCurve,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _animationController,
      effect: widget.effect,
      textDirection: widget.textDirection,
      axisDirection: widget.axisDirection,
      count: widget.count,
      onDotClicked: widget.onDotClicked,
    );
  }
}
