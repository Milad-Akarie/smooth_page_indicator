## smooth_page_indicator

##### Customizable animated page indicator with a set of built-in effects.

![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/smooth_page_indicator_demo_1.gif?raw=true)

##### New! Scrolling dots effect

![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/smooth_page_indicator_demo_4.gif?raw=true)

### Effects

| Effect                    |                                                  Preview                                                  |
| :------------------------ | :-------------------------------------------------------------------------------------------------------: |
| Worm                      |       ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/worm.gif?raw=true)       |
| Expanding Dots            |  ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/expanding-dot.gif?raw=true)   |
| Jumping dot               |   ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/jumping-dot.gif?raw=true)    |
| Scrolling Dots -> 0.1.5   |  ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/scrolling-dots-2.gif?raw=true)  |
| Slide                     |      ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/slide.gif?raw=true)       |
| Scale                     |      ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/scale.gif?raw=true)       |
| Swap                      |       ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/swap.gif?raw=true)       |
| Color Transition -> 0.1.2 | ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/color-transition.gif?raw=true) |

### Usage

---

```dart
SmoothPageIndicator(
	controller: controller,  // PageController
	count:  6,
	effect:  WormEffect(),  // your preferred effect
)

```

### Customization

---

You can customize width, height, radius, spacing, paint style, color and more...

```dart
SmoothPageIndicator(
	controller: controller,
	count:  6,
	effect:  SlideEffect(
	spacing:  8.0,
	radius:  4.0,
	dotWidth:  24.0,
	dotHeight:  16.0,
	paintStyle:  PaintingStyle.stroke,
	strokeWidth:  1.5,
	dotColor:  Colors.grey,
	activeDotColor:  Colors.indigo
	),
)

```

![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/smooth_page_indicator_demo_2.gif?raw=true)

### RTL Support

---

Smooth page indicator will inherit directionality from it's ancestors unless you specify a directionality by passing it directly to the widget or wrapping the Indicator with a Directionality widget from the flutter package.

```dart
SmoothPageIndicator(
	controller: controller,  // PageController
	count:  6,

	// forcing the indicator to use a specific direction
	textDirection: TextDirection.rtl
	effect:  WormEffect(),
);

```

![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/smooth_page_indicator_demo_3.gif?raw=true)

### Support the Library

You can support the library by staring in on Github or report any bugs you encounter.
