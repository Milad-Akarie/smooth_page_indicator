import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('WormEffect', () {
    test('default values are correct', () {
      const effect = WormEffect();

      expect(effect.dotWidth, 16.0);
      expect(effect.dotHeight, 16.0);
      expect(effect.spacing, 8.0);
      expect(effect.radius, 16.0);
      expect(effect.dotColor, Colors.grey);
      expect(effect.activeDotColor, Colors.indigo);
      expect(effect.type, WormType.normal);
    });

    test('calculateSize returns correct size', () {
      const effect = WormEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
      );

      final size = effect.calculateSize(5);
      expect(size.width, 16 * 5 + 8 * 4);
      expect(size.height, 16);
    });

    test('buildPainter returns IndicatorPainter', () {
      const effect = WormEffect();
      final painter = effect.buildPainter(5, 0);

      expect(painter, isA<IndicatorPainter>());
    });

    test('hitTestDots returns correct index', () {
      const effect = WormEffect(
        dotWidth: 16,
        spacing: 8,
      );

      expect(effect.hitTestDots(8, 5, 0), 0);
      expect(effect.hitTestDots(30, 5, 0), 1);
      expect(effect.hitTestDots(60, 5, 0), 2);
    });

    test('WormType.thin works correctly', () {
      const effect = WormEffect(type: WormType.thin);
      expect(effect.type, WormType.thin);
    });

    test('WormType.underground works correctly', () {
      const effect = WormEffect(type: WormType.underground);
      expect(effect.type, WormType.underground);
    });

    test('WormType.thinUnderground works correctly', () {
      const effect = WormEffect(type: WormType.thinUnderground);
      expect(effect.type, WormType.thinUnderground);
    });

    test('custom colors', () {
      const effect = WormEffect(
        dotColor: Colors.red,
        activeDotColor: Colors.blue,
      );

      expect(effect.dotColor, Colors.red);
      expect(effect.activeDotColor, Colors.blue);
    });

    test('custom dimensions', () {
      const effect = WormEffect(
        dotWidth: 20,
        dotHeight: 10,
        spacing: 15,
        radius: 5,
      );

      expect(effect.dotWidth, 20);
      expect(effect.dotHeight, 10);
      expect(effect.spacing, 15);
      expect(effect.radius, 5);
    });

    testWidgets('paints correctly', (tester) async {
      const effect = WormEffect();

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

    testWidgets('handles portal travel (offset > count - 1)', (tester) async {
      const effect = WormEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: effect.buildPainter(5, 4.5),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('thin type paints correctly', (tester) async {
      const effect = WormEffect(type: WormType.thin);

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

    testWidgets('underground type paints correctly', (tester) async {
      const effect = WormEffect(type: WormType.underground);

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

    testWidgets('thinUnderground type paints correctly', (tester) async {
      const effect = WormEffect(type: WormType.thinUnderground);

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

    testWidgets('stroke painting style renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SmoothIndicator(
              offset: 0,
              count: 5,
              size: Size(120, 16),
              effect: WormEffect(
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 2.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothIndicator), findsOneWidget);
    });
  });
}
