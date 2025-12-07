import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'effects/indicator_effect.dart';
import 'effects/worm_effect.dart';
import 'painters/indicator_painter.dart';
import 'theme_defaults.dart';

/// Signature for a callback function used to report
/// dot tap-events
typedef OnDotClicked = void Function(int index);

/// A widget that draws a representation of pages count
/// Inside of a  [PageView]
///
/// Uses the [PageController.offset] to animate the active dot
class SmoothPageIndicator extends StatefulWidget {
  /// The page view controller
  final PageController controller;

  /// Holds effect configuration to be used in the [BasicIndicatorPainter]
  /// If null, the effect will be read from [SmoothPageIndicatorTheme] or default to [WormEffect]
  final IndicatorEffect? effect;

  /// Layout direction vertical || horizontal
  ///
  /// This will only rotate the canvas in which the dots are drawn.
  ///
  /// It will not affect [effect.dotWidth] and [effect.dotHeight]
  final Axis axisDirection;

  /// The number of pages
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page direction will be flipped
  final TextDirection? textDirection;

  /// Reports dot taps
  final OnDotClicked? onDotClicked;

  /// Default constructor
  const SmoothPageIndicator({
    super.key,
    required this.controller,
    required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect,
  });

  @override
  State<SmoothPageIndicator> createState() => _SmoothPageIndicatorState();
}

mixin _SizeAndRotationCalculatorMixin {
  /// The size of canvas
  late Size size;

  /// Rotation quarters of canvas
  int quarterTurns = 0;

  BuildContext get context;

  TextDirection? get textDirection;

  Axis get axisDirection;

  int get count;

  IndicatorEffect get effect;

  void updateSizeAndRotation() {
    size = effect.calculateSize(count);

    /// if textDirection is not provided use the nearest directionality up the widgets tree;
    final isRTL = (textDirection ?? _getDirectionality()) == TextDirection.rtl;
    if (axisDirection == Axis.vertical) {
      quarterTurns = 1;
    } else {
      quarterTurns = isRTL ? 2 : 0;
    }
  }

  TextDirection? _getDirectionality() {
    return context
        .findAncestorWidgetOfExactType<Directionality>()
        ?.textDirection;
  }
}

class _SmoothPageIndicatorState extends State<SmoothPageIndicator>
    with _SizeAndRotationCalculatorMixin {
  late IndicatorEffect _effect;

  @override
  void didUpdateWidget(covariant SmoothPageIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateEffect();
    updateSizeAndRotation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateEffect();
    updateSizeAndRotation();
  }

  void _updateEffect() {
    _effect = widget.effect ??
        SmoothPageIndicatorTheme.of(context)?.effect ??
        const WormEffect();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) => SmoothIndicator(
        offset: _offset,
        count: count,
        effect: effect,
        onDotClicked: widget.onDotClicked,
        size: size,
        quarterTurns: quarterTurns,
      ),
    );
  }

  double get _offset {
    try {
      var offset = widget.controller.page;
      if (offset == null || offset.isNaN) {
        return widget.controller.initialPage.toDouble();
      }
      return offset % widget.count;
    } catch (_) {
      return widget.controller.initialPage.toDouble();
    }
  }

  @override
  int get count => widget.count;

  @override
  IndicatorEffect get effect => _effect;

  @override
  Axis get axisDirection => widget.axisDirection;

  @override
  TextDirection? get textDirection => widget.textDirection;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
    properties.add(DiagnosticsProperty<IndicatorEffect>('effect', effect));
    properties.add(DiagnosticsProperty<Size>('size', size));
    properties.add(IntProperty('quarterTurns', quarterTurns));
  }
}

/// Draws dot-ish representation of pages by
/// the number of [count] and animates the active
/// page using [offset]
class SmoothIndicator extends StatelessWidget {
  /// The active page offset
  final double offset;

  /// Holds effect configuration to be used in the [BasicIndicatorPainter]
  final IndicatorEffect effect;

  /// The number of pages
  final int count;

  /// Reports dot-taps
  final OnDotClicked? onDotClicked;

