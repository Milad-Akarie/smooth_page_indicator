import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('ExpandingDotsEffect', () {
    test('calculateSize accounts for expansion', () {
      const effect = ExpandingDotsEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
        expansionFactor: 3,
      );

      final size = effect.calculateSize(5);
      // ((dotWidth + spacing) * (count - 1)) + (expansionFactor * dotWidth)
      expect(size.width, (16 + 8) * 4 + 3 * 16);
      expect(size.height, 16);
    });

    test('hitTestDots accounts for expanded dot', () {
      const effect = ExpandingDotsEffect(
        dotWidth: 16,
        spacing: 8,
        expansionFactor: 3,
      );

      // First dot is expanded (current = 0)
      expect(effect.hitTestDots(10, 5, 0), 0);
      expect(effect.hitTestDots(50, 5, 0), 0); // Still within expanded dot
      expect(effect.hitTestDots(70, 5, 0), 1);
    });

    test('buildPainter returns IndicatorPainter', () {
      const effect = ExpandingDotsEffect();
      final painter = effect.buildPainter(5, 0, IndicatorColors.defaults);

      expect(painter, isA<IndicatorPainter>());
    });

    testWidgets('paints correctly', (tester) async {
      const effect = ExpandingDotsEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: effect.buildPainter(5, 1.5, IndicatorColors.defaults),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
