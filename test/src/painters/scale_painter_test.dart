import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/scale_painter.dart';

void main() {
  group('ScalePainter', () {
    test('creates painter with correct properties', () {
      const effect = ScaleEffect();
      final painter = ScalePainter(
        effect: effect,
        count: 5,
        offset: 0.0,
        indicatorColors: DefaultIndicatorColors.defaults,
      );

      expect(painter.count, 5);
      expect(painter.offset, 0.0);
      expect(painter.effect, effect);
    });

    test('shouldRepaint returns true when offset changes', () {
      const effect = ScaleEffect();
      final painter1 = ScalePainter(
          effect: effect,
          count: 5,
          offset: 0.0,
          indicatorColors: DefaultIndicatorColors.defaults);
      final painter2 = ScalePainter(
          effect: effect,
          count: 5,
          offset: 1.0,
          indicatorColors: DefaultIndicatorColors.defaults);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      const effect = ScaleEffect();
      final painter1 = ScalePainter(
          effect: effect,
          count: 5,
          offset: 0.0,
          indicatorColors: DefaultIndicatorColors.defaults);
      final painter2 = ScalePainter(
          effect: effect,
          count: 5,
          offset: 0.0,
          indicatorColors: DefaultIndicatorColors.defaults);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('paints correctly at offset 0', (tester) async {
      const effect = ScaleEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScalePainter(
                effect: effect,
                count: 5,
                offset: 0.0,
                indicatorColors: DefaultIndicatorColors.defaults,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints correctly at fractional offset', (tester) async {
      const effect = ScaleEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScalePainter(
                effect: effect,
                count: 5,
                offset: 2.5,
                indicatorColors: DefaultIndicatorColors.defaults,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('handles portal travel (offset > count - 1)', (tester) async {
      const effect = ScaleEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScalePainter(
                effect: effect,
                count: 5,
                offset: 4.5,
                indicatorColors: DefaultIndicatorColors.defaults,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom scale', (tester) async {
      const effect = ScaleEffect(scale: 2.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScalePainter(
                effect: effect,
                count: 5,
                offset: 1.5,
                indicatorColors: DefaultIndicatorColors.defaults,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom colors', (tester) async {
      const effect = ScaleEffect(
        dotColor: Colors.amber,
        activeDotColor: Colors.deepPurple,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScalePainter(
                effect: effect,
                count: 5,
                offset: 0.0,
                indicatorColors: DefaultIndicatorColors.defaults,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with stroke style', (tester) async {
      const effect = ScaleEffect(
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScalePainter(
                effect: effect,
                count: 5,
                offset: 0.0,
                indicatorColors: DefaultIndicatorColors.defaults,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom active stroke width', (tester) async {
      const effect = ScaleEffect(
        activePaintStyle: PaintingStyle.stroke,
        activeStrokeWidth: 3.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScalePainter(
                effect: effect,
                count: 5,
                offset: 2.0,
                indicatorColors: DefaultIndicatorColors.defaults,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom dot dimensions', (tester) async {
      const effect = ScaleEffect(
        dotWidth: 10.0,
        dotHeight: 10.0,
        spacing: 5.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScalePainter(
                effect: effect,
                count: 5,
                offset: 1.0,
                indicatorColors: DefaultIndicatorColors.defaults,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints transitioning between dots', (tester) async {
      const effect = ScaleEffect();

      // Test various transitional states
      for (var offset = 0.0; offset <= 4.0; offset += 0.5) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                size: effect.calculateSize(5),
                painter: ScalePainter(
                  effect: effect,
                  count: 5,
                  offset: offset,
                  indicatorColors: DefaultIndicatorColors.defaults,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(CustomPaint), findsWidgets);
      }
    });

    testWidgets('paints with activePaintStyle stroke', (tester) async {
      const effect = ScaleEffect(
        activePaintStyle: PaintingStyle.stroke,
        activeStrokeWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScalePainter(
                effect: effect,
                count: 5,
                offset: 0.0,
                indicatorColors: DefaultIndicatorColors.defaults,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });

  group('ScalePainter Golden Tests', () {
    final offsets = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0];

    goldenTest(
      'renders correctly at different offsets',
      fileName: 'scale_offsets',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final offset in offsets)
            GoldenTestScenario(
              name: 'offset $offset',
              child: _buildScalePainter(offset: offset),
            ),
        ],
      ),
    );

    final scales = [1.2, 1.5, 2.0];

    goldenTest(
      'renders with different scale values',
      fileName: 'scale_values',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final scale in scales)
            GoldenTestScenario(
              name: 'scale $scale',
              child: _buildScalePainter(
                effect: ScaleEffect(scale: scale),
                offset: 1.5,
              ),
            ),
        ],
      ),
    );

    final paintStyles = [PaintingStyle.fill, PaintingStyle.stroke];

    goldenTest(
      'renders with different paint styles',
      fileName: 'scale_paint_styles',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final style in paintStyles)
            GoldenTestScenario(
              name: style.name,
              child: _buildScalePainter(
                effect: ScaleEffect(
                  activePaintStyle: style,
                  activeStrokeWidth: 2.0,
                ),
                offset: 1.5,
              ),
            ),
        ],
      ),
    );
  });
}

Widget _buildScalePainter({
  DefaultIndicatorColors indicatorColors = DefaultIndicatorColors.defaults,
  ScaleEffect effect = const ScaleEffect(),
  int count = 5,
  double offset = 0.0,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16.0),
    child: CustomPaint(
      size: effect.calculateSize(count),
      painter: ScalePainter(
        indicatorColors: indicatorColors,
        effect: effect,
        count: count,
        offset: offset,
      ),
    ),
  );
}
