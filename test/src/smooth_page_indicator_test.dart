import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('SmoothPageIndicator', () {
    late PageController pageController;

    setUp(() {
      pageController = PageController();
    });

    tearDown(() {
      pageController.dispose();
    });

    testWidgets('renders correctly with default effect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
      expect(find.byType(SmoothIndicator), findsOneWidget);
    });

    testWidgets('renders with WormEffect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              effect: const WormEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('renders with SlideEffect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              effect: const SlideEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('renders with ExpandingDotsEffect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              effect: const ExpandingDotsEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('renders with JumpingDotEffect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              effect: const JumpingDotEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('renders with ScaleEffect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              effect: const ScaleEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('renders with SwapEffect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              effect: const SwapEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('renders with ColorTransitionEffect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              effect: const ColorTransitionEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('renders with ScrollingDotsEffect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 10,
              effect: const ScrollingDotsEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('renders with vertical axis direction', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              axisDirection: Axis.vertical,
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
      expect(find.byType(RotatedBox), findsOneWidget);
    });

    testWidgets('renders with RTL text direction', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: SmoothPageIndicator(
                controller: pageController,
                count: 5,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('renders with explicit RTL text direction', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('onDotClicked callback is triggered on tap', (tester) async {
      int? tappedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 5,
                onDotClicked: (index) {
                  tappedIndex = index;
                },
                effect: const WormEffect(
                  dotWidth: 20,
                  dotHeight: 20,
                  spacing: 10,
                ),
              ),
            ),
          ),
        ),
      );

      final indicatorFinder = find.byType(SmoothIndicator);
      final topLeft = tester.getTopLeft(indicatorFinder);
      await tester.tapAt(topLeft + const Offset(40, 10));
      await tester.pump();

      expect(tappedIndex, equals(1));
    });

    testWidgets('updates when PageController changes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PageView(
              controller: pageController,
              children: List.generate(
                5,
                (index) => Container(
                  color: Colors.primaries[index],
                ),
              ),
            ),
            bottomNavigationBar: SmoothPageIndicator(
              controller: pageController,
              count: 5,
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);

      pageController.jumpToPage(2);
      await tester.pump();

      expect(pageController.page, 2.0);
    });

    testWidgets('handles controller with initial page', (tester) async {
      final controller = PageController(initialPage: 2);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: controller,
              count: 5,
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);

      controller.dispose();
    });

    testWidgets('handles single page', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 1,
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('handles many pages', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 100,
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('updates on widget change', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 5,
              effect: const WormEffect(),
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SmoothPageIndicator(
              controller: pageController,
              count: 10,
              effect: const SlideEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });
  });

  group('SmoothIndicator', () {
    testWidgets('renders correctly with offset', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SmoothIndicator(
              offset: 1.5,
              count: 5,
              size: Size(120, 16),
            ),
          ),
        ),
      );

      expect(find.byType(SmoothIndicator), findsOneWidget);
    });

    testWidgets('renders with different quarter turns', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SmoothIndicator(
              offset: 0,
              count: 5,
              size: Size(120, 16),
              quarterTurns: 1,
            ),
          ),
        ),
      );

      final rotatedBox = tester.widget<RotatedBox>(find.byType(RotatedBox));
      expect(rotatedBox.quarterTurns, 1);
    });
  });

  group('AnimatedSmoothIndicator', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedSmoothIndicator(
              activeIndex: 0,
              count: 5,
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
    });

    testWidgets('animates when activeIndex changes', (tester) async {
      int activeIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: 5,
                      duration: const Duration(milliseconds: 300),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeIndex = 2;
                        });
                      },
                      child: const Text('Change'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Change'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));
      await tester.pump(const Duration(milliseconds: 150));

      expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
    });

    testWidgets('renders with different effects', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedSmoothIndicator(
              activeIndex: 2,
              count: 5,
              effect: ExpandingDotsEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
    });

    testWidgets('renders with vertical axis', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedSmoothIndicator(
              activeIndex: 0,
              count: 5,
              axisDirection: Axis.vertical,
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
    });

    testWidgets('onDotClicked callback is triggered', (tester) async {
      int? tappedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: 0,
                count: 5,
                onDotClicked: (index) {
                  tappedIndex = index;
                },
                effect: const WormEffect(
                  dotWidth: 20,
                  dotHeight: 20,
                  spacing: 10,
                ),
              ),
            ),
          ),
        ),
      );

      final indicatorFinder = find.byType(SmoothIndicator);
      final topLeft = tester.getTopLeft(indicatorFinder);
      await tester.tapAt(topLeft + const Offset(40, 10));
      await tester.pump();

      expect(tappedIndex, equals(1));
    });

    testWidgets('onEnd callback is triggered after animation', (tester) async {
      bool animationEnded = false;
      int activeIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                body: Column(
                  children: [
                    AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: 5,
                      duration: const Duration(milliseconds: 100),
                      onEnd: () {
                        animationEnded = true;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeIndex = 2;
                        });
                      },
                      child: const Text('Change'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Change'));
      await tester.pumpAndSettle();

      expect(animationEnded, isTrue);
    });

    testWidgets('with custom curve', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedSmoothIndicator(
              activeIndex: 0,
              count: 5,
              curve: Curves.bounceOut,
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
    });

    testWidgets('with custom duration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedSmoothIndicator(
              activeIndex: 0,
              count: 5,
              duration: Duration(seconds: 1),
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
    });

    testWidgets('updates on widget change', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedSmoothIndicator(
              activeIndex: 0,
              count: 5,
              effect: WormEffect(),
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AnimatedSmoothIndicator(
              activeIndex: 0,
              count: 10,
              effect: SlideEffect(),
            ),
          ),
        ),
      );

      expect(find.byType(AnimatedSmoothIndicator), findsOneWidget);
    });
  });
}
