import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Holds theme-derived default colors for the indicator
class DefaultIndicatorColors {
  /// The color for active dots (defaults to theme's primary color)
  final Color active;

  /// The color for inactive dots (defaults to theme's primary color with reduced opacity)
  final Color inactive;

  /// Creates an [DefaultIndicatorColors] instance
  const DefaultIndicatorColors({
    required this.active,
    required this.inactive,
  });

  /// Resolves [dotColor] using the provided [DefaultIndicatorColors] if null
  Color resolveInactiveColor(BasicIndicatorEffect effect) {
    return effect.dotColor ?? inactive;
  }

  /// Resolves [activeDotColor] using the provided [DefaultIndicatorColors] if null
  Color resolveActiveColor(BasicIndicatorEffect effect) {
    return effect.activeDotColor ?? active;
  }

  /// Creates [DefaultIndicatorColors] from the given [BuildContext]
  /// using the app's primary color
  factory DefaultIndicatorColors.fromContext(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultIndicatorColors(
      active: theme.primaryColor,
      inactive: theme.unselectedWidgetColor.withValues(alpha: .1),
    );
  }

  /// Default indicator colors
  static const defaults = DefaultIndicatorColors(
    active: Colors.indigo,
    inactive: Colors.grey,
  );

  /// Linearly interpolates between two [DefaultIndicatorColors].
  DefaultIndicatorColors lerp(DefaultIndicatorColors? other, double t) {
    if (other == null) return this;
    return DefaultIndicatorColors(
      active: Color.lerp(active, other.active, t)!,
      inactive: Color.lerp(inactive, other.inactive, t)!,
    );
  }
}

/// A [ThemeExtension] that provides default configuration for [SmoothPageIndicator]
/// and [AnimatedSmoothIndicator] widgets.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: ThemeData.light().copyWith(
///     extensions: [
///       SmoothPageIndicatorTheme(
///         effect: ExpandingDotsEffect(),
///         colors: IndicatorColors(
///           active: Colors.blue,
///           inactive: Colors.grey,
///         ),
///       ),
///     ],
///   ),
/// )
/// ```
class SmoothPageIndicatorTheme extends ThemeExtension<SmoothPageIndicatorTheme> {
  /// The default effect to use when none is specified.
  /// If null, [WormEffect] will be used as the fallback.
  final IndicatorEffect? effect;

  /// Theme colors for the indicator.
  /// If null, colors will be derived from the app theme.
  final DefaultIndicatorColors? defaultColors;

  /// Creates a [SmoothPageIndicatorTheme] instance
  const SmoothPageIndicatorTheme({
    this.effect,
    this.defaultColors,
  });

  @override
  SmoothPageIndicatorTheme copyWith({
    IndicatorEffect? effect,
    DefaultIndicatorColors? colors,
  }) {
    return SmoothPageIndicatorTheme(
      effect: effect ?? this.effect,
      defaultColors: colors ?? this.defaultColors,
    );
  }

  @override
  SmoothPageIndicatorTheme lerp(
    covariant ThemeExtension<SmoothPageIndicatorTheme>? other,
    double t,
  ) {
    if (other is! SmoothPageIndicatorTheme) {
      return this;
    }

    // Lerp effects if both are non-null and same type
    IndicatorEffect? lerpedEffect;
    if (effect != null && other.effect != null && effect.runtimeType == other.effect.runtimeType) {
      lerpedEffect = effect!.lerp(other.effect, t);
    } else {
      lerpedEffect = t < 0.5 ? effect : other.effect;
    }

    // Lerp colors if both are non-null
    final lerpedColors = defaultColors?.lerp(other.defaultColors, t) ?? (t < 0.5 ? null : other.defaultColors);

    return SmoothPageIndicatorTheme(
      effect: lerpedEffect,
      defaultColors: lerpedColors,
    );
  }

  /// Retrieves the [SmoothPageIndicatorTheme] from the given [BuildContext].
  /// Returns null if no theme extension is found.
  static SmoothPageIndicatorTheme? of(BuildContext context) {
    return Theme.of(context).extension<SmoothPageIndicatorTheme>();
  }

  static (IndicatorEffect effect, DefaultIndicatorColors colors) resolveDefaults(
    BuildContext context,
  ) {
    final theme = SmoothPageIndicatorTheme.of(context);
    final effect = theme?.effect ?? const WormEffect();
    final colors = theme?.defaultColors ?? DefaultIndicatorColors.fromContext(context);
    return (effect, colors);
  }
}
