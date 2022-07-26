import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ranch_ui/src/widgets/progress_bar/widget.dart';

/// {@template animated_progress_bar_theme}
/// An inherited widget that defines visual properties for
/// [AnimatedProgressBar]s in this widget's subtree.
/// {@endtemplate}
class AnimatedProgressBarTheme extends InheritedWidget {
  /// {@macro animated_progress_bar_theme}
  const AnimatedProgressBarTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The default theme data for [AnimatedProgressBarTheme]
  static const defaultTheme = AnimatedProgressBarThemeData(
    Color(0xFF0D6052),
    Color(0xFF99FDFF),
  );

  /// The closest instance of this theme that encloses the given context.
  ///
  /// If there is no enclosing [AnimatedProgressBarTheme] widget, then
  /// [AnimatedProgressBarTheme.defaultTheme] is used.
  static AnimatedProgressBarThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<AnimatedProgressBarTheme>();
    return theme?.data ?? defaultTheme;
  }

  /// The actual values for the theme
  final AnimatedProgressBarThemeData data;

  @override
  bool updateShouldNotify(AnimatedProgressBarTheme oldWidget) =>
      data != oldWidget.data;
}

/// {@template animated_progress_bar_theme_data}
/// Defines default property values for descendant [AnimatedProgressBar]
/// widgets.
/// {@endtemplate}
class AnimatedProgressBarThemeData extends Equatable {
  /// {@macro animated_progress_bar_theme_data}
  const AnimatedProgressBarThemeData(
    this.backgroundColor,
    this.foregroundColor,
  );

  /// The background color of the progress bar.
  final Color backgroundColor;

  /// The foreground color of the progress bar.
  final Color foregroundColor;

  @override
  List<Object?> get props => [backgroundColor, foregroundColor];
}
