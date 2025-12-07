import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('debugFillProperties', () {
    group('_SmoothPageIndicatorState', () {
      testWidgets('includes count, effect, size, and quarterTurns', (tester) async {
        final controller = PageController();
        const effect = WormEffect(dotWidth: 12, dotHeight: 12);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SmoothPageIndicator(
                controller: controller,
                count: 5,
                effect: effect,
              ),
            ),
          ),
        );

        final state = tester.state<State>(find.byType(SmoothPageIndicator));
        final builder = DiagnosticPropertiesBuilder();
        state.debugFillProperties(builder);

        final properties = builder.properties;

        expect(
          properties.any((p) => p.name == 'count' && p.value == 5),
          isTrue,
          reason: 'Should have count property with value 5',
        );
        expect(
          properties.any((p) => p.name == 'effect' && p.value is WormEffect),
          isTrue,
          reason: 'Should have effect property',
        );
        expect(
          properties.any((p) => p.name == 'size' && p.value is Size),
          isTrue,
          reason: 'Should have size property',
        );
        expect(
          properties.any((p) => p.name == 'quarterTurns'),
          isTrue,
          reason: 'Should have quarterTurns property',
        );
      });

      testWidgets('quarterTurns reflects axisDirection', (tester) async {
        final controller = PageController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SmoothPageIndicator(
                controller: controller,
                count: 3,
                axisDirection: Axis.vertical,
              ),
            ),
          ),
        );

        final state = tester.state<State>(find.byType(SmoothPageIndicator));
        final builder = DiagnosticPropertiesBuilder();
        state.debugFillProperties(builder);

        final quarterTurnsProp = builder.properties.firstWhere((p) => p.name == 'quarterTurns');
        expect(quarterTurnsProp.value, 1, reason: 'Vertical axis should have quarterTurns = 1');
      });
    });

    group('SmoothIndicator', () {
      testWidgets('includes offset, count, effect, size, and quarterTurns', (tester) async {
        const effect = ExpandingDotsEffect(dotWidth: 10, dotHeight: 10);
        const size = Size(100, 10);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SmoothIndicator(
                offset: 2.5,
                count: 5,
                effect: effect,
                size: size,
                quarterTurns: 2,
              ),
            ),
          ),
        );

        final widget = tester.widget<SmoothIndicator>(find.byType(SmoothIndicator));
        final builder = DiagnosticPropertiesBuilder();
        widget.debugFillProperties(builder);

        final properties = builder.properties;

        expect(
          properties.any((p) => p.name == 'offset' && p.value == 2.5),
          isTrue,
          reason: 'Should have offset property with value 2.5',
        );
        expect(
          properties.any((p) => p.name == 'count' && p.value == 5),
          isTrue,
          reason: 'Should have count property with value 5',
        );
        expect(
          properties.any((p) => p.name == 'effect' && p.value is ExpandingDotsEffect),
          isTrue,
          reason: 'Should have effect property',
        );
        expect(
          properties.any((p) => p.name == 'size' && p.value == size),
          isTrue,
          reason: 'Should have size property',
        );
        expect(
          properties.any((p) => p.name == 'quarterTurns' && p.value == 2),
          isTrue,
          reason: 'Should have quarterTurns property with value 2',
        );
      });
    });

    group('_AnimatedSmoothIndicatorState', () {
      testWidgets('includes count, effect, size, and quarterTurns', (tester) async {
        const effect = ScaleEffect(scale: 1.5);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AnimatedSmoothIndicator(
                activeIndex: 2,
                count: 4,
                effect: effect,
              ),
            ),
          ),
        );

        final state = tester.state<State>(find.byType(AnimatedSmoothIndicator));
        final builder = DiagnosticPropertiesBuilder();
        state.debugFillProperties(builder);

        final properties = builder.properties;

        expect(
          properties.any((p) => p.name == 'count' && p.value == 4),
          isTrue,
          reason: 'Should have count property with value 4',
        );
        expect(
          properties.any((p) => p.name == 'effect' && p.value is ScaleEffect),
          isTrue,
          reason: 'Should have effect property',
        );
        expect(
          properties.any((p) => p.name == 'size' && p.value is Size),
          isTrue,
          reason: 'Should have size property',
        );
        expect(
          properties.any((p) => p.name == 'quarterTurns'),
          isTrue,
          reason: 'Should have quarterTurns property',
        );
      });

      testWidgets('quarterTurns reflects vertical axisDirection', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AnimatedSmoothIndicator(
                activeIndex: 0,
                count: 3,
                axisDirection: Axis.vertical,
              ),
            ),
          ),
        );

        final state = tester.state<State>(find.byType(AnimatedSmoothIndicator));
        final builder = DiagnosticPropertiesBuilder();
        state.debugFillProperties(builder);

        final quarterTurnsProp = builder.properties.firstWhere((p) => p.name == 'quarterTurns');
        expect(quarterTurnsProp.value, 1, reason: 'Vertical axis should have quarterTurns = 1');
      });

      testWidgets('quarterTurns reflects RTL textDirection', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: AnimatedSmoothIndicator(
                  activeIndex: 0,
                  count: 3,
                ),
              ),
            ),
          ),
        );

        final state = tester.state<State>(find.byType(AnimatedSmoothIndicator));
        final builder = DiagnosticPropertiesBuilder();
        state.debugFillProperties(builder);

        final quarterTurnsProp = builder.properties.firstWhere((p) => p.name == 'quarterTurns');
        expect(quarterTurnsProp.value, 2, reason: 'RTL direction should have quarterTurns = 2');
      });
    });

    group('property types', () {
      testWidgets('SmoothIndicator uses correct property types', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SmoothIndicator(
                offset: 1.0,
                count: 3,
                size: Size(50, 10),
              ),
            ),
          ),
        );

        final widget = tester.widget<SmoothIndicator>(find.byType(SmoothIndicator));
        final builder = DiagnosticPropertiesBuilder();
        widget.debugFillProperties(builder);

        final offsetProp = builder.properties.firstWhere((p) => p.name == 'offset');
        final countProp = builder.properties.firstWhere((p) => p.name == 'count');
        final effectProp = builder.properties.firstWhere((p) => p.name == 'effect');
        final sizeProp = builder.properties.firstWhere((p) => p.name == 'size');
        final quarterTurnsProp = builder.properties.firstWhere((p) => p.name == 'quarterTurns');

        expect(offsetProp, isA<DoubleProperty>());
        expect(countProp, isA<IntProperty>());
        expect(effectProp, isA<DiagnosticsProperty<IndicatorEffect>>());
        expect(sizeProp, isA<DiagnosticsProperty<Size>>());
        expect(quarterTurnsProp, isA<IntProperty>());
      });

      testWidgets('State classes use correct property types', (tester) async {
        final controller = PageController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SmoothPageIndicator(
                controller: controller,
                count: 3,
              ),
            ),
          ),
        );

        final state = tester.state<State>(find.byType(SmoothPageIndicator));
        final builder = DiagnosticPropertiesBuilder();
        state.debugFillProperties(builder);

        final countProp = builder.properties.firstWhere((p) => p.name == 'count');
        final effectProp = builder.properties.firstWhere((p) => p.name == 'effect');
        final sizeProp = builder.properties.firstWhere((p) => p.name == 'size');
        final quarterTurnsProp = builder.properties.firstWhere((p) => p.name == 'quarterTurns');

        expect(countProp, isA<IntProperty>());
        expect(effectProp, isA<DiagnosticsProperty<IndicatorEffect>>());
        expect(sizeProp, isA<DiagnosticsProperty<Size>>());
        expect(quarterTurnsProp, isA<IntProperty>());
      });
    });

    group('effect from theme', () {
      testWidgets('debugFillProperties shows theme effect when widget effect is null', (tester) async {
        final controller = PageController();

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light().copyWith(
              extensions: const [
                SmoothPageIndicatorTheme(effect: JumpingDotEffect()),
              ],
            ),
            home: Scaffold(
              body: SmoothPageIndicator(
                controller: controller,
                count: 3,
                // effect is null, should use theme's JumpingDotEffect
              ),
            ),
          ),
        );

        final state = tester.state<State>(find.byType(SmoothPageIndicator));
        final builder = DiagnosticPropertiesBuilder();
        state.debugFillProperties(builder);

        final effectProp = builder.properties.firstWhere((p) => p.name == 'effect');
        expect(effectProp.value, isA<JumpingDotEffect>());
      });
    });
  });
}
