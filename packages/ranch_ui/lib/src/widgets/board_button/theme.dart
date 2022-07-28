import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:ranch_ui/src/theme/theme.dart';
import 'package:ranch_ui/src/widgets/board_button/board_button.dart';

/// {@template board_button_theme}
/// An inherited widget that defines visual properties for
/// [BoardButton]s in this widget's subtree.
/// {@endtemplate}
class BoardButtonTheme extends InheritedWidget {
  /// {@macro board_button_theme}
  const BoardButtonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Create a [BoardButtonTheme] with [BoardButtonTheme.minor] as data.
  factory BoardButtonTheme.minor({
    Key? key,
    required Widget child,
  }) {
    return BoardButtonTheme(
      key: key,
      data: minorTheme,
      child: child,
    );
  }

  /// The default theme data for [BoardButtonTheme]
  static final defaultTheme = BoardButtonThemeData(
    animationDuration: const Duration(milliseconds: 150),
    size: const Size(150, 80),
    textStyle: RanchUITheme.minorFontTextStyle.copyWith(
      fontSize: 30,
      color: const Color(0xFF674FB2),
      shadows: [
        const Shadow(
          color: Color(0xFF9CFFFE),
          offset: Offset(1, 2),
        ),
      ],
      fontWeight: FontWeight.bold,
    ),
  );

  /// A theme data for [BoardButtonTheme] that is just like [defaultTheme]
  /// but just a little bit smaller.
  static final minorTheme = BoardButtonThemeData(
    animationDuration: const Duration(milliseconds: 150),
    size: const Size(126, 47),
    textStyle: RanchUITheme.minorFontTextStyle.copyWith(
      fontSize: 18,
      color: const Color(0xFF674FB2),
      shadows: [
        const Shadow(
          color: Color(0xFF9CFFFE),
          offset: Offset(0, 1),
        ),
      ],
      fontWeight: FontWeight.bold,
    ),
  );

  /// The closest instance of this theme that encloses the given context.
  ///
  /// If there is no enclosing [BoardButtonTheme] widget, then
  /// [BoardButtonTheme.defaultTheme] is used.
  static BoardButtonThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<BoardButtonTheme>();
    return theme?.data ?? defaultTheme;
  }

  /// The actual values for the theme
  final BoardButtonThemeData data;

  @override
  bool updateShouldNotify(BoardButtonTheme oldWidget) => data != oldWidget.data;
}

/// {@template board_button_theme_data}
/// Defines default property values for descendant [BoardButton] widgets.
/// {@endtemplate}
class BoardButtonThemeData extends Equatable {
  /// {@macro board_button_theme_data}
  const BoardButtonThemeData({
    required this.animationDuration,
    required this.size,
    required this.textStyle,
  });

  /// The animation duration for transitions between states (hover, mouse up
  /// and mouse down).
  final Duration animationDuration;

  ///  The size of the button .
  final Size size;

  /// The text style for texts inside the button.
  final TextStyle textStyle;

  @override
  List<Object?> get props => [
        animationDuration,
        size,
        textStyle,
      ];
}