  /// The size of canvas
  final Size size;

  /// The rotation of cans based on
  /// text directionality and [axisDirection]
  final int quarterTurns;

  /// Default constructor
  const SmoothIndicator({
    super.key,
    required this.offset,
    required this.count,
    required this.size,
    this.quarterTurns = 0,
    this.effect = const WormEffect(),
    this.onDotClicked,
  });

  @override
  Widget build(BuildContext context) {
    final (_, indicatorColors) =
        SmoothPageIndicatorTheme.resolveDefaults(context);
    return RotatedBox(
      quarterTurns: quarterTurns,
      child: GestureDetector(
        onTapUp: _onTap,
        child: CustomPaint(
          size: size,
          // rebuild the painter with the new offset every time it updates
          painter: effect.buildPainter(count, offset, indicatorColors),
        ),
      ),
    );
  }

  void _onTap(TapUpDetails details) {
    if (onDotClicked != null) {
      var index = effect.hitTestDots(details.localPosition.dx, count, offset);
      if (index != -1 && index != offset.toInt()) {
        onDotClicked?.call(index);
      }
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('offset', offset));
    properties.add(IntProperty('count', count));
    properties.add(DiagnosticsProperty<IndicatorEffect>('effect', effect));
    properties.add(DiagnosticsProperty<Size>('size', size));
    properties.add(IntProperty('quarterTurns', quarterTurns));
  }
}

/// Unlike [SmoothPageIndicator] this indicator is self-animated
/// and it only needs to know active index
///
/// Useful for paging widgets that does not use [PageController]
class AnimatedSmoothIndicator extends ImplicitlyAnimatedWidget {
  /// The index of active page
  final int activeIndex;

  /// Holds effect configuration to be used in the [BasicIndicatorPainter]
  /// If null, the effect will be read from [SmoothPageIndicatorTheme] or default to [WormEffect]
  final IndicatorEffect? effect;

  /// layout direction vertical || horizontal
  final Axis axisDirection;

  /// The number of children in [PageView]
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page direction will be flipped
  final TextDirection? textDirection;

  /// Reports dot-taps
  final Function(int index)? onDotClicked;

  /// Default constructor
  const AnimatedSmoothIndicator({
    super.key,
    required this.activeIndex,
    required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect,
    super.curve = Curves.easeInOut,
    super.duration = const Duration(milliseconds: 300),
    super.onEnd,
  });

  @override
  AnimatedWidgetBaseState<AnimatedSmoothIndicator> createState() =>
      _AnimatedSmoothIndicatorState();
}

class _AnimatedSmoothIndicatorState
    extends AnimatedWidgetBaseState<AnimatedSmoothIndicator>
    with _SizeAndRotationCalculatorMixin {
  Tween<double>? _offset;
  late IndicatorEffect _effect;

  @override
  void didUpdateWidget(covariant AnimatedSmoothIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateEffect();
    updateSizeAndRotation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateEffect();
    updateSizeAndRotation();
  }

  void _updateEffect() {
    _effect = widget.effect ??
        SmoothPageIndicatorTheme.of(context)?.effect ??
        const WormEffect();
  }

  @override
  void forEachTween(visitor) {
    _offset = visitor(
      _offset,
      widget.activeIndex.toDouble(),
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>;
  }

  @override
  int get count => widget.count;

  @override
  IndicatorEffect get effect => _effect;

  @override
  Axis get axisDirection => widget.axisDirection;

  @override
  TextDirection? get textDirection => widget.textDirection;

  @override
  Widget build(BuildContext context) {
    final offset = _offset;
    if (offset == null) {
      throw 'Offset has not been initialized';
    }
    return SmoothIndicator(
      offset: offset.evaluate(animation) % count,
      count: widget.count,
      effect: effect,
      onDotClicked: widget.onDotClicked,
      size: size,
      quarterTurns: quarterTurns,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
    properties.add(DiagnosticsProperty<IndicatorEffect>('effect', effect));
    properties.add(DiagnosticsProperty<Size>('size', size));
    properties.add(IntProperty('quarterTurns', quarterTurns));
  }
}
