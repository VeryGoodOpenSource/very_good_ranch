import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ranch_ui/ranch_ui.dart';

/// {@template unicorn_counter_theme}
/// An inherited widget that defines visual properties for [UnicornCounter]s
/// in this widget's subtree.
/// {@endtemplate}
class UnicornCounterTheme extends InheritedWidget {
  /// {@macro unicorn_counter_theme}
  const UnicornCounterTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The default theme data for [UnicornCounterTheme]
  static final defaultTheme = UnicornCounterThemeData(
    activeColor: const Color(0xFF0D6052),
    inactiveColor: const Color(0xFF46B2A0),
    textStyle: RanchUITheme.mainFontTextStyle.copyWith(
      fontSize: 16,
      color: const Color(0xFFFFF4E0),
      fontWeight: FontWeight.normal,
    ),
    size: 40,
  );

  /// The closest instance of this theme that encloses the given context.
  ///
  /// If there is no enclosing [UnicornCounterTheme] widget, then
  /// [UnicornCounterTheme.defaultTheme] is used.
  static UnicornCounterThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<UnicornCounterTheme>();
    return theme?.data ?? defaultTheme;
  }

  /// The actual values for the theme
  final UnicornCounterThemeData data;

  @override
  bool updateShouldNotify(UnicornCounterTheme oldWidget) =>
      data != oldWidget.data;
}

/// {@template unicorn_counter_theme_data}
/// Defines default property values for descendant [UnicornCounter] widgets.
/// {@endtemplate}
class UnicornCounterThemeData extends Equatable {
  /// {@macro unicorn_counter_theme_data}
  const UnicornCounterThemeData({
    required this.activeColor,
    required this.inactiveColor,
    required this.textStyle,
    required this.size,
  });

  /// The active color of the counter.
  final Color activeColor;

  /// The inactive color of the counter.
  final Color inactiveColor;

  /// The text style for texts inside the counter.
  final TextStyle textStyle;

  /// The size of the counter.
  final double size;

  @override
  List<Object?> get props => [activeColor, inactiveColor];
}
