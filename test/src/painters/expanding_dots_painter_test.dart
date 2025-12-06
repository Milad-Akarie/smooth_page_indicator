import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/expanding_dots_painter.dart';

void main() {
  group('ExpandingDotsPainter', () {
    test('creates painter with correct properties', () {
      const effect = ExpandingDotsEffect();
      final painter = ExpandingDotsPainter(
        effect: effect,
        count: 5,
        offset: 0.0,
      );

      expect(painter.count, 5);
      expect(painter.offset, 0.0);
      expect(painter.effect, effect);
    });

    test('shouldRepaint returns true when offset changes', () {
      const effect = ExpandingDotsEffect();
      final painter1 =
          ExpandingDotsPainter(effect: effect, count: 5, offset: 0.0);
      final painter2 =
          ExpandingDotsPainter(effect: effect, count: 5, offset: 1.0);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      const effect = ExpandingDotsEffect();
      final painter1 =
          ExpandingDotsPainter(effect: effect, count: 5, offset: 0.0);
      final painter2 =
          ExpandingDotsPainter(effect: effect, count: 5, offset: 0.0);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('paints correctly at offset 0', (tester) async {
      const effect = ExpandingDotsEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ExpandingDotsPainter(
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
      const effect = ExpandingDotsEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ExpandingDotsPainter(
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

    testWidgets('paints at last dot position', (tester) async {
      const effect = ExpandingDotsEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ExpandingDotsPainter(
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

    testWidgets('handles portal travel (offset > count - 1)', (tester) async {
      const effect = ExpandingDotsEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ExpandingDotsPainter(
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
      const effect = ExpandingDotsEffect(
        dotColor: Colors.green,
        activeDotColor: Colors.yellow,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ExpandingDotsPainter(
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

    testWidgets('paints with custom expansion factor', (tester) async {
      const effect = ExpandingDotsEffect(expansionFactor: 4.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ExpandingDotsPainter(
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

    testWidgets('paints with stroke style', (tester) async {
      const effect = ExpandingDotsEffect(
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ExpandingDotsPainter(
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
      const effect = ExpandingDotsEffect(
        dotWidth: 12.0,
        dotHeight: 12.0,
        spacing: 6.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ExpandingDotsPainter(
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

    testWidgets('paints transitioning between dots', (tester) async {
      const effect = ExpandingDotsEffect();

      // Test various transitional states
      for (var offset = 0.0; offset <= 4.0; offset += 0.5) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                size: effect.calculateSize(5),
                painter: ExpandingDotsPainter(
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
}
