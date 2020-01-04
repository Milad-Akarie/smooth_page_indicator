## smooth_page_indicator
##### Customizable animated page indicator with a set of built-in effects.


![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/smooth_page_indicator_demo_1.gif?raw=true)

### Effects
- Worm
- Expanding Dots
- Scrolling Dots
- Jumping dot
- Slide
- Scale
- Swap

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
You can customize width, height, radius, spacing, paint style, color and more...
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

![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/smooth_page_indicator_demo_2.gif?raw=true)

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

![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/smooth_page_indicator_demo_3.gif?raw=true)
