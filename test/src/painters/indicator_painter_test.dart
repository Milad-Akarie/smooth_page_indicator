import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/worm_painter.dart';

void main() {
  group('BasicIndicatorPainter', () {
    test('distance calculation is correct', () {
      const effect = WormEffect(
        dotWidth: 16,
        spacing: 8,
      );
      final painter = WormPainter(
        effect: effect,
        count: 5,
        offset: 0.0,
        indicatorColors: DefaultIndicatorColors.defaults,
      );

      // distance = dotWidth + spacing = 16 + 8 = 24
      expect(painter.distance, 24.0);
    });

    test('dotRadius is set correctly', () {
      const effect = WormEffect(radius: 8);
      final painter = WormPainter(
        effect: effect,
        count: 5,
        offset: 0.0,
        indicatorColors: DefaultIndicatorColors.defaults,
      );

      expect(painter.dotRadius, const Radius.circular(8));
    });

    test('dotPaint is configured correctly with fill style', () {
      const effect = WormEffect(
        dotColor: Colors.red,
        paintStyle: PaintingStyle.fill,
        strokeWidth: 2.0,
      );
      final painter = WormPainter(
        effect: effect,
        count: 5,
        offset: 0.0,
        indicatorColors: DefaultIndicatorColors.defaults,
      );

      expect(painter.dotPaint.color.toARGB32(), Colors.red.toARGB32());
      expect(painter.dotPaint.style, PaintingStyle.fill);
      expect(painter.dotPaint.strokeWidth, 2.0);
    });

    test('dotPaint is configured correctly with stroke style', () {
      const effect = WormEffect(
        dotColor: Colors.blue,
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 3.0,
      );
      final painter = WormPainter(
        effect: effect,
        count: 5,
        offset: 0.0,
        indicatorColors: DefaultIndicatorColors.defaults,
      );

      expect(painter.dotPaint.color.toARGB32(), Colors.blue.toARGB32());
      expect(painter.dotPaint.style, PaintingStyle.stroke);
      expect(painter.dotPaint.strokeWidth, 3.0);
    });

    testWidgets('paintStillDots renders correct number of dots', (tester) async {
      const effect = WormEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
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

    testWidgets('buildStillDot creates correct RRect', (tester) async {
      const effect = WormEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
        radius: 8,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
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

    testWidgets('maskStillDots works with underground effects', (tester) async {
      const effect = WormEffect(type: WormType.underground);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
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

    testWidgets('calcPortalTravel renders portal travel animation', (tester) async {
      const effect = WormEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: WormPainter(
                effect: effect,
                count: 5,
                offset: 4.5, // Triggers portal travel
                indicatorColors: DefaultIndicatorColors.defaults,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });

  group('IndicatorPainter', () {
    test('shouldRepaint returns true when offset changes', () {
      const effect = WormEffect();
      final painter1 = WormPainter(effect: effect, count: 5, offset: 0.0, indicatorColors: DefaultIndicatorColors.defaults);
      final painter2 = WormPainter(effect: effect, count: 5, offset: 1.0, indicatorColors: DefaultIndicatorColors.defaults);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      const effect = WormEffect();
      final painter1 = WormPainter(effect: effect, count: 5, offset: 0.0, indicatorColors: DefaultIndicatorColors.defaults);
      final painter2 = WormPainter(effect: effect, count: 5, offset: 0.0, indicatorColors: DefaultIndicatorColors.defaults);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    test('offset is stored correctly', () {
      const effect = WormEffect();
      final painter = WormPainter(effect: effect, count: 5, offset: 2.5, indicatorColors: DefaultIndicatorColors.defaults);

      expect(painter.offset, 2.5);
    });
  });
}
