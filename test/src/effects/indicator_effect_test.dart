import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('BasicIndicatorEffect (via WormEffect)', () {
    test('calculateSize is implemented correctly', () {
      const effect = WormEffect(
        dotWidth: 10,
        dotHeight: 10,
        spacing: 5,
      );

      final size = effect.calculateSize(4);
      expect(size.width, 10 * 4 + 5 * 3);
      expect(size.height, 10);
    });

    test('hitTestDots returns -1 for out of bounds', () {
      const effect = WormEffect(
        dotWidth: 16,
        spacing: 8,
      );

      expect(effect.hitTestDots(1000, 3, 0), -1);
    });

    test('hitTestDots returns correct index for valid positions', () {
      const effect = WormEffect(
        dotWidth: 16,
        spacing: 8,
      );

      // First dot: 0 to 20 (16 + 8/2 from start, considering spacing/2 offset)
      expect(effect.hitTestDots(5, 5, 0), 0);
      // Second dot
      expect(effect.hitTestDots(25, 5, 0), 1);
      // Third dot
      expect(effect.hitTestDots(50, 5, 0), 2);
    });
  });
}
