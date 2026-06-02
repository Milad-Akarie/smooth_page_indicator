import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  // Regression test for https://github.com/Milad-Akarie/smooth_page_indicator/issues/102
  // offset % 0 == NaN which caused "Unsupported operation: Infinity or NaN toInt"
  // in every painter when count = 0.
  group('count = 0 does not throw', () {
    testWidgets('SmoothPageIndicator renders without error when count is 0',
        (tester) async {
      final controller = PageController();
      await tester.pumpWidget(MaterialApp(
        home: SmoothPageIndicator(
          controller: controller,
          count: 0,
        ),
      ));
      // No exception should be thrown during build or paint.
      expect(tester.takeException(), isNull);
      controller.dispose();
    });

    testWidgets('AnimatedSmoothIndicator renders without error when count is 0',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: AnimatedSmoothIndicator(
          activeIndex: 0,
          count: 0,
        ),
      ));
      expect(tester.takeException(), isNull);
    });
  });
}
