import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/swap_painter.dart';

void main() {
  group('SwapPainter', () {
    test('creates painter with correct properties', () {
      const effect = SwapEffect();
      final painter = SwapPainter(
        indicatorColors: IndicatorColors.defaults,
        effect: effect,
        count: 5,
        offset: 0.0,
      );

      expect(painter.count, 5);
      expect(painter.offset, 0.0);
      expect(painter.effect, effect);
    });

    test('shouldRepaint returns true when offset changes', () {
      const effect = SwapEffect();
      final painter1 = SwapPainter(
          indicatorColors: IndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);
      final painter2 = SwapPainter(
          indicatorColors: IndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 1.0);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      const effect = SwapEffect();
      final painter1 = SwapPainter(
          indicatorColors: IndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);
      final painter2 = SwapPainter(
          indicatorColors: IndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('paints correctly at offset 0', (tester) async {
      const effect = SwapEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
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
      const effect = SwapEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
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

    testWidgets('paints with SwapType.normal', (tester) async {
      const effect = SwapEffect(type: SwapType.normal);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
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

    testWidgets('paints with SwapType.yRotation', (tester) async {
      const effect = SwapEffect(type: SwapType.yRotation);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
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

    testWidgets('paints with SwapType.zRotation', (tester) async {
      const effect = SwapEffect(type: SwapType.zRotation);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
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

    testWidgets('paints with zRotation at offset > 0.5', (tester) async {
      const effect = SwapEffect(type: SwapType.zRotation);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 1.7, // dotOffset > 0.5
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('handles portal travel (offset > count - 1)', (tester) async {
      const effect = SwapEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
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
      const effect = SwapEffect(
        dotColor: Colors.cyan,
        activeDotColor: Colors.lime,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
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
      const effect = SwapEffect(
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
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

    testWidgets('paints with custom dot dimensions', (tester) async {
      const effect = SwapEffect(
        dotWidth: 14.0,
        dotHeight: 14.0,
        spacing: 10.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
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

    testWidgets('paints with yRotation transitioning', (tester) async {
      const effect = SwapEffect(type: SwapType.yRotation);

      // Test various points along the rotation arc
      for (var offset = 0.0; offset < 1.0; offset += 0.2) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                size: effect.calculateSize(5),
                painter: SwapPainter(
                  indicatorColors: IndicatorColors.defaults,
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

    testWidgets('paints at last dot in list', (tester) async {
      const effect = SwapEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SwapPainter(
                indicatorColors: IndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 4.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });

  group('SwapPainter Golden Tests', () {
    final offsets = [0.0, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 2.5, 3.0];

    goldenTest(
      'renders correctly at different offsets',
      fileName: 'swap_offsets',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final offset in offsets)
            GoldenTestScenario(
              name: 'offset $offset',
              child: _buildSwapPainter(offset: offset),
            ),
        ],
      ),
    );

    final swapTypes = [SwapType.normal, SwapType.yRotation, SwapType.zRotation];

    goldenTest(
      'renders with different swap types',
      fileName: 'swap_types',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final type in swapTypes)
            GoldenTestScenario(
              name: type.name,
              child: _buildSwapPainter(
                effect: SwapEffect(type: type),
                offset: 0.5,
              ),
            ),
        ],
      ),
    );

    goldenTest(
      'renders swap types at different offsets',
      fileName: 'swap_types_offsets',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final type in swapTypes)
            for (final offset in [0.25, 0.5, 0.75])
              GoldenTestScenario(
                name: '${type.name} $offset',
                child: _buildSwapPainter(
                  effect: SwapEffect(type: type),
                  offset: offset,
                ),
              ),
        ],
      ),
    );
  });
}

Widget _buildSwapPainter({
  IndicatorColors indicatorColors = IndicatorColors.defaults,
  SwapEffect effect = const SwapEffect(),
  int count = 5,
  double offset = 0.0,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16.0),
    child: CustomPaint(
      size: effect.calculateSize(count),
      painter: SwapPainter(
        indicatorColors: indicatorColors,
        effect: effect,
        count: count,
        offset: offset,
      ),
    ),
  );
}
