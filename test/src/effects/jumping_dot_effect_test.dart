import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('JumpingDotEffect', () {
    test('calculateSize accounts for jump scale', () {
      const effect = JumpingDotEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
        jumpScale: 1.5,
        verticalOffset: 0,
      );

      final size = effect.calculateSize(5);
      expect(size.width, 16 * 5 + 8 * 4);
      expect(size.height, 16 * 1.5); // max(dotHeight, dotHeight * jumpScale)
    });

    test('calculateSize accounts for vertical offset', () {
      const effect = JumpingDotEffect(
        dotWidth: 16,
        dotHeight: 16,
        jumpScale: 1.0,
        verticalOffset: 10.0,
      );

      final size = effect.calculateSize(3);
      expect(size.height, 16 + 10); // dotHeight + verticalOffset.abs()
    });

    test('buildPainter returns IndicatorPainter', () {
      const effect = JumpingDotEffect();
      final painter = effect.buildPainter(5, 0, ThemeDefaults.defaults);

      expect(painter, isA<IndicatorPainter>());
    });

    testWidgets('paints correctly', (tester) async {
      const effect = JumpingDotEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: effect.buildPainter(5, 1.5, ThemeDefaults.defaults),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
