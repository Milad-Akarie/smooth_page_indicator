## smooth_page_indicator
##### Customizable animated Page indicators

### Effects
- Worm
- Expanding Dots
- Scrolling Dots
- Jumping dot
- Slide
- Scale
- Swap

![](/demo/smooth_page_indicator_demo_1.gif)

### Usage
---
```dart
SmoothPageIndicator(
  controller: controller, // PageController
  count: 6,
  effect: WormEffect(), // your preferred effect
)
```
### Customization
---
You can customize width, height, radius, spacnig, paint style, color and more...
```dart
SmoothPageIndicator(
  controller: controller,
  count: 6,
  effect: SlideEffect(
    spacing: 8.0,
    radius: 4.0,
    dotWidth: 24.0,
    dotHeight: 16.0,
    paintStyle: PaintingStyle.stroke,
    strokeWidth: 1.5,
    dotColor: Colors.grey,
    activeDotColor: Colors.indigo
  ),
)
```

![](/demo/smooth_page_indicator_demo_2.gif)

### RTL Support
---
Smooth page indicator supports RTL.

```dart
SmoothPageIndicator(
  controller: controller, // PageController
  count: 6,
  // set isRTL to true
  effect: WormEffect(isRTL: true), 
)
```

![](/demo/smooth_page_indicator_demo_3.gif)
