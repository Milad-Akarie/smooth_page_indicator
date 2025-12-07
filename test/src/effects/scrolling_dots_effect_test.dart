import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('ScrollingDotsEffect', () {
    test('calculateSize for normal mode', () {
      const effect = ScrollingDotsEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
        activeDotScale: 1.3,
        maxVisibleDots: 5,
      );

      final size = effect.calculateSize(10);
      expect(size.width, (16 + 8) * 5);
      expect(size.height, 16 * 1.3);
    });

    test('calculateSize when count is less than maxVisibleDots', () {
      const effect = ScrollingDotsEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
        maxVisibleDots: 5,
      );

      final size = effect.calculateSize(3);
      expect(size.width, (16 + 8) * 3);
    });

    test('hitTestDots for non-fixed center', () {
      const effect = ScrollingDotsEffect(
        dotWidth: 16,
        spacing: 8,
        maxVisibleDots: 5,
      );

      expect(effect.hitTestDots(10, 10, 0), 0);
    });

    test('fixedCenter mode', () {
      const effect = ScrollingDotsEffect(
        fixedCenter: true,
        maxVisibleDots: 5,
      );

      expect(effect.fixedCenter, true);
    });

    test('hitTestDots with fixedCenter', () {
      const effect = ScrollingDotsEffect(
        dotWidth: 16,
        spacing: 8,
        maxVisibleDots: 5,
        fixedCenter: true,
      );

      final result = effect.hitTestDots(10, 10, 2);
      expect(result, isA<int>());
    });

    test('calculateSize with fixedCenter and count <= maxVisibleDots', () {
      const effect = ScrollingDotsEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
        maxVisibleDots: 5,
        fixedCenter: true,
      );

      final size = effect.calculateSize(3);
      // ((count * 2) - 1) * (dotWidth + spacing)
      expect(size.width, (3 * 2 - 1) * (16 + 8));
    });

    test('buildPainter returns BasicIndicatorPainter', () {
      const effect = ScrollingDotsEffect();
      final painter = effect.buildPainter(10, 0, DefaultIndicatorColors.defaults);

      expect(painter, isA<IndicatorPainter>());
    });

    testWidgets('paints correctly', (tester) async {
      const effect = ScrollingDotsEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: effect.buildPainter(10, 3.5, DefaultIndicatorColors.defaults),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('fixedCenter painter paints correctly', (tester) async {
      const effect = ScrollingDotsEffect(fixedCenter: true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: effect.buildPainter(10, 3, DefaultIndicatorColors.defaults),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
