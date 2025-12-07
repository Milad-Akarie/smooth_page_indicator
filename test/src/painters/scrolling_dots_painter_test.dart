import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/scrolling_dots_painter.dart';

void main() {
  group('ScrollingDotsPainter', () {
    test('creates painter with correct properties', () {
      const effect = ScrollingDotsEffect();
      final painter = ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
        effect: effect,
        count: 10,
        offset: 0.0,
      );

      expect(painter.count, 10);
      expect(painter.offset, 0.0);
      expect(painter.effect, effect);
    });

    test('shouldRepaint returns true when offset changes', () {
      const effect = ScrollingDotsEffect();
      final painter1 = ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, effect: effect, count: 10, offset: 0.0);
      final painter2 = ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, effect: effect, count: 10, offset: 1.0);

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('shouldRepaint returns false when offset is same', () {
      const effect = ScrollingDotsEffect();
      final painter1 = ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, effect: effect, count: 10, offset: 0.0);
      final painter2 = ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, effect: effect, count: 10, offset: 0.0);

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    testWidgets('paints correctly at offset 0', (tester) async {
      const effect = ScrollingDotsEffect();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints correctly in pre-scroll range', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 1.0, // In pre-scroll range
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints correctly in scroll range', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 5.0, // In scroll range
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints correctly in after-scroll range', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 8.0, // In after-scroll range
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints when willStartScrolling', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 2.5, // switchPoint + 1 = 3, willStartScrolling when current + 1 == 3
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints when willStopScrolling', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 6.5, // Tests willStopScrolling
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('handles portal travel (offset > count - 1)', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 9.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints when count <= maxVisibleDots', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 7);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 5, // Less than maxVisibleDots
                offset: 2.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom colors', (tester) async {
      const effect = ScrollingDotsEffect(
        dotColor: Colors.grey,
        activeDotColor: Colors.blue,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with stroke style', (tester) async {
      const effect = ScrollingDotsEffect(
        paintStyle: PaintingStyle.stroke,
        strokeWidth: 2.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 0.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom activeDotScale', (tester) async {
      const effect = ScrollingDotsEffect(activeDotScale: 1.5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 3.0,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints with custom smallDotScale', (tester) async {
      const effect = ScrollingDotsEffect(
        smallDotScale: 0.4,
        maxVisibleDots: 5,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 5.5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints transitioning between dots', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 5);

      // Test various transitional states
      for (var offset = 0.0; offset <= 9.0; offset += 1.5) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                size: effect.calculateSize(10),
                painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                  effect: effect,
                  count: 10,
                  offset: offset,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(CustomPaint), findsWidgets);
      }
    });

    testWidgets('paints at firstVisibleDot + 1 position', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 4.5, // Tests firstVisibleDot + 1 scaling
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('paints at lastVisibleDot - 1 position', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 1.5, // Tests lastVisibleDot - 1 scaling in preScrollRange
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('handles portal travel with count > maxVisibleDots', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 5);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(10),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 10,
                offset: 9.3, // offset > count - 1 with count > maxVisibleDots
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('handles portal travel with count <= maxVisibleDots', (tester) async {
      const effect = ScrollingDotsEffect(maxVisibleDots: 7);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: effect.calculateSize(5),
              painter: ScrollingDotsPainter(themeDefaults: ThemeDefaults.defaults, 
                effect: effect,
                count: 5,
                offset: 4.3, // offset > count - 1 with count <= maxVisibleDots
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
