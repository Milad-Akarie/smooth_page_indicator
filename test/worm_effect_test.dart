import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/worm_painter.dart';

void main(){
  late final WormEffect wormEffect;
  const int count = 4;
  setUpAll(() => wormEffect = const WormEffect());

  test("WormEffect.any Test Case : This test case is same for all different types [normal, thin, underground, thinUnderground]", (){
    var expectedSize = const Size(88, 16);
    expect(wormEffect.type, WormType.normal);
    expect(wormEffect.dotHeight, 16);
    expect(wormEffect.dotWidth, 16);
    expect(wormEffect.spacing, 8);
    expect(wormEffect.radius, 16);
    expect(wormEffect.paintStyle, PaintingStyle.fill);
    expect(wormEffect.calculateSize(count), equals(expectedSize));

    var painter = wormEffect.buildPainter(count, 4/*offset*/);
    expect(painter, isA<WormPainter>());
    painter = painter as WormPainter;


    expect(painter.distance, 24, reason: "It is not equal to [width + spacing]");

    expect(painter.buildStillDot(1, expectedSize), RRect.fromLTRBR(
        24.0, 0.0, 40.0, 16.0,
        Radius.circular(wormEffect.radius)
    ));

    var rect = painter.calcPortalTravel(expectedSize, 8/*offset*/, 0.004/*dot offset*/);
    var target = RRect.fromLTRBR(8.0, 8.0, 8.0, 8.0, const Radius.circular(0.1));
    expect(rect.toString(), equals(target.toString()), //toString ignores the precise calculated values
        reason: ("The Rectangle is not same as expected when switching indicators form 1st to last and last to first vice versa."
            "\nCalcPortalTravel enables the support for infinite loop view-pagers."));
  });
}