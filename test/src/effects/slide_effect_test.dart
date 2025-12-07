import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('SlideEffect', () {
    test('SlideType.slideUnder works correctly', () {
      const effect = SlideEffect(type: SlideType.slideUnder);
      expect(effect.type, SlideType.slideUnder);
    });

    test('buildPainter returns IndicatorPainter', () {
      const effect = SlideEffect();
      final painter = effect.buildPainter(5, 0, IndicatorColors.defaults);

      expect(painter, isA<IndicatorPainter>());
    });

    test('calculateSize returns correct size', () {
      const effect = SlideEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
      );

      final size = effect.calculateSize(5);
      expect(size.width, 16 * 5 + 8 * 4);
      expect(size.height, 16);
    });

    testWidgets('paints correctly', (tester) async {
      const effect = SlideEffect();

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

    testWidgets('slideUnder type paints correctly', (tester) async {
      const effect = SlideEffect(type: SlideType.slideUnder);

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
