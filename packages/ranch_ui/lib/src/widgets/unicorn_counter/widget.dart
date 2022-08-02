import 'package:flutter/material.dart';
import 'package:ranch_ui/gen/assets.gen.dart';
import 'package:ranch_ui/src/widgets/unicorn_counter/theme.dart';

/// {@template unicorn_counter}
/// A counter that displays a number of unicorns of a certain type.
/// {@endtemplate}
class UnicornCounter extends StatelessWidget {
  /// {@macro unicorn_counter}
  const UnicornCounter({
    super.key,
    required this.child,
    required this.type,
    required this.isActive,
  });

  /// The type of unicorn for which it counts.
  final UnicornType type;

  /// The child widget that will be visualized.
  final Widget child;

  /// Whether the counter is active.
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = UnicornCounterTheme.of(context);
    final color = isActive ? theme.activeColor : theme.inactiveColor;

    return Column(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: color,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: DefaultTextStyle.merge(
              style: theme.textStyle,
              child: child,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: theme.size,
          height: theme.size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.size),
            color: color,
          ),
          clipBehavior: Clip.antiAlias,
          child: Transform.translate(
            offset: const Offset(4, 4),
            child: Image.asset(type._keyName),
          ),
        ),
      ],
    );
  }
}

/// {@template unicorn_type}
/// The type of unicorn for which to count.
/// {@endtemplate}
enum UnicornType {
  /// {@macro unicorn_type}
  ///
  /// The baby unicorn.
  baby,

  /// {@macro unicorn_type}
  ///
  /// The child unicorn.
  child,

  /// {@macro unicorn_type}
  ///
  /// The teen unicorn.
  teen,

  /// {@macro unicorn_type}
  ///
  /// The adult unicorn.
  adult;

  String get _keyName {
    switch (this) {
      case UnicornType.baby:
        return Assets.images.heads.babyHead.keyName;
      case UnicornType.child:
        return Assets.images.heads.childHead.keyName;
      case UnicornType.teen:
        return Assets.images.heads.teenHead.keyName;
      case UnicornType.adult:
        return Assets.images.heads.adultHead.keyName;
    }
  }
}
