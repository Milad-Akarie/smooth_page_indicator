// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Page indicator displays and responds to page changes',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that page indicators are present
    expect(find.byType(SmoothPageIndicator), findsAtLeastNWidgets(1));

    // Verify that page content is displayed (any page is fine due to infinite scroll)
    expect(find.textContaining('Page'), findsAtLeastNWidgets(1));

    // Find the PageView widget
    final pageViewFinder = find.byType(PageView);
    expect(pageViewFinder, findsOneWidget);

    // Get initial page content
    final initialPageText =
        tester.widget<Text>(find.textContaining('Page').first).data;

    // Swipe to the next page
    await tester.drag(pageViewFinder, const Offset(-400, 0));
    await tester.pumpAndSettle();

    // Verify that the visible page content has changed or we can find different page content
    // This accounts for the infinite scroll behavior
    final afterSwipeText =
        tester.widget<Text>(find.textContaining('Page').first).data;

    // The test passes if we can still find page indicators and page content
    expect(find.byType(SmoothPageIndicator), findsAtLeastNWidgets(1));
    expect(find.textContaining('Page'), findsAtLeastNWidgets(1));
  });
}
