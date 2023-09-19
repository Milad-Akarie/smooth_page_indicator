import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_page_indicator/src/painters/swap_painter.dart';

void main(){
  late final SwapEffect swapEffect;
  const int count = 4;


  test("SwapEffect.normal Test Case", (){
    SwapEffect swapEffect = const SwapEffect(type: SwapType.normal);
    var expectedSize = const Size(96, 16);
    expect(swapEffect.type, SwapType.normal);
    expect(swapEffect.dotHeight, 16);
    expect(swapEffect.dotWidth, 16);
    expect(swapEffect.spacing, 8);
    expect(swapEffect.radius, 16);
    expect(swapEffect.paintStyle, PaintingStyle.fill);
    expect(swapEffect.calculateSize(count), equals(expectedSize));

    var painter = swapEffect.buildPainter(count, 3/*offset*/);
    expect(painter, isA<SwapPainter>());
    painter = painter as SwapPainter;


    expect(painter.distance, 24, reason: "It is not equal to [width + spacing]");

    expect(painter.buildStillDot(1, expectedSize).toString(), RRect.fromLTRBR(
        24.0, 0.0, 40.0, 16.0, const Radius.circular(16)
    ).toString());

    var rect = painter.calcPortalTravel(expectedSize, 8/*offset*/, 0.004/*dot offset*/);
    var target = RRect.fromLTRBR(8.0, 8.0, 8.0, 8.0, const Radius.circular(0.1));
    expect(rect.toString(), equals(target.toString()), //toString ignores the precise calculated values
        reason: ("The Rectangle is not same as expected when switching indicators form 1st to last and last to first vice versa."
            "\nCalcPortalTravel enables the support for infinite loop view-pagers."));
  });
  test("SwapEffect.yRotation Test Case ", (){
    SwapEffect swapEffect = const SwapEffect(type: SwapType.yRotation);
    var expectedSize = const Size(96, 40);
    expect(swapEffect.type, SwapType.yRotation);

    expect(swapEffect.calculateSize(count), equals(expectedSize));

    var painter = swapEffect.buildPainter(count, 3/*offset*/) as SwapPainter;

    expect(painter.distance, 24, reason: "It is not equal to [width + spacing]");

    expect(painter.buildStillDot(1, expectedSize).toString(), RRect.fromLTRBR(
        24.0, 12.0, 40.0, 28.0, const Radius.circular(16)
    ).toString());

    var rect = painter.calcPortalTravel(expectedSize, 8/*offset*/, 0.004/*dot offset*/);
    var target = RRect.fromLTRBR(8.0, 20.0, 8.0, 20.0, const Radius.circular(0.1));
    expect(rect.toString(), equals(target.toString()), //toString ignores the precise calculated values
        reason: ("The Rectangle is not same as expected when switching indicators form 1st to last and last to first vice versa."
            "\nCalcPortalTravel enables the support for infinite loop view-pagers."));
  });

  test("SwapEffect.zRotation Test Case ", (){
    SwapEffect swapEffect = const SwapEffect(type: SwapType.zRotation);
    var expectedSize = const Size(96, 19.2);
    expect(swapEffect.type, SwapType.zRotation);

    expect(swapEffect.calculateSize(count), equals(expectedSize));

    var painter = swapEffect.buildPainter(count, 3/*offset*/) as SwapPainter;

    expect(painter.distance, 24, reason: "It is not equal to [width + spacing]");

    expect(painter.buildStillDot(1, expectedSize).toString(), RRect.fromLTRBR(
        24.0, 1.6, 40.0, 17.6, const Radius.circular(16)
    ).toString());

    var rect = painter.calcPortalTravel(expectedSize, 8/*offset*/, 0.004/*dot offset*/);
    var target = RRect.fromLTRBR(8.0, 9.6, 8.0, 9.6, const Radius.circular(0.1));
    expect(rect.toString(), equals(target.toString()), //toString ignores the precise calculated values
        reason: ("The Rectangle is not same as expected when switching indicators form 1st to last and last to first vice versa."
            "\nCalcPortalTravel enables the support for infinite loop view-pagers."));
  });
}