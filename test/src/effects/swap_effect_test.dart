import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('SwapEffect', () {
    test('calculateSize for normal type', () {
      const effect = SwapEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
        type: SwapType.normal,
      );

      final size = effect.calculateSize(5);
      expect(size.width, 16 * 5 + 8 * 5);
      expect(size.height, 16);
    });

    test('calculateSize for zRotation type', () {
      const effect = SwapEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
        type: SwapType.zRotation,
      );

      final size = effect.calculateSize(5);
      expect(size.height, 16 + 16 * 0.2);
    });

    test('calculateSize for yRotation type', () {
      const effect = SwapEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
        type: SwapType.yRotation,
      );

      final size = effect.calculateSize(5);
      expect(size.height, 16 + 16 + 8);
    });

    test('buildPainter returns IndicatorPainter', () {
      const effect = SwapEffect();
      final painter =
          effect.buildPainter(5, 0, DefaultIndicatorColors.defaults);

      expect(painter, isA<IndicatorPainter>());
    });

    testWidgets('paints correctly', (tester) async {
      const effect = SwapEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter:
                  effect.buildPainter(5, 1.5, DefaultIndicatorColors.defaults),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('yRotation type paints correctly', (tester) async {
      const effect = SwapEffect(type: SwapType.yRotation);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter:
                  effect.buildPainter(5, 1.5, DefaultIndicatorColors.defaults),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('zRotation type paints correctly', (tester) async {
      const effect = SwapEffect(type: SwapType.zRotation);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter:
                  effect.buildPainter(5, 1.5, DefaultIndicatorColors.defaults),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
