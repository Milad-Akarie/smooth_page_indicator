import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/color_transition_painter.dart';

void main() {
  group('TransitionPainter', () {
    test('creates painter with correct properties', () {
      const effect = ColorTransitionEffect();
      final painter = TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
        effect: effect,
        count: 5,
        offset: 0.0,
      );

      expect(painter.count, 5);
      expect(painter.offset, 0.0);
      expect(painter.effect, effect);
    });

    test('shouldRepaint returns true when offset changes', () {
      const effect = ColorTransitionEffect();
      final painter1 = TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, effect: effect, count: 5, offset: 0.0);
      final painter2 = TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, effect: effect, count: 5, offset: 1.0);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      const effect = ColorTransitionEffect();
      final painter1 = TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, effect: effect, count: 5, offset: 0.0);
      final painter2 = TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, effect: effect, count: 5, offset: 0.0);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('paints correctly at offset 0', (tester) async {
      const effect = ColorTransitionEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
                effect: effect,
                count: 5,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints correctly at fractional offset', (tester) async {
      const effect = ColorTransitionEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
                effect: effect,
                count: 5,
                offset: 2.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('handles portal travel (offset > count - 1)', (tester) async {
      const effect = ColorTransitionEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
                effect: effect,
                count: 5,
                offset: 4.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom colors', (tester) async {
      const effect = ColorTransitionEffect(
        dotColor: Colors.brown,
        activeDotColor: Colors.lightBlue,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
                effect: effect,
                count: 5,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with stroke style', (tester) async {
      const effect = ColorTransitionEffect(
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
                effect: effect,
                count: 5,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom activeStrokeWidth', (tester) async {
      const effect = ColorTransitionEffect(
        activeStrokeWidth: 3.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
                effect: effect,
                count: 5,
                offset: 1.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom dot dimensions', (tester) async {
      const effect = ColorTransitionEffect(
        dotWidth: 20.0,
        dotHeight: 10.0,
        spacing: 12.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
                effect: effect,
                count: 5,
                offset: 2.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints transitioning between dots', (tester) async {
      const effect = ColorTransitionEffect();

      // Test various transitional states
      for (var offset = 0.0; offset <= 4.0; offset += 0.5) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                size: effect.calculateSize(5),
                painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
                  effect: effect,
                  count: 5,
                  offset: offset,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(CustomPaint), findsWidgets);
      }
    });

    testWidgets('paints at current dot position', (tester) async {
      const effect = ColorTransitionEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
                effect: effect,
                count: 5,
                offset: 2.3, // current = 2, tests first branch
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints at next dot position', (tester) async {
      const effect = ColorTransitionEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
                effect: effect,
                count: 5,
                offset: 2.7, // current = 2, i = 3 tests second branch
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });

  group('TransitionPainter Golden Tests', () {
    final offsets = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5];

    goldenTest(
      'renders correctly at different offsets',
      fileName: 'color_transition_offsets',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final offset in offsets)
            GoldenTestScenario(
              name: 'offset $offset',
              child: _buildPainter(offset: offset),
            ),
        ],
      ),
    );

    final colorConfigs = <Map<String, dynamic>>[
      {'name': 'blue to red', 'dotColor': Colors.blue, 'activeColor': Colors.red},
      {'name': 'green to orange', 'dotColor': Colors.green, 'activeColor': Colors.orange},
      {'name': 'purple to yellow', 'dotColor': Colors.purple, 'activeColor': Colors.yellow},
    ];

    goldenTest(
      'renders with custom colors',
      fileName: 'color_transition_custom_colors',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final config in colorConfigs)
            GoldenTestScenario(
              name: config['name'] as String,
              child: _buildPainter(
                effect: ColorTransitionEffect(
                  dotColor: config['dotColor'] as Color,
                  activeDotColor: config['activeColor'] as Color,
                ),
                offset: 1.5,
              ),
            ),
        ],
      ),
    );

    final strokeWidths = [1.0, 2.0, 3.0];

    goldenTest(
      'renders with stroke style',
      fileName: 'color_transition_stroke_style',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final strokeWidth in strokeWidths)
            GoldenTestScenario(
              name: 'stroke width $strokeWidth',
              child: _buildPainter(
                effect: ColorTransitionEffect(
                  paintStyle: PaintingStyle.stroke,
                  strokeWidth: strokeWidth,
                ),
                offset: 1.5,
              ),
            ),
        ],
      ),
    );

    final dimensionConfigs = <Map<String, dynamic>>[
      {'name': 'large dots', 'width': 20.0, 'height': 20.0, 'spacing': 16.0},
      {'name': 'wide dots', 'width': 24.0, 'height': 8.0, 'spacing': 10.0},
      {'name': 'tall dots', 'width': 8.0, 'height': 20.0, 'spacing': 12.0},
    ];

    goldenTest(
      'renders with custom dimensions',
      fileName: 'color_transition_dimensions',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 300),
        children: [
          for (final config in dimensionConfigs)
            GoldenTestScenario(
              name: config['name'] as String,
              child: _buildPainter(
                effect: ColorTransitionEffect(
                  dotWidth: config['width'] as double,
                  dotHeight: config['height'] as double,
                  spacing: config['spacing'] as double,
                ),
                offset: 2.0,
              ),
            ),
        ],
      ),
    );

    final dotCounts = [3, 5, 7];

    goldenTest(
      'renders with different dot counts',
      fileName: 'color_transition_dot_counts',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 300),
        children: [
          for (final count in dotCounts)
            GoldenTestScenario(
              name: '$count dots',
              child: _buildPainter(count: count, offset: count / 2),
            ),
        ],
      ),
    );
  });
}

Widget _buildPainter({
  ColorTransitionEffect effect = const ColorTransitionEffect(),
  int count = 5,
  double offset = 0.0,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16.0),
    child: CustomPaint(
      size: effect.calculateSize(count),
      painter: TransitionPainter(indicatorColors: DefaultIndicatorColors.defaults, 
        effect: effect,
        count: count,
        offset: offset,
      ),
    ),
  );
}
