import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/worm_painter.dart';

void main() {
  group('WormPainter', () {
    test('creates painter with correct properties', () {
      const effect = WormEffect();
      final painter = WormPainter(
        indicatorColors: DefaultIndicatorColors.defaults,
        effect: effect,
        count: 5,
        offset: 0.0,
      );

      expect(painter.count, 5);
      expect(painter.offset, 0.0);
      expect(painter.effect, effect);
    });

    test('shouldRepaint returns true when offset changes', () {
      const effect = WormEffect();
      final painter1 = WormPainter(
          indicatorColors: DefaultIndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);
      final painter2 = WormPainter(
          indicatorColors: DefaultIndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 1.0);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      const effect = WormEffect();
      final painter1 = WormPainter(
          indicatorColors: DefaultIndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);
      final painter2 = WormPainter(
          indicatorColors: DefaultIndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('paints correctly at offset 0', (tester) async {
      const effect = WormEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                indicatorColors: DefaultIndicatorColors.defaults,
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
      const effect = WormEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                indicatorColors: DefaultIndicatorColors.defaults,
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

    testWidgets('paints with WormType.thin', (tester) async {
      const effect = WormEffect(type: WormType.thin);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                indicatorColors: DefaultIndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 1.3,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with WormType.underground', (tester) async {
      const effect = WormEffect(type: WormType.underground);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                indicatorColors: DefaultIndicatorColors.defaults,
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

    testWidgets('paints with WormType.thinUnderground', (tester) async {
      const effect = WormEffect(type: WormType.thinUnderground);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                indicatorColors: DefaultIndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 0.7,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with wormOffset > 1', (tester) async {
      const effect = WormEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                indicatorColors: DefaultIndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 2.7, // wormOffset will be > 1
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('handles portal travel (offset > count - 1)', (tester) async {
      const effect = WormEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                indicatorColors: DefaultIndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 4.5, // offset > count - 1
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom colors', (tester) async {
      const effect = WormEffect(
        dotColor: Colors.red,
        activeDotColor: Colors.blue,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                indicatorColors: DefaultIndicatorColors.defaults,
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
      const effect = WormEffect(
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                indicatorColors: DefaultIndicatorColors.defaults,
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

    testWidgets('paints with thin worm at wormOffset > 1', (tester) async {
      const effect = WormEffect(type: WormType.thin);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                indicatorColors: DefaultIndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 2.7, // wormOffset > 1
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });

  group('WormPainter Golden Tests', () {
    final offsets = [0.0, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 2.5, 3.0];

    goldenTest(
      'renders correctly at different offsets',
      fileName: 'worm_offsets',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final offset in offsets)
            GoldenTestScenario(
              name: 'offset $offset',
              child: _buildWormPainter(offset: offset),
            ),
        ],
      ),
    );

    final wormTypes = [
      WormType.normal,
      WormType.thin,
      WormType.underground,
      WormType.thinUnderground,
    ];

    goldenTest(
      'renders with different worm types',
      fileName: 'worm_types',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final type in wormTypes)
            GoldenTestScenario(
              name: type.name,
              child: _buildWormPainter(
                effect: WormEffect(type: type),
                offset: 0.5,
              ),
            ),
        ],
      ),
    );

    goldenTest(
      'renders worm types at wormOffset > 1',
      fileName: 'worm_types_high_offset',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final type in wormTypes)
            GoldenTestScenario(
              name: '${type.name} offset 1.7',
              child: _buildWormPainter(
                effect: WormEffect(type: type),
                offset: 1.7,
              ),
            ),
        ],
      ),
    );

    final colorConfigs = <Map<String, dynamic>>[
      {
        'name': 'blue to red',
        'dotColor': Colors.blue,
        'activeColor': Colors.red
      },
      {
        'name': 'green to orange',
        'dotColor': Colors.green,
        'activeColor': Colors.orange
      },
    ];

    goldenTest(
      'renders with custom colors',
      fileName: 'worm_colors',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final config in colorConfigs)
            GoldenTestScenario(
              name: config['name'] as String,
              child: _buildWormPainter(
                effect: WormEffect(
                  dotColor: config['dotColor'] as Color,
                  activeDotColor: config['activeColor'] as Color,
                ),
                offset: 0.5,
              ),
            ),
        ],
      ),
    );
  });
}

Widget _buildWormPainter({
  DefaultIndicatorColors indicatorColors = DefaultIndicatorColors.defaults,
  WormEffect effect = const WormEffect(),
  int count = 5,
  double offset = 0.0,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16.0),
    child: CustomPaint(
      size: effect.calculateSize(count),
      painter: WormPainter(
        indicatorColors: indicatorColors,
        effect: effect,
        count: count,
        offset: offset,
      ),
    ),
  );
}
