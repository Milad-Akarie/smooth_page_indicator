import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('ColorTransitionEffect', () {
    test('default values are correct', () {
      const effect = ColorTransitionEffect();

      expect(effect.activeStrokeWidth, 1.5);
      expect(effect.dotColor, Colors.grey);
      expect(effect.activeDotColor, Colors.indigo);
    });

    test('buildPainter returns IndicatorPainter', () {
      const effect = ColorTransitionEffect();
      final painter = effect.buildPainter(5, 0);

      expect(painter, isA<IndicatorPainter>());
    });

    test('calculateSize returns correct size', () {
      const effect = ColorTransitionEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
      );

      final size = effect.calculateSize(5);
      expect(size.width, 16 * 5 + 8 * 4);
      expect(size.height, 16);
    });

    testWidgets('paints correctly', (tester) async {
      const effect = ColorTransitionEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: effect.buildPainter(5, 1.5),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
