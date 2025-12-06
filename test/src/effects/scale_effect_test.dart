import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('ScaleEffect', () {
    test('default values are correct', () {
      const effect = ScaleEffect();

      expect(effect.scale, 1.4);
      expect(effect.activePaintStyle, PaintingStyle.fill);
    });

    test('calculateSize accounts for scale', () {
      const effect = ScaleEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 10,
        scale: 1.5,
      );

      final size = effect.calculateSize(5);
      // (dotWidth * nonActiveCount) + (spacing * nonActiveCount) + activeDotWidth
      final activeDotWidth = 16 * 1.5;
      expect(size.width, (16 * 4) + (10 * 4) + activeDotWidth);
      expect(size.height, activeDotWidth);
    });

    test('buildPainter returns IndicatorPainter', () {
      const effect = ScaleEffect();
      final painter = effect.buildPainter(5, 0);

      expect(painter, isA<IndicatorPainter>());
    });

    testWidgets('paints correctly', (tester) async {
      const effect = ScaleEffect();

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

    testWidgets('with stroke active paint style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SmoothIndicator(
              offset: 0,
              count: 5,
              size: Size(150, 30),
              effect: ScaleEffect(
                activePaintStyle: PaintingStyle.stroke,
                activeStrokeWidth: 2.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothIndicator), findsOneWidget);
    });
  });
}
