import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/scrolling_dots_painter_with_fixed_center.dart';

void main() {
  group('ScrollingDotsWithFixedCenterPainter', () {
    test('creates painter with correct properties', () {
      const effect = ScrollingDotsEffect(fixedCenter: true);
      final painter = ScrollingDotsWithFixedCenterPainter(
        effect: effect,
        count: 10,
        offset: 0.0,
      );

      expect(painter.count, 10);
      expect(painter.offset, 0.0);
      expect(painter.effect, effect);
    });

    test('shouldRepaint returns true when offset changes', () {
      const effect = ScrollingDotsEffect(fixedCenter: true);
      final painter1 = ScrollingDotsWithFixedCenterPainter(effect: effect, count: 10, offset: 0.0);
      final painter2 = ScrollingDotsWithFixedCenterPainter(effect: effect, count: 10, offset: 1.0);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      const effect = ScrollingDotsEffect(fixedCenter: true);
      final painter1 = ScrollingDotsWithFixedCenterPainter(effect: effect, count: 10, offset: 0.0);
      final painter2 = ScrollingDotsWithFixedCenterPainter(effect: effect, count: 10, offset: 0.0);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('paints correctly at offset 0', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints correctly at center position', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true, maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 5.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints correctly when count > maxVisibleDots', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true, maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 3.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints correctly when count <= maxVisibleDots', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true, maxVisibleDots: 7);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScrollingDotsWithFixedCenterPainter(
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

    testWidgets('paints at switchPoint boundary', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true, maxVisibleDots: 5);
      // switchPoint = (5 - 1) / 2 = 2

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 2.5, // Tests boundary condition
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with scaling at current + switchPoint', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true, maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 4.3, // Tests current + switchPoint scale
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with scaling at current - (switchPoint - 1)', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true, maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 5.7, // Tests current - (switchPoint - 1) scale
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with scaling at current - switchPoint', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true, maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 4.8, // Tests current - switchPoint scale
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with scaling at current + (switchPoint + 1)', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true, maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 3.2, // Tests current + (switchPoint + 1) scale
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom colors', (tester) async {
      const effect = ScrollingDotsEffect(
        fixedCenter: true,
        dotColor: Colors.red,
        activeDotColor: Colors.green,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with stroke style', (tester) async {
      const effect = ScrollingDotsEffect(
        fixedCenter: true,
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom activeDotScale', (tester) async {
      const effect = ScrollingDotsEffect(
        fixedCenter: true,
        activeDotScale: 1.8,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 3.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom activeStrokeWidth', (tester) async {
      const effect = ScrollingDotsEffect(
        fixedCenter: true,
        activeStrokeWidth: 3.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 2.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints transitioning between dots', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true, maxVisibleDots: 5);

      // Test various transitional states
      for (var offset = 0.0; offset <= 9.0; offset += 1.5) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                size: effect.calculateSize(10),
                painter: ScrollingDotsWithFixedCenterPainter(
                  effect: effect,
                  count: 10,
                  offset: offset,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(CustomPaint), findsWidgets);
      }
    });

    testWidgets('paints when dots are outside visible range', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true, maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsWithFixedCenterPainter(
                effect: effect,
                count: 10,
                offset: 7.0, // Some dots will be outside visible range
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });

  group('ScrollingDotsWithFixedCenterPainter Golden Tests', () {
    final offsets = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0];

    goldenTest(
      'renders correctly at different offsets',
      fileName: 'scrolling_dots_fixed_center_offsets',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final offset in offsets)
            GoldenTestScenario(
              name: 'offset $offset',
              child: _buildScrollingDotsFixedCenterPainter(offset: offset),
            ),
        ],
      ),
    );

    final maxVisibleDots = [5, 7, 9];

    goldenTest(
      'renders with different max visible dots',
      fileName: 'scrolling_dots_fixed_center_max_visible',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final maxDots in maxVisibleDots)
            GoldenTestScenario(
              name: 'maxVisible $maxDots',
              child: _buildScrollingDotsFixedCenterPainter(
                effect: ScrollingDotsEffect(
                  fixedCenter: true,
                  maxVisibleDots: maxDots,
                ),
                offset: 5.0,
              ),
            ),
        ],
      ),
    );

    final activeDotScales = [1.0, 1.3, 1.5];

    goldenTest(
      'renders with different active dot scales',
      fileName: 'scrolling_dots_fixed_center_scales',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final scale in activeDotScales)
            GoldenTestScenario(
              name: 'scale $scale',
              child: _buildScrollingDotsFixedCenterPainter(
                effect: ScrollingDotsEffect(
                  fixedCenter: true,
                  activeDotScale: scale,
                ),
                offset: 5.0,
              ),
            ),
        ],
      ),
    );
  });
}

Widget _buildScrollingDotsFixedCenterPainter({
  ScrollingDotsEffect effect = const ScrollingDotsEffect(fixedCenter: true),
  int count = 10,
  double offset = 0.0,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16.0),
    child: CustomPaint(
      size: effect.calculateSize(count),
      painter: ScrollingDotsWithFixedCenterPainter(
        effect: effect,
        count: count,
        offset: offset,
      ),
    ),
  );
}
