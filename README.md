
# smooth_page_indicator
  <p >  
<a href="https://img.shields.io/badge/License-MIT-green"><img   
align="center" src="https://img.shields.io/badge/License-MIT-green" alt="MIT License"></a>    
<a href="https://github.com/Milad-Akarie/smooth_page_indicator/stargazers"><img align="center" src="https://img.shields.io/github/stars/Milad-Akarie/smooth_page_indicator?style=flat&logo=github&colorB=green&label=stars" alt="stars"></a>    
<a href="https://pub.dev/packages/smooth_page_indicator/versions/1.0.0"><img   
align="center" src="https://img.shields.io/pub/v/smooth_page_indicator.svg" alt="pub version"></a>    
<a href="https://www.buymeacoffee.com/miladakarie" target="_blank"><img align="center" src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="30px" width= "108px"></a>  
</p>    

## Introduction
Page indicators are a crucial part of any app that involves multiple pages. They help users to  
understand the number of pages and their current position. `SmoothPageIndicator` is a Flutter  
package that provides a set of animated page indicators with a variety of effects.

![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/four_squares_demo.gif?raw=true)


## Effects
`SmoothPageIndicator` comes with a set of built-in effects that you can use to animate the active dot,  
you can also customize each effect to your liking.

for more specific customization, try the `CustomizableEffect` which allows for more customization.

| Effect                                    |                                                         Preview                                                          |  
|:------------------------------------------|:------------------------------------------------------------------------------------------------------------------------:|  
| Worm                                      |              ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/worm.gif?raw=true)               |
| Worm  style = WormStyle.thin [v1.0.0]     |            ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/worm-thin.gif?raw=true)            |
| Expanding Dots                            |          ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/expanding-dot.gif?raw=true)          |
| Jumping dot                               |           ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/jumping-dot.gif?raw=true)           | 
| Jumping dot with vertical offset [v1.0.0] | ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/jumping-dot-effect-with-voffset.gif?raw=true) | 
| Scrolling Dots                            |        ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/scrolling-dots-2.gif?raw=true)         | 
| Slide                                     |              ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/slide.gif?raw=true)              |
| Scale                                     |              ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/scale.gif?raw=true)              | 
| Swap                                      |              ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/swap.gif?raw=true)               | 
| Swap type = SwapType.yRotation [v1.0.0]   |         ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/swap-yrotation.gif?raw=true)          |
| Color Transition [0.1.2]                  |        ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/color-transition.gif?raw=true)         | 
| Customizable demo-1 [v1.0.0]              |         ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/custimizable-1.gif?raw=true)          | 
| Customizable demo-2 [v1.0.0]              |         ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/customizable-2.gif?raw=true)          | 
| Customizable demo-3 [v1.0.0]              |         ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/customizable-3.gif?raw=true)          | 
| Customizable demo-4 [v1.0.0]              |         ![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/customizable-4.gif?raw=true)          |

## Usage
`SmoothPageIndicator` uses the PageController's scroll offset to animate the active dot.

```dart
SmoothPageIndicator(    
   controller: controller,  // PageController    
   count:  6,    
   effect:  WormEffect(),  // your preferred effect    
   onDotClicked: (index){    
  }
)    
   
```   
## Usage without a PageController
Unlike `SmoothPageIndicator`, `AnimatedSmoothIndicator` is self animated and all it needs is the  
active index.

```dart 
AnimatedSmoothIndicator(    
   activeIndex: yourActiveIndex,    
   count: 6,    
   effect: WormEffect(), 
)    
```   
## Vertical layout support
Smooth page indicator supports both horizontal and vertical layouts.

```dart  
SmoothPageIndicator(    
   controller: controller,  // PageController    
   count:  6,    
   axisDirection: Axis.vertical,    
   effect:  WormEffect(), 
)    
```
![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/vertical_demo.gif?raw=true)

## Scrolling dots effect
Smooth page indicator comes with a shipped it scrolling dots effect, (similar to the one used in instagram), it's useful when you have a large number of pages.

![](https://github.com/Milad-Akarie/smooth_page_indicator/blob/master/demo/smooth_page_indicator_demo_4.gif?raw=true)

## Customization
Each effect comes with its own set of properties that you can customize to your liking.   
for example, you can customize direction, width, height, radius, spacing, paint style, color and more... of `SlideEffect` like follows:

```dart 
  SmoothPageIndicator(    
   controller: controller,    
   count:  6,    
   axisDirection: Axis.vertical,    
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

## Support the Library

You can support the library by liking it on pub, staring in on Github and reporting any bugs you  
encounter.