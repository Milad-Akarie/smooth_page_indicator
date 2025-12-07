import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('CustomizableEffect', () {
    test('calculateSize works correctly', () {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 8,
          height: 8,
          color: Colors.grey,
        ),
        activeDotDecoration: DotDecoration(
          width: 16,
          height: 8,
          color: Colors.indigo,
        ),
        spacing: 8,
      );

      final size = effect.calculateSize(5);
      // (dotWidth * (count - 1)) + (spacing * count) + activeDotWidth
      expect(size.width, (8 * 4) + (8 * 5) + 16);
    });

    test('hitTestDots returns correct index', () {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 16,
          height: 16,
        ),
        activeDotDecoration: DotDecoration(
          width: 24,
          height: 16,
        ),
        spacing: 8,
      );

      expect(effect.hitTestDots(10, 5, 0), 0);
    });

    test('activeColorOverride and inActiveColorOverride', () {
      final effect = CustomizableEffect(
        dotDecoration: const DotDecoration(),
        activeDotDecoration: const DotDecoration(),
        activeColorOverride: (index) => Colors.red,
        inActiveColorOverride: (index) => Colors.blue,
      );

      expect(effect.activeColorOverride!(0), Colors.red);
      expect(effect.inActiveColorOverride!(0), Colors.blue);
    });

    test('buildPainter returns IndicatorPainter', () {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(),
        activeDotDecoration: DotDecoration(),
      );
      final painter = effect.buildPainter(5, 0, IndicatorColors.defaults);

      expect(painter, isA<IndicatorPainter>());
    });

    testWidgets('paints correctly', (tester) async {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 8,
          height: 8,
          color: Colors.grey,
        ),
        activeDotDecoration: DotDecoration(
          width: 16,
          height: 8,
          color: Colors.indigo,
        ),
      );

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

    testWidgets('with borders paints correctly', (tester) async {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 8,
          height: 8,
          color: Colors.grey,
          dotBorder: DotBorder(
            width: 2,
            color: Colors.black,
            padding: 2,
          ),
        ),
        activeDotDecoration: DotDecoration(
          width: 16,
          height: 8,
          color: Colors.indigo,
          dotBorder: DotBorder(
            width: 2,
            color: Colors.black,
            padding: 2,
          ),
        ),
      );

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

    testWidgets('with rotation paints correctly', (tester) async {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 8,
          height: 8,
          rotationAngle: 0.5,
        ),
        activeDotDecoration: DotDecoration(
          width: 16,
          height: 8,
          rotationAngle: 0,
        ),
      );

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

    testWidgets('with vertical offset paints correctly', (tester) async {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 8,
          height: 8,
          verticalOffset: 5,
        ),
        activeDotDecoration: DotDecoration(
          width: 16,
          height: 8,
          verticalOffset: -5,
        ),
      );

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

  group('DotDecoration', () {
    test('default values are correct', () {
      const decoration = DotDecoration();

      expect(decoration.borderRadius, BorderRadius.zero);
      expect(decoration.color, Colors.white);
      expect(decoration.dotBorder, DotBorder.none);
      expect(decoration.verticalOffset, 0.0);
      expect(decoration.rotationAngle, 0.0);
      expect(decoration.width, 8);
      expect(decoration.height, 8);
    });

    test('lerp interpolates correctly', () {
      const a = DotDecoration(
        width: 8,
        height: 8,
        color: Colors.white,
        verticalOffset: 0,
        rotationAngle: 0,
      );
      const b = DotDecoration(
        width: 16,
        height: 16,
        color: Colors.black,
        verticalOffset: 10,
        rotationAngle: 1,
      );

      final result = DotDecoration.lerp(a, b, 0.5);

      expect(result.width, 12);
      expect(result.height, 12);
      expect(result.verticalOffset, 5);
      expect(result.rotationAngle, 0.5);
    });

    test('copyWith creates new instance with overrides', () {
      const original = DotDecoration(
        width: 8,
        height: 8,
        color: Colors.white,
      );

      final copy = original.copyWith(
        width: 16,
        color: Colors.red,
      );

      expect(copy.width, 16);
      expect(copy.height, 8);
      expect(copy.color, Colors.red);
    });
  });

  group('DotBorder', () {
    test('default values are correct', () {
      const border = DotBorder();

      expect(border.width, 1.0);
      expect(border.color, Colors.black87);
      expect(border.padding, 0.0);
      expect(border.type, DotBorderType.solid);
    });

    test('neededSpace for solid border', () {
      const border = DotBorder(
        width: 2,
        padding: 4,
        type: DotBorderType.solid,
      );

      expect(border.neededSpace, 2 / 2 + 4 * 2);
    });

    test('neededSpace for none border', () {
      expect(DotBorder.none.neededSpace, 0);
    });

    test('lerp interpolates correctly', () {
      const a = DotBorder(
        width: 1,
        padding: 0,
        color: Colors.black,
      );
      const b = DotBorder(
        width: 3,
        padding: 4,
        color: Colors.white,
      );

      final result = DotBorder.lerp(a, b, 0.5);

      expect(result.width, 2);
      expect(result.padding, 2);
    });

    test('lerp returns first when t is 0', () {
      const a = DotBorder(width: 1);
      const b = DotBorder(width: 3);

      final result = DotBorder.lerp(a, b, 0);

      expect(result.width, a.width);
    });
  });
}
