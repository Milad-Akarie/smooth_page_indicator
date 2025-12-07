import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('DefaultIndicatorColors', () {
    test('creates instance with required parameters', () {
      const colors = DefaultIndicatorColors(
        active: Colors.blue,
        inactive: Colors.grey,
      );
      expect(colors.active, Colors.blue);
      expect(colors.inactive, Colors.grey);
    });

    test('defaults static instance has correct values', () {
      expect(DefaultIndicatorColors.defaults.active, Colors.indigo);
      expect(DefaultIndicatorColors.defaults.inactive, Colors.grey);
    });

    test('resolveActiveColor returns effect activeDotColor when not null', () {
      const colors = DefaultIndicatorColors(
        active: Colors.blue,
        inactive: Colors.grey,
      );
      const effect = WormEffect(activeDotColor: Colors.red);
      expect(colors.resolveActiveColor(effect), Colors.red);
    });

    test(
        'resolveActiveColor returns active color when effect activeDotColor is null',
        () {
      const colors = DefaultIndicatorColors(
        active: Colors.blue,
        inactive: Colors.grey,
      );
      const effect = WormEffect();
      expect(colors.resolveActiveColor(effect), Colors.blue);
    });

    test('resolveInactiveColor returns effect dotColor when not null', () {
      const colors = DefaultIndicatorColors(
        active: Colors.blue,
        inactive: Colors.grey,
      );
      const effect = WormEffect(dotColor: Colors.green);
      expect(colors.resolveInactiveColor(effect), Colors.green);
    });

    test(
        'resolveInactiveColor returns inactive color when effect dotColor is null',
        () {
      const colors = DefaultIndicatorColors(
        active: Colors.blue,
        inactive: Colors.grey,
      );
      const effect = WormEffect();
      expect(colors.resolveInactiveColor(effect), Colors.grey);
    });

    test('lerp returns this when other is null', () {
      const colors = DefaultIndicatorColors(
        active: Colors.blue,
        inactive: Colors.grey,
      );
      expect(colors.lerp(null, 0.5), colors);
    });

    test('lerp at t=0 returns first color values', () {
      const colors1 = DefaultIndicatorColors(
        active: Colors.blue,
        inactive: Colors.grey,
      );
      const colors2 = DefaultIndicatorColors(
        active: Colors.red,
        inactive: Colors.green,
      );
      final result = colors1.lerp(colors2, 0.0);
      expect(result.active.value, Colors.blue.value);
      expect(result.inactive.value, Colors.grey.value);
    });

    test('lerp at t=1 returns second color values', () {
      const colors1 = DefaultIndicatorColors(
        active: Colors.blue,
        inactive: Colors.grey,
      );
      const colors2 = DefaultIndicatorColors(
        active: Colors.red,
        inactive: Colors.green,
      );
      final result = colors1.lerp(colors2, 1.0);
      expect(result.active.value, Colors.red.value);
      expect(result.inactive.value, Colors.green.value);
    });

    test('lerp at t=0.5 returns midpoint colors', () {
      const colors1 = DefaultIndicatorColors(
        active: Color(0xFF000000),
        inactive: Color(0xFF000000),
      );
      const colors2 = DefaultIndicatorColors(
        active: Color(0xFFFFFFFF),
        inactive: Color(0xFFFFFFFF),
      );
      final result = colors1.lerp(colors2, 0.5);
      // Check approximately midpoint
      expect((result.active.r * 255).round(), closeTo(128, 1));
      expect((result.inactive.r * 255).round(), closeTo(128, 1));
    });
  });

  group('SmoothPageIndicatorTheme', () {
    test('creates instance with null values by default', () {
      const theme = SmoothPageIndicatorTheme();
      expect(theme.effect, isNull);
      expect(theme.defaultColors, isNull);
    });

    test('creates instance with provided values', () {
      const effect = WormEffect();
      const colors = DefaultIndicatorColors(
        active: Colors.blue,
        inactive: Colors.grey,
      );
      const theme = SmoothPageIndicatorTheme(
        effect: effect,
        defaultColors: colors,
      );
      expect(theme.effect, effect);
      expect(theme.defaultColors, colors);
    });

    test('copyWith copies with new effect', () {
      const original = SmoothPageIndicatorTheme(
        effect: WormEffect(),
        defaultColors:
            DefaultIndicatorColors(active: Colors.blue, inactive: Colors.grey),
      );
      const newEffect = ExpandingDotsEffect();
      final copied = original.copyWith(effect: newEffect);
      expect(copied.effect, newEffect);
      expect(copied.defaultColors, original.defaultColors);
    });

    test('copyWith copies with new colors', () {
      const original = SmoothPageIndicatorTheme(
        effect: WormEffect(),
        defaultColors:
            DefaultIndicatorColors(active: Colors.blue, inactive: Colors.grey),
      );
      const newColors = DefaultIndicatorColors(
        active: Colors.red,
        inactive: Colors.green,
      );
      final copied = original.copyWith(colors: newColors);
      expect(copied.effect, original.effect);
      expect(copied.defaultColors, newColors);
    });

    test('copyWith keeps original values when null passed', () {
      const original = SmoothPageIndicatorTheme(
        effect: WormEffect(),
        defaultColors:
            DefaultIndicatorColors(active: Colors.blue, inactive: Colors.grey),
      );
      final copied = original.copyWith();
      expect(copied.effect, original.effect);
      expect(copied.defaultColors, original.defaultColors);
    });

    test('lerp returns this when other is not SmoothPageIndicatorTheme', () {
      const theme = SmoothPageIndicatorTheme(effect: WormEffect());
      final result = theme.lerp(null, 0.5);
      expect(result, theme);
    });

    test('lerp lerps same effect types', () {
      const theme1 = SmoothPageIndicatorTheme(effect: WormEffect(dotWidth: 10));
      const theme2 = SmoothPageIndicatorTheme(effect: WormEffect(dotWidth: 20));
      final result = theme1.lerp(theme2, 0.5);
      expect(result.effect, isA<WormEffect>());
      expect((result.effect as WormEffect).dotWidth, 15.0);
    });

    test('lerp switches effect at t=0.5 for different types', () {
      const theme1 = SmoothPageIndicatorTheme(effect: WormEffect());
      const theme2 = SmoothPageIndicatorTheme(effect: ExpandingDotsEffect());
      final resultBefore = theme1.lerp(theme2, 0.4);
      final resultAfter = theme1.lerp(theme2, 0.6);
      expect(resultBefore.effect, isA<WormEffect>());
      expect(resultAfter.effect, isA<ExpandingDotsEffect>());
    });

    test('lerp lerps colors when both non-null', () {
      const theme1 = SmoothPageIndicatorTheme(
        defaultColors: DefaultIndicatorColors(
          active: Color(0xFF000000),
          inactive: Color(0xFF000000),
        ),
      );
      const theme2 = SmoothPageIndicatorTheme(
        defaultColors: DefaultIndicatorColors(
          active: Color(0xFFFFFFFF),
          inactive: Color(0xFFFFFFFF),
        ),
      );
      final result = theme1.lerp(theme2, 0.5);
      expect((result.defaultColors!.active.r * 255).round(), closeTo(128, 1));
      expect((result.defaultColors!.inactive.r * 255).round(), closeTo(128, 1));
    });

    test('lerp handles null colors in first theme', () {
      const theme1 = SmoothPageIndicatorTheme();
      const theme2 = SmoothPageIndicatorTheme(
        defaultColors:
            DefaultIndicatorColors(active: Colors.red, inactive: Colors.green),
      );
      final resultBefore = theme1.lerp(theme2, 0.4);
      final resultAfter = theme1.lerp(theme2, 0.6);
      expect(resultBefore.defaultColors, isNull);
      expect(resultAfter.defaultColors, theme2.defaultColors);
    });

    testWidgets('of returns null when no theme extension', (tester) async {
      SmoothPageIndicatorTheme? theme;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              theme = SmoothPageIndicatorTheme.of(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(theme, isNull);
    });

    testWidgets('of returns theme when extension is present', (tester) async {
      const expectedTheme = SmoothPageIndicatorTheme(
        effect: ExpandingDotsEffect(),
        defaultColors:
            DefaultIndicatorColors(active: Colors.blue, inactive: Colors.grey),
      );
      SmoothPageIndicatorTheme? theme;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(extensions: [expectedTheme]),
          home: Builder(
            builder: (context) {
              theme = SmoothPageIndicatorTheme.of(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(theme, isNotNull);
      expect(theme!.effect, isA<ExpandingDotsEffect>());
      expect(theme!.defaultColors?.active, Colors.blue);
    });

    testWidgets('resolveDefaults returns theme effect and colors when present',
        (tester) async {
      const expectedTheme = SmoothPageIndicatorTheme(
        effect: ExpandingDotsEffect(),
        defaultColors:
            DefaultIndicatorColors(active: Colors.blue, inactive: Colors.grey),
      );
      late (IndicatorEffect, DefaultIndicatorColors) result;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(extensions: [expectedTheme]),
          home: Builder(
            builder: (context) {
              result = SmoothPageIndicatorTheme.resolveDefaults(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(result.$1, isA<ExpandingDotsEffect>());
      expect(result.$2.active, Colors.blue);
      expect(result.$2.inactive, Colors.grey);
    });

    testWidgets(
        'resolveDefaults returns WormEffect and context colors when no theme',
        (tester) async {
      late (IndicatorEffect, DefaultIndicatorColors) result;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(primaryColor: Colors.purple),
          home: Builder(
            builder: (context) {
              result = SmoothPageIndicatorTheme.resolveDefaults(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(result.$1, isA<WormEffect>());
      expect(result.$2.active, Colors.purple);
    });
  });

  group('Theme integration', () {
    testWidgets('SmoothPageIndicator uses theme effect when not specified',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: const [
              SmoothPageIndicatorTheme(
                  effect: ExpandingDotsEffect(expansionFactor: 2.5)),
            ],
          ),
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: PageController(),
              count: 5,
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('SmoothPageIndicator uses provided effect over theme',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: const [
              SmoothPageIndicatorTheme(effect: ExpandingDotsEffect())
            ],
          ),
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: PageController(),
              count: 5,
              effect: const WormEffect(),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('AnimatedSmoothIndicator uses theme effect when not specified',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: const [SmoothPageIndicatorTheme(effect: ScaleEffect())],
          ),
          home: const Scaffold(
            body: AnimatedSmoothIndicator(activeIndex: 0, count: 5),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
    });

    testWidgets('SmoothIndicator uses theme colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: const [
              SmoothPageIndicatorTheme(
                defaultColors: DefaultIndicatorColors(
                    active: Colors.purple, inactive: Colors.orange),
              ),
            ],
          ),
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: PageController(),
              count: 5,
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });
  });
}
