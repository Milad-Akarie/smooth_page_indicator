import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Holds theme-derived default colors for the indicator
class ThemeDefaults {
  /// The color for active dots (defaults to theme's primary color)
  final Color activeColor;

  /// The color for inactive dots (defaults to theme's primary color with reduced opacity)
  final Color inActiveColor;

  /// Creates a [ThemeDefaults] instance
  const ThemeDefaults({
    required this.activeColor,
    required this.inActiveColor,
  });

  /// Resolves [dotColor] using the provided [themeDefaults] if null
  Color resolveInactiveColor(BasicIndicatorEffect effect) {
    return effect.dotColor ?? inActiveColor;
  }

  /// Resolves [activeDotColor] using the provided [themeDefaults] if null
  Color resolveActiveColor(BasicIndicatorEffect effect) {
    return effect.activeDotColor ?? activeColor;
  }

  /// Creates [ThemeDefaults] from the given [BuildContext]
  /// using the app's primary color
  factory ThemeDefaults.fromContext(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeDefaults(
      activeColor: theme.primaryColor,
      inActiveColor: theme.unselectedWidgetColor.withValues(alpha: .1),
    );
  }

  /// Default theme defaults
  static const defaults = ThemeDefaults(
    activeColor: Colors.indigo,
    inActiveColor: Colors.grey,
  );
}
