import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ranch_ui/ranch_ui.dart';

/// {@template modal_theme}
/// An inherited widget that defines visual properties for
/// [Modal]s in this widget's subtree.
/// {@endtemplate}
class ModalTheme extends InheritedWidget {
  /// {@macro modal_theme}
  const ModalTheme({
    super.key,
    required super.child,
    required this.data,
  });

  /// The actual values for the theme
  final ModalThemeData data;

  /// The default theme data for [ModalTheme]
  static final defaultTheme = ModalThemeData(
    outerPadding: const EdgeInsets.all(16),
    innerPadding: const EdgeInsets.only(
      top: 16,
      left: 16,
      bottom: 24,
      right: 16,
    ),
    sliderThemeData: const SliderThemeData(
      activeTrackColor: HoverMaterialStateColor(0xFF674FB2),
      inactiveTrackColor: HoverMaterialStateColor(0xFFFFF4E0),
      thumbColor: HoverMaterialStateColor(0xFF674FB2),
      overlayColor: HoverMaterialStateColor(0x22674FB2),
    ),
    dividerThemeData: const DividerThemeData(
      color: Color(0x14000000),
      space: 32,
    ),
    elevatedButtonThemeData: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const HoverMaterialStateColor(
          0xFF805BD4,
          hover: Color(0xFF99FDFF),
        ),
        overlayColor: const HoverMaterialStateColor(
          0xFF805BD4,
          hover: Color(0xFF99FDFF),
        ),
        foregroundColor: const HoverMaterialStateColor(
          0xFFFFFFFF,
          hover: Color(0xFF56469B),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 23,
          ),
        ),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(1.54),
            ),
          ),
        ),
        textStyle: MaterialStatePropertyAll(
          RanchUITheme.minorFontTextStyle.copyWith(
            fontSize: 18,
            height: 1.33,
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
    contentResizeDuration: const Duration(milliseconds: 100),
    sizeConstraints: const BoxConstraints(
      maxWidth: 296,
      minHeight: 200,
    ),
    cardDecoration: const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color(0x26000000),
          blurRadius: 52,
        ),
        BoxShadow(
          color: Color(0x26000000),
          blurRadius: 28,
        ),
        BoxShadow(
          color: Color(0x26000000),
          blurRadius: 18,
        ),
      ],
    ),
    cardBorderRadius: BorderRadius.circular(16),
    cardColor: const Color(0xFFFFF4E0),
    closeButtonDecoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF805BD4), width: 4),
      borderRadius: BorderRadius.circular(40),
      color: const Color(0xFFFFFFFF),
      boxShadow: const [
        BoxShadow(
          color: Color(0x26000000),
          blurRadius: 8,
          offset: Offset(0, 1),
        ),
        BoxShadow(
          color: Color(0x1E000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
        BoxShadow(
          color: Color(0x19000000),
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
      ],
    ),
    closeButtonIconColor: const Color(0xFF805BD4),
    titleTextStyle: RanchUITheme.mainFontTextStyle.copyWith(
      fontSize: 32,
      height: 1.25,
      letterSpacing: 1.28,
      color: const Color(0xFF674FB2),
      shadows: [
        const Shadow(
          color: Color(0xFF9CFFFE),
          offset: Offset(0, 1),
        ),
      ],
      fontWeight: FontWeight.w400,
    ),
    titleTextAlign: TextAlign.center,
  );

  /// The closest instance of this theme that encloses the given context.
  ///
  /// If there is no enclosing [ModalTheme] widget, then
  /// [ModalTheme.defaultTheme] is used.
  static ModalThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<ModalTheme>();
    return theme?.data ?? defaultTheme;
  }

  @override
  bool updateShouldNotify(ModalTheme oldWidget) => data != oldWidget.data;
}

/// {@template modal_theme_data}
/// Defines default property values for descendant [Modal] widgets.
/// {@endtemplate}
class ModalThemeData extends Equatable {
  /// {@macro modal_theme_data}
  const ModalThemeData({
    required this.outerPadding,
    required this.innerPadding,
    required this.sliderThemeData,
    required this.dividerThemeData,
    required this.elevatedButtonThemeData,
    required this.contentResizeDuration,
    required this.sizeConstraints,
    required this.cardDecoration,
    required this.cardBorderRadius,
    required this.cardColor,
    required this.closeButtonDecoration,
    required this.closeButtonIconColor,
    required this.titleTextStyle,
    required this.titleTextAlign,
  });

  /// The padding outside the modal card
  final EdgeInsets outerPadding;

  /// The padding inside the modal card
  final EdgeInsets innerPadding;

  /// Default theme for sliders within the modal
  final SliderThemeData sliderThemeData;

  /// Default theme for dividers within the modal
  final DividerThemeData dividerThemeData;

  /// Default theme for elevated buttons within the modal
  final ElevatedButtonThemeData elevatedButtonThemeData;

  /// Resize animation  duration for when modal content size changes
  final Duration contentResizeDuration;

  /// Size constraints for the modal card
  final BoxConstraints sizeConstraints;

  // card style

  /// Decoration for the modal card
  final BoxDecoration cardDecoration;

  /// Radius for the corners of the modal
  final BorderRadius cardBorderRadius;

  /// The background color for the modal card
  final Color cardColor;

  // close button

  /// Decoration for the close button
  final BoxDecoration closeButtonDecoration;

  /// The color of the close icon
  final Color closeButtonIconColor;

  // title

  /// Style for the title text
  final TextStyle titleTextStyle;

  /// Title text Align
  final TextAlign titleTextAlign;

  @override
  List<Object?> get props => [
        outerPadding,
        innerPadding,
        sliderThemeData,
        dividerThemeData,
        elevatedButtonThemeData,
        contentResizeDuration,
        sizeConstraints,
        cardDecoration,
        cardBorderRadius,
        cardColor,
        closeButtonDecoration,
        closeButtonIconColor,
        titleTextStyle,
        titleTextAlign
      ];
}

/// {@template hover_state_color}
/// A [MaterialStateColor] that resolves to [hover] if there is a
/// [MaterialState.hovered] and hover is not null. Otherwise resovles to
/// the default [value].
/// {@endtemplate}
class HoverMaterialStateColor extends MaterialStateColor {
  /// {@macro hover_state_color}
  const HoverMaterialStateColor(super.defaultValue, {this.hover});

  /// The color to be resolved to when the user hovers.
  final Color? hover;

  @override
  Color resolve(Set<MaterialState> states) {
    final hover = this.hover;
    if (hover != null &&
        (states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.pressed))) {
      return hover;
    }
    return this;
  }
}
