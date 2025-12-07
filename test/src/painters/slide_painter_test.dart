import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/slide_painter.dart';

void main() {
  group('SlidePainter', () {
    test('creates painter with correct properties', () {
      const effect = SlideEffect();
      final painter = SlidePainter(
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
      const effect = SlideEffect();
      final painter1 = SlidePainter(
          indicatorColors: DefaultIndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);
      final painter2 = SlidePainter(
          indicatorColors: DefaultIndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 1.0);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      const effect = SlideEffect();
      final painter1 = SlidePainter(
          indicatorColors: DefaultIndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);
      final painter2 = SlidePainter(
          indicatorColors: DefaultIndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('paints correctly at offset 0', (tester) async {
      const effect = SlideEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SlidePainter(
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
      const effect = SlideEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SlidePainter(
                indicatorColors: DefaultIndicatorColors.defaults,
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

    testWidgets('paints with SlideType.slideUnder', (tester) async {
      const effect = SlideEffect(type: SlideType.slideUnder);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SlidePainter(
                indicatorColors: DefaultIndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 1.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('handles portal travel (offset > count - 1)', (tester) async {
      const effect = SlideEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SlidePainter(
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
      const effect = SlideEffect(
        dotColor: Colors.orange,
        activeDotColor: Colors.purple,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SlidePainter(
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
      const effect = SlideEffect(
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SlidePainter(
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

    testWidgets('paints with custom dot dimensions', (tester) async {
      const effect = SlideEffect(
        dotWidth: 20.0,
        dotHeight: 10.0,
        spacing: 12.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: SlidePainter(
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
  });

  group('SlidePainter Golden Tests', () {
    final offsets = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0];

    goldenTest(
      'renders correctly at different offsets',
      fileName: 'slide_offsets',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final offset in offsets)
            GoldenTestScenario(
              name: 'offset $offset',
              child: _buildSlidePainter(offset: offset),
            ),
        ],
      ),
    );

    final slideTypes = [SlideType.normal, SlideType.slideUnder];

    goldenTest(
      'renders with different slide types',
      fileName: 'slide_types',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final type in slideTypes)
            GoldenTestScenario(
              name: type.name,
              child: _buildSlidePainter(
                effect: SlideEffect(type: type),
                offset: 1.5,
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
      fileName: 'slide_colors',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final config in colorConfigs)
            GoldenTestScenario(
              name: config['name'] as String,
              child: _buildSlidePainter(
                effect: SlideEffect(
                  dotColor: config['dotColor'] as Color,
                  activeDotColor: config['activeColor'] as Color,
                ),
                offset: 1.5,
              ),
            ),
        ],
      ),
    );
  });
}

Widget _buildSlidePainter({
  DefaultIndicatorColors indicatorColors = DefaultIndicatorColors.defaults,
  SlideEffect effect = const SlideEffect(),
  int count = 5,
  double offset = 0.0,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16.0),
    child: CustomPaint(
      size: effect.calculateSize(count),
      painter: SlidePainter(
        indicatorColors: indicatorColors,
        effect: effect,
        count: count,
        offset: offset,
      ),
    ),
  );
}
