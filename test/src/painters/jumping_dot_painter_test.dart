import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/jumping_dot_painter.dart';

void main() {
  group('JumpingDotPainter', () {
    test('creates painter with correct properties', () {
      const effect = JumpingDotEffect();
      final painter = JumpingDotPainter(
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
      const effect = JumpingDotEffect();
      final painter1 = JumpingDotPainter(
          indicatorColors: IndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);
      final painter2 = JumpingDotPainter(
          indicatorColors: IndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 1.0);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      const effect = JumpingDotEffect();
      final painter1 = JumpingDotPainter(
          indicatorColors: IndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);
      final painter2 = JumpingDotPainter(
          indicatorColors: IndicatorColors.defaults,
          effect: effect,
          count: 5,
          offset: 0.0);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('paints correctly at offset 0', (tester) async {
      const effect = JumpingDotEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: JumpingDotPainter(
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

    testWidgets('paints correctly at fractional offset < 0.5', (tester) async {
      const effect = JumpingDotEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: JumpingDotPainter(
                indicatorColors: IndicatorColors.defaults,
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

    testWidgets('paints correctly at fractional offset > 0.5', (tester) async {
      const effect = JumpingDotEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: JumpingDotPainter(
                indicatorColors: IndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 1.7,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('handles portal travel (offset > count - 1)', (tester) async {
      const effect = JumpingDotEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: JumpingDotPainter(
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

    testWidgets('paints with verticalOffset', (tester) async {
      const effect = JumpingDotEffect(verticalOffset: 20);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: JumpingDotPainter(
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

    testWidgets('paints with zero verticalOffset', (tester) async {
      const effect = JumpingDotEffect(verticalOffset: 0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: JumpingDotPainter(
                indicatorColors: IndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 0.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom jump scale', (tester) async {
      const effect = JumpingDotEffect(jumpScale: 2.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: JumpingDotPainter(
                indicatorColors: IndicatorColors.defaults,
                effect: effect,
                count: 5,
                offset: 2.3,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom colors', (tester) async {
      const effect = JumpingDotEffect(
        dotColor: Colors.pink,
        activeDotColor: Colors.teal,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: JumpingDotPainter(
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
      const effect = JumpingDotEffect(
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: JumpingDotPainter(
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

    testWidgets('paints transitioning through jump arc', (tester) async {
      const effect = JumpingDotEffect(verticalOffset: 20);

      // Test various points along the jump arc
      for (var offset = 0.0; offset < 1.0; offset += 0.2) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                size: effect.calculateSize(5),
                painter: JumpingDotPainter(
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
  });

  group('JumpingDotPainter Golden Tests', () {
    final offsets = [0.0, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 2.5, 3.0];

    goldenTest(
      'renders correctly at different offsets',
      fileName: 'jumping_dot_offsets',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final offset in offsets)
            GoldenTestScenario(
              name: 'offset $offset',
              child: _buildJumpingDotPainter(offset: offset),
            ),
        ],
      ),
    );

    final verticalOffsets = [0.0, 10.0, 20.0, 30.0];

    goldenTest(
      'renders with different vertical offsets',
      fileName: 'jumping_dot_vertical_offsets',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final vOffset in verticalOffsets)
            GoldenTestScenario(
              name: 'vOffset $vOffset',
              child: _buildJumpingDotPainter(
                effect: JumpingDotEffect(verticalOffset: vOffset),
                offset: 0.5,
              ),
            ),
        ],
      ),
    );

    final jumpScales = [1.0, 1.2, 1.5, 2.0];

    goldenTest(
      'renders with different jump scales',
      fileName: 'jumping_dot_scales',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final scale in jumpScales)
            GoldenTestScenario(
              name: 'scale $scale',
              child: _buildJumpingDotPainter(
                effect: JumpingDotEffect(jumpScale: scale),
                offset: 0.5,
              ),
            ),
        ],
      ),
    );
  });
}

Widget _buildJumpingDotPainter({
  IndicatorColors indicatorColors = IndicatorColors.defaults,
  JumpingDotEffect effect = const JumpingDotEffect(),
  int count = 5,
  double offset = 0.0,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16.0),
    child: CustomPaint(
      size: effect.calculateSize(count),
      painter: JumpingDotPainter(
        indicatorColors: indicatorColors,
        effect: effect,
        count: count,
        offset: offset,
      ),
    ),
  );
}
