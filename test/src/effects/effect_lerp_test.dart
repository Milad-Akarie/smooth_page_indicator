import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('WormEffect lerp', () {
    test('returns this when other is null', () {
      const effect = WormEffect();
      expect(effect.lerp(null, 0.5), effect);
    });

    test('lerps numeric properties at t=0.5', () {
      const effect1 = WormEffect(
        dotWidth: 10,
        dotHeight: 10,
        spacing: 8,
        radius: 5,
        strokeWidth: 1,
      );
      const effect2 = WormEffect(
        dotWidth: 20,
        dotHeight: 20,
        spacing: 16,
        radius: 10,
        strokeWidth: 3,
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.dotWidth, 15.0);
      expect(result.dotHeight, 15.0);
      expect(result.spacing, 12.0);
      expect(result.radius, 7.5);
      expect(result.strokeWidth, 2.0);
    });

    test('lerps colors', () {
      const effect1 = WormEffect(
        dotColor: Color(0xFF000000),
        activeDotColor: Color(0xFF000000),
      );
      const effect2 = WormEffect(
        dotColor: Color(0xFFFFFFFF),
        activeDotColor: Color(0xFFFFFFFF),
      );

      final result = effect1.lerp(effect2, 0.5);

      expect((result.dotColor!.r * 255.0).round().clamp(0, 255), closeTo(128, 1));
      expect((result.activeDotColor!.r * 255.0).round().clamp(0, 255), closeTo(128, 1));
    });

    test('switches type at t=0.5', () {
      const effect1 = WormEffect(type: WormType.normal);
      const effect2 = WormEffect(type: WormType.thin);

      final resultBefore = effect1.lerp(effect2, 0.4);
      final resultAfter = effect1.lerp(effect2, 0.6);

      expect(resultBefore.type, WormType.normal);
      expect(resultAfter.type, WormType.thin);
    });

    test('switches paintStyle at t=0.5', () {
      const effect1 = WormEffect(paintStyle: PaintingStyle.fill);
      const effect2 = WormEffect(paintStyle: PaintingStyle.stroke);

      final resultBefore = effect1.lerp(effect2, 0.4);
      final resultAfter = effect1.lerp(effect2, 0.6);

      expect(resultBefore.paintStyle, PaintingStyle.fill);
      expect(resultAfter.paintStyle, PaintingStyle.stroke);
    });
  });

  group('ExpandingDotsEffect lerp', () {
    test('returns this when other is null', () {
      const effect = ExpandingDotsEffect();
      expect(effect.lerp(null, 0.5), effect);
    });

    test('lerps expansionFactor', () {
      const effect1 = ExpandingDotsEffect(expansionFactor: 2);
      const effect2 = ExpandingDotsEffect(expansionFactor: 4);

      final result = effect1.lerp(effect2, 0.5);

      expect(result.expansionFactor, 3.0);
    });

    test('lerps all numeric properties', () {
      const effect1 = ExpandingDotsEffect(
        expansionFactor: 2,
        dotWidth: 10,
        dotHeight: 10,
        spacing: 8,
        radius: 5,
      );
      const effect2 = ExpandingDotsEffect(
        expansionFactor: 4,
        dotWidth: 20,
        dotHeight: 20,
        spacing: 16,
        radius: 10,
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.expansionFactor, 3.0);
      expect(result.dotWidth, 15.0);
      expect(result.dotHeight, 15.0);
      expect(result.spacing, 12.0);
      expect(result.radius, 7.5);
    });
  });

  group('SlideEffect lerp', () {
    test('returns this when other is null', () {
      const effect = SlideEffect();
      expect(effect.lerp(null, 0.5), effect);
    });

    test('lerps numeric properties', () {
      const effect1 = SlideEffect(
        dotWidth: 10,
        dotHeight: 10,
        spacing: 8,
      );
      const effect2 = SlideEffect(
        dotWidth: 20,
        dotHeight: 20,
        spacing: 16,
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.dotWidth, 15.0);
      expect(result.dotHeight, 15.0);
      expect(result.spacing, 12.0);
    });

    test('switches type at t=0.5', () {
      const effect1 = SlideEffect(type: SlideType.normal);
      const effect2 = SlideEffect(type: SlideType.slideUnder);

      final resultBefore = effect1.lerp(effect2, 0.4);
      final resultAfter = effect1.lerp(effect2, 0.6);

      expect(resultBefore.type, SlideType.normal);
      expect(resultAfter.type, SlideType.slideUnder);
    });
  });

  group('ScaleEffect lerp', () {
    test('returns this when other is null', () {
      const effect = ScaleEffect();
      expect(effect.lerp(null, 0.5), effect);
    });

    test('lerps scale and other numeric properties', () {
      const effect1 = ScaleEffect(
        scale: 1.2,
        activeStrokeWidth: 1,
        dotWidth: 10,
        dotHeight: 10,
      );
      const effect2 = ScaleEffect(
        scale: 1.8,
        activeStrokeWidth: 3,
        dotWidth: 20,
        dotHeight: 20,
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.scale, 1.5);
      expect(result.activeStrokeWidth, 2.0);
      expect(result.dotWidth, 15.0);
      expect(result.dotHeight, 15.0);
    });

    test('switches activePaintStyle at t=0.5', () {
      const effect1 = ScaleEffect(activePaintStyle: PaintingStyle.fill);
      const effect2 = ScaleEffect(activePaintStyle: PaintingStyle.stroke);

      final resultBefore = effect1.lerp(effect2, 0.4);
      final resultAfter = effect1.lerp(effect2, 0.6);

      expect(resultBefore.activePaintStyle, PaintingStyle.fill);
      expect(resultAfter.activePaintStyle, PaintingStyle.stroke);
    });
  });

  group('SwapEffect lerp', () {
    test('returns this when other is null', () {
      const effect = SwapEffect();
      expect(effect.lerp(null, 0.5), effect);
    });

    test('lerps numeric properties', () {
      const effect1 = SwapEffect(
        dotWidth: 10,
        dotHeight: 10,
        spacing: 8,
      );
      const effect2 = SwapEffect(
        dotWidth: 20,
        dotHeight: 20,
        spacing: 16,
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.dotWidth, 15.0);
      expect(result.dotHeight, 15.0);
      expect(result.spacing, 12.0);
    });

    test('switches type at t=0.5', () {
      const effect1 = SwapEffect(type: SwapType.normal);
      const effect2 = SwapEffect(type: SwapType.yRotation);

      final resultBefore = effect1.lerp(effect2, 0.4);
      final resultAfter = effect1.lerp(effect2, 0.6);

      expect(resultBefore.type, SwapType.normal);
      expect(resultAfter.type, SwapType.yRotation);
    });
  });

  group('JumpingDotEffect lerp', () {
    test('returns this when other is null', () {
      const effect = JumpingDotEffect();
      expect(effect.lerp(null, 0.5), effect);
    });

    test('lerps jumpScale and verticalOffset', () {
      const effect1 = JumpingDotEffect(
        jumpScale: 1.2,
        verticalOffset: 0,
      );
      const effect2 = JumpingDotEffect(
        jumpScale: 1.8,
        verticalOffset: 10,
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.jumpScale, 1.5);
      expect(result.verticalOffset, 5.0);
    });

    test('lerps all numeric properties', () {
      const effect1 = JumpingDotEffect(
        jumpScale: 1.2,
        verticalOffset: 0,
        dotWidth: 10,
        dotHeight: 10,
        spacing: 8,
      );
      const effect2 = JumpingDotEffect(
        jumpScale: 1.8,
        verticalOffset: 10,
        dotWidth: 20,
        dotHeight: 20,
        spacing: 16,
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.jumpScale, 1.5);
      expect(result.verticalOffset, 5.0);
      expect(result.dotWidth, 15.0);
      expect(result.dotHeight, 15.0);
      expect(result.spacing, 12.0);
    });
  });

  group('ScrollingDotsEffect lerp', () {
    test('returns this when other is null', () {
      const effect = ScrollingDotsEffect();
      expect(effect.lerp(null, 0.5), effect);
    });

    test('lerps scale properties', () {
      const effect1 = ScrollingDotsEffect(
        activeDotScale: 1.2,
        smallDotScale: 0.5,
        activeStrokeWidth: 1,
      );
      const effect2 = ScrollingDotsEffect(
        activeDotScale: 1.6,
        smallDotScale: 0.8,
        activeStrokeWidth: 3,
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.activeDotScale, 1.4);
      expect(result.smallDotScale, 0.65);
      expect(result.activeStrokeWidth, 2.0);
    });

    test('switches maxVisibleDots at t=0.5', () {
      const effect1 = ScrollingDotsEffect(maxVisibleDots: 5);
      const effect2 = ScrollingDotsEffect(maxVisibleDots: 7);

      final resultBefore = effect1.lerp(effect2, 0.4);
      final resultAfter = effect1.lerp(effect2, 0.6);

      expect(resultBefore.maxVisibleDots, 5);
      expect(resultAfter.maxVisibleDots, 7);
    });

    test('switches fixedCenter at t=0.5', () {
      const effect1 = ScrollingDotsEffect(fixedCenter: false);
      const effect2 = ScrollingDotsEffect(fixedCenter: true);

      final resultBefore = effect1.lerp(effect2, 0.4);
      final resultAfter = effect1.lerp(effect2, 0.6);

      expect(resultBefore.fixedCenter, false);
      expect(resultAfter.fixedCenter, true);
    });
  });

  group('ColorTransitionEffect lerp', () {
    test('returns this when other is null', () {
      const effect = ColorTransitionEffect();
      expect(effect.lerp(null, 0.5), effect);
    });

    test('lerps activeStrokeWidth', () {
      const effect1 = ColorTransitionEffect(activeStrokeWidth: 1);
      const effect2 = ColorTransitionEffect(activeStrokeWidth: 3);

      final result = effect1.lerp(effect2, 0.5);

      expect(result.activeStrokeWidth, 2.0);
    });

    test('lerps all numeric properties', () {
      const effect1 = ColorTransitionEffect(
        activeStrokeWidth: 1,
        dotWidth: 10,
        dotHeight: 10,
        spacing: 8,
        strokeWidth: 1,
      );
      const effect2 = ColorTransitionEffect(
        activeStrokeWidth: 3,
        dotWidth: 20,
        dotHeight: 20,
        spacing: 16,
        strokeWidth: 3,
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.activeStrokeWidth, 2.0);
      expect(result.dotWidth, 15.0);
      expect(result.dotHeight, 15.0);
      expect(result.spacing, 12.0);
      expect(result.strokeWidth, 2.0);
    });
  });

  group('CustomizableEffect lerp', () {
    test('returns this when other is null', () {
      const effect = CustomizableEffect(
        dotDecoration: DotDecoration(),
        activeDotDecoration: DotDecoration(),
      );
      expect(effect.lerp(null, 0.5), effect);
    });

    test('lerps spacing', () {
      const effect1 = CustomizableEffect(
        dotDecoration: DotDecoration(),
        activeDotDecoration: DotDecoration(),
        spacing: 8,
      );
      const effect2 = CustomizableEffect(
        dotDecoration: DotDecoration(),
        activeDotDecoration: DotDecoration(),
        spacing: 16,
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.spacing, 12.0);
    });

    test('lerps dot decorations', () {
      const effect1 = CustomizableEffect(
        dotDecoration: DotDecoration(width: 10, height: 10),
        activeDotDecoration: DotDecoration(width: 12, height: 12),
      );
      const effect2 = CustomizableEffect(
        dotDecoration: DotDecoration(width: 20, height: 20),
        activeDotDecoration: DotDecoration(width: 24, height: 24),
      );

      final result = effect1.lerp(effect2, 0.5);

      expect(result.dotDecoration.width, 15.0);
      expect(result.dotDecoration.height, 15.0);
      expect(result.activeDotDecoration.width, 18.0);
      expect(result.activeDotDecoration.height, 18.0);
    });

    test('switches color overrides at t=0.5', () {
      Color colorBuilder1(int index) => Colors.red;
      Color colorBuilder2(int index) => Colors.blue;

      final effect1 = CustomizableEffect(
        dotDecoration: const DotDecoration(),
        activeDotDecoration: const DotDecoration(),
        activeColorOverride: colorBuilder1,
        inActiveColorOverride: colorBuilder1,
      );
      final effect2 = CustomizableEffect(
        dotDecoration: const DotDecoration(),
        activeDotDecoration: const DotDecoration(),
        activeColorOverride: colorBuilder2,
        inActiveColorOverride: colorBuilder2,
      );

      final resultBefore = effect1.lerp(effect2, 0.4);
      final resultAfter = effect1.lerp(effect2, 0.6);

      expect(resultBefore.activeColorOverride, colorBuilder1);
      expect(resultAfter.activeColorOverride, colorBuilder2);
      expect(resultBefore.inActiveColorOverride, colorBuilder1);
      expect(resultAfter.inActiveColorOverride, colorBuilder2);
    });
  });

  group('Lerp edge cases', () {
    test('lerp at t=0 returns first effect values', () {
      const effect1 = WormEffect(dotWidth: 10);
      const effect2 = WormEffect(dotWidth: 20);

      final result = effect1.lerp(effect2, 0.0);

      expect(result.dotWidth, 10.0);
    });

    test('lerp at t=1 returns second effect values', () {
      const effect1 = WormEffect(dotWidth: 10);
      const effect2 = WormEffect(dotWidth: 20);

      final result = effect1.lerp(effect2, 1.0);

      expect(result.dotWidth, 20.0);
    });

    test('lerp handles null colors gracefully', () {
      const effect1 = WormEffect(dotColor: null, activeDotColor: null);
      const effect2 = WormEffect(dotColor: Colors.red, activeDotColor: Colors.blue);

      final result = effect1.lerp(effect2, 0.5);

      // Color.lerp with null returns interpolated value
      expect(result.dotColor, isNotNull);
      expect(result.activeDotColor, isNotNull);
    });

    test('lerp with same values returns equivalent effect', () {
      const effect = WormEffect(
        dotWidth: 16,
        dotHeight: 16,
        spacing: 8,
        type: WormType.normal,
      );

      final result = effect.lerp(effect, 0.5);

      expect(result.dotWidth, effect.dotWidth);
      expect(result.dotHeight, effect.dotHeight);
      expect(result.spacing, effect.spacing);
      expect(result.type, effect.type);
    });
  });
}
