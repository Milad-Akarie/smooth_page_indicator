import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/customizable_painter.dart';

void main() {
  group('CustomizablePainter', () {
    const defaultEffect = CustomizableEffect(
      dotDecoration: DotDecoration(
        width: 10,
        height: 10,
        color: Colors.grey,
      ),
      activeDotDecoration: DotDecoration(
        width: 14,
        height: 14,
        color: Colors.blue,
      ),
    );

    test('creates painter with correct properties', () {
      final painter = CustomizablePainter(
        effect: defaultEffect,
        count: 5,
        offset: 0.0,
      );

      expect(painter.count, 5);
      expect(painter.offset, 0.0);
      expect(painter.effect, defaultEffect);
    });

    test('shouldRepaint returns true when offset changes', () {
      final painter1 = CustomizablePainter(effect: defaultEffect, count: 5, offset: 0.0);
      final painter2 = CustomizablePainter(effect: defaultEffect, count: 5, offset: 1.0);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      final painter1 = CustomizablePainter(effect: defaultEffect, count: 5, offset: 0.0);
      final painter2 = CustomizablePainter(effect: defaultEffect, count: 5, offset: 0.0);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('paints correctly at offset 0', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: defaultEffect.calculateSize(5),
              painter: CustomizablePainter(
                effect: defaultEffect,
                count: 5,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints correctly at fractional offset', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: defaultEffect.calculateSize(5),
              painter: CustomizablePainter(
                effect: defaultEffect,
                count: 5,
                offset: 2.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('handles portal travel (offset > count - 1)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: defaultEffect.calculateSize(5),
              painter: CustomizablePainter(
                effect: defaultEffect,
                count: 5,
                offset: 4.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with border decoration', (tester) async {
      const effectWithBorder = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 10,
          height: 10,
          color: Colors.grey,
          dotBorder: DotBorder(
            width: 2,
            color: Colors.black,
            padding: 2,
          ),
        ),
        activeDotDecoration: DotDecoration(
          width: 14,
          height: 14,
          color: Colors.blue,
          dotBorder: DotBorder(
            width: 3,
            color: Colors.red,
            padding: 3,
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effectWithBorder.calculateSize(5),
              painter: CustomizablePainter(
                effect: effectWithBorder,
                count: 5,
                offset: 1.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with vertical offset', (tester) async {
      const effectWithVerticalOffset = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 10,
          height: 10,
          color: Colors.grey,
          verticalOffset: 5,
        ),
        activeDotDecoration: DotDecoration(
          width: 14,
          height: 14,
          color: Colors.blue,
          verticalOffset: -5,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effectWithVerticalOffset.calculateSize(5),
              painter: CustomizablePainter(
                effect: effectWithVerticalOffset,
                count: 5,
                offset: 2.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with activeDotDecoration verticalOffset >= dotDecoration', (tester) async {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 10,
          height: 10,
          color: Colors.grey,
          verticalOffset: 2,
        ),
        activeDotDecoration: DotDecoration(
          width: 14,
          height: 14,
          color: Colors.blue,
          verticalOffset: 10,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: CustomizablePainter(
                effect: effect,
                count: 5,
                offset: 1.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with rotation angle', (tester) async {
      const effectWithRotation = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 10,
          height: 10,
          color: Colors.grey,
          rotationAngle: 0,
        ),
        activeDotDecoration: DotDecoration(
          width: 14,
          height: 14,
          color: Colors.blue,
          rotationAngle: 45,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effectWithRotation.calculateSize(5),
              painter: CustomizablePainter(
                effect: effectWithRotation,
                count: 5,
                offset: 1.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with border radius', (tester) async {
      const effectWithBorderRadius = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 10,
          height: 10,
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        activeDotDecoration: DotDecoration(
          width: 14,
          height: 14,
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effectWithBorderRadius.calculateSize(5),
              painter: CustomizablePainter(
                effect: effectWithBorderRadius,
                count: 5,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with activeColorOverride', (tester) async {
      final effectWithColorOverride = CustomizableEffect(
        dotDecoration: const DotDecoration(
          width: 10,
          height: 10,
          color: Colors.grey,
        ),
        activeDotDecoration: const DotDecoration(
          width: 14,
          height: 14,
          color: Colors.blue,
        ),
        activeColorOverride: (index) => Colors.primaries[index % Colors.primaries.length],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effectWithColorOverride.calculateSize(5),
              painter: CustomizablePainter(
                effect: effectWithColorOverride,
                count: 5,
                offset: 2.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with inActiveColorOverride', (tester) async {
      final effectWithColorOverride = CustomizableEffect(
        dotDecoration: const DotDecoration(
          width: 10,
          height: 10,
          color: Colors.grey,
        ),
        activeDotDecoration: const DotDecoration(
          width: 14,
          height: 14,
          color: Colors.blue,
        ),
        inActiveColorOverride: (index) => Colors.accents[index % Colors.accents.length],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effectWithColorOverride.calculateSize(5),
              painter: CustomizablePainter(
                effect: effectWithColorOverride,
                count: 5,
                offset: 1.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with both color overrides', (tester) async {
      final effectWithBothOverrides = CustomizableEffect(
        dotDecoration: const DotDecoration(
          width: 10,
          height: 10,
          color: Colors.grey,
        ),
        activeDotDecoration: const DotDecoration(
          width: 14,
          height: 14,
          color: Colors.blue,
        ),
        activeColorOverride: (index) => Colors.primaries[index % Colors.primaries.length],
        inActiveColorOverride: (index) => Colors.accents[index % Colors.accents.length],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effectWithBothOverrides.calculateSize(5),
              painter: CustomizablePainter(
                effect: effectWithBothOverrides,
                count: 5,
                offset: 3.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with zero rotation angle', (tester) async {
      const effectWithZeroRotation = CustomizableEffect(
        dotDecoration: DotDecoration(
          width: 10,
          height: 10,
          color: Colors.grey,
          rotationAngle: 0,
        ),
        activeDotDecoration: DotDecoration(
          width: 14,
          height: 14,
          color: Colors.blue,
          rotationAngle: 0,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effectWithZeroRotation.calculateSize(5),
              painter: CustomizablePainter(
                effect: effectWithZeroRotation,
                count: 5,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints transitioning between dots', (tester) async {
      // Test various transitional states
      for (var offset = 0.0; offset <= 4.0; offset += 0.5) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                size: defaultEffect.calculateSize(5),
                painter: CustomizablePainter(
                  effect: defaultEffect,
                  count: 5,
                  offset: offset,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(CustomPaint), findsWidgets);
      }
    });
  });

  group('DotDecoration', () {
    test('lerp interpolates between two decorations', () {
      const a = DotDecoration(
        width: 10,
        height: 10,
        color: Colors.red,
        verticalOffset: 0,
        rotationAngle: 0,
      );
      const b = DotDecoration(
        width: 20,
        height: 20,
        color: Colors.blue,
        verticalOffset: 10,
        rotationAngle: 90,
      );

      final result = DotDecoration.lerp(a, b, 0.5);

      expect(result.width, 15);
      expect(result.height, 15);
      expect(result.verticalOffset, 5);
      expect(result.rotationAngle, 45);
    });

    test('copyWith creates a new instance with overridden values', () {
      const original = DotDecoration(
        width: 10,
        height: 10,
        color: Colors.red,
      );

      final copied = original.copyWith(width: 20, color: Colors.blue);

      expect(copied.width, 20);
      expect(copied.height, 10);
      expect(copied.color, Colors.blue);
    });

    test('copyWith retains original values when not overridden', () {
      const original = DotDecoration(
        width: 10,
        height: 10,
        color: Colors.red,
        verticalOffset: 5,
        rotationAngle: 30,
      );

      final copied = original.copyWith();

      expect(copied.width, original.width);
      expect(copied.height, original.height);
      expect(copied.color, original.color);
      expect(copied.verticalOffset, original.verticalOffset);
      expect(copied.rotationAngle, original.rotationAngle);
    });
  });

  group('DotBorder', () {
    test('neededSpace returns 0 for none type', () {
      const border = DotBorder(type: DotBorderType.none);
      expect(border.neededSpace, 0.0);
    });

    test('neededSpace returns correct value for solid type', () {
      const border = DotBorder(
        width: 2.0,
        padding: 3.0,
        type: DotBorderType.solid,
      );
      // neededSpace = width / 2 + (padding * 2) = 1 + 6 = 7
      expect(border.neededSpace, 7.0);
    });

    test('DotBorder.none has correct properties', () {
      expect(DotBorder.none.width, 0.0);
      expect(DotBorder.none.color, Colors.transparent);
      expect(DotBorder.none.padding, 0.0);
      expect(DotBorder.none.type, DotBorderType.none);
    });
  });

  group('CustomizableEffect', () {
    test('calculateSize returns correct size', () {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(width: 10, height: 10),
        activeDotDecoration: DotDecoration(width: 14, height: 14),
        spacing: 8,
      );

      final size = effect.calculateSize(5);

      // maxWidth = dotWidth * (count - 1) + (spacing * count) + activeDotWidth
      // = 10 * 4 + 8 * 5 + 14 = 40 + 40 + 14 = 94
      expect(size.width, 94);
      expect(size.height, 14);
    });

    test('hitTestDots returns correct index', () {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(width: 10, height: 10),
        activeDotDecoration: DotDecoration(width: 14, height: 14),
        spacing: 8,
      );

      // Test at first dot
      expect(effect.hitTestDots(5, 5, 0), 0);

      // Test at second dot (after first active dot)
      expect(effect.hitTestDots(25, 5, 0), 1);
    });

    test('hitTestDots returns -1 when outside dots', () {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(width: 10, height: 10),
        activeDotDecoration: DotDecoration(width: 14, height: 14),
        spacing: 8,
      );

      expect(effect.hitTestDots(200, 5, 0), -1);
    });

    test('buildPainter returns CustomizablePainter', () {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(width: 10, height: 10),
        activeDotDecoration: DotDecoration(width: 14, height: 14),
      );

      final painter = effect.buildPainter(5, 0);
      expect(painter, isA<CustomizablePainter>());
    });
  });

  group('CustomizablePainter Golden Tests', () {
    const defaultEffect = CustomizableEffect(
      dotDecoration: DotDecoration(
        width: 10,
        height: 10,
        color: Colors.grey,
      ),
      activeDotDecoration: DotDecoration(
        width: 14,
        height: 14,
        color: Colors.blue,
      ),
    );

    final offsets = [0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0];

    goldenTest(
      'renders correctly at different offsets',
      fileName: 'customizable_offsets',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          for (final offset in offsets)
            GoldenTestScenario(
              name: 'offset $offset',
              child: _buildCustomizablePainter(
                effect: defaultEffect,
                offset: offset,
              ),
            ),
        ],
      ),
    );

    goldenTest(
      'renders with different dot sizes',
      fileName: 'customizable_dot_sizes',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 250),
        children: [
          GoldenTestScenario(
            name: 'small to large',
            child: _buildCustomizablePainter(
              effect: const CustomizableEffect(
                dotDecoration: DotDecoration(width: 8, height: 8, color: Colors.grey),
                activeDotDecoration: DotDecoration(width: 20, height: 20, color: Colors.blue),
              ),
              offset: 1.5,
            ),
          ),
          GoldenTestScenario(
            name: 'large to small',
            child: _buildCustomizablePainter(
              effect: const CustomizableEffect(
                dotDecoration: DotDecoration(width: 16, height: 16, color: Colors.grey),
                activeDotDecoration: DotDecoration(width: 10, height: 10, color: Colors.blue),
              ),
              offset: 1.5,
            ),
          ),
          GoldenTestScenario(
            name: 'wide dots',
            child: _buildCustomizablePainter(
              effect: const CustomizableEffect(
                dotDecoration: DotDecoration(width: 20, height: 8, color: Colors.grey),
                activeDotDecoration: DotDecoration(width: 30, height: 12, color: Colors.blue),
              ),
              offset: 1.5,
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'renders with different border radius',
      fileName: 'customizable_border_radius',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          GoldenTestScenario(
            name: 'circular',
            child: _buildCustomizablePainter(
              effect: const CustomizableEffect(
                dotDecoration: DotDecoration(
                  width: 12,
                  height: 12,
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                activeDotDecoration: DotDecoration(
                  width: 16,
                  height: 16,
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              offset: 1.5,
            ),
          ),
          GoldenTestScenario(
            name: 'square',
            child: _buildCustomizablePainter(
              effect: const CustomizableEffect(
                dotDecoration: DotDecoration(
                  width: 12,
                  height: 12,
                  color: Colors.grey,
                  borderRadius: BorderRadius.zero,
                ),
                activeDotDecoration: DotDecoration(
                  width: 16,
                  height: 16,
                  color: Colors.blue,
                  borderRadius: BorderRadius.zero,
                ),
              ),
              offset: 1.5,
            ),
          ),
        ],
      ),
    );

    goldenTest(
      'renders with vertical offset',
      fileName: 'customizable_vertical_offset',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 200),
        children: [
          GoldenTestScenario(
            name: 'active above',
            child: _buildCustomizablePainter(
              effect: const CustomizableEffect(
                dotDecoration: DotDecoration(width: 10, height: 10, color: Colors.grey),
                activeDotDecoration: DotDecoration(
                  width: 14,
                  height: 14,
                  color: Colors.blue,
                  verticalOffset: -10,
                ),
              ),
              offset: 1.5,
            ),
          ),
          GoldenTestScenario(
            name: 'active below',
            child: _buildCustomizablePainter(
              effect: const CustomizableEffect(
                dotDecoration: DotDecoration(width: 10, height: 10, color: Colors.grey),
                activeDotDecoration: DotDecoration(
                  width: 14,
                  height: 14,
                  color: Colors.blue,
                  verticalOffset: 10,
                ),
              ),
              offset: 1.5,
            ),
          ),
        ],
      ),
    );
  });
}

Widget _buildCustomizablePainter({
  required CustomizableEffect effect,
  int count = 5,
  double offset = 0.0,
}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16.0),
    child: CustomPaint(
      size: effect.calculateSize(count),
      painter: CustomizablePainter(
        effect: effect,
        count: count,
        offset: offset,
      ),
    ),
  );
}
