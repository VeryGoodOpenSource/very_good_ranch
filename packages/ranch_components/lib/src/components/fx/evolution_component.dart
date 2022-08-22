import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';

/// {@template evolution}
/// A [Component] that "evolves" a component into another component,
/// the component on [from] must be an in game component, meaning that
/// it should already have a parent.
/// {@endtemplate}
class Evolution extends Component {
  /// {@macro evolution}
  Evolution({
    required this.from,
    required this.to,
  }) : assert(
          from is HasPaint && to is HasPaint,
          'Evolution can only evolve components that is a HasPaint',
        );

  /// The source component.
  final PositionComponent from;

  /// The component that will be evolved into.
  final PositionComponent to;

  late final Component _target;

  @override
  Future<void> onLoad() async {
    (to as HasPaint).setOpacity(0);

    assert(
      from.parent != null,
      'Evolution can only evolve components that has a parent',
    );
    _target = from.parent!;

    await _target.add(to);

    await from.add(
      OpacityEffect.to(
        0,
        RepeatedEffectController(
          CurvedEffectController(
            1,
            Curves.easeInQuad,
          ),
          4,
        ),
      )..onComplete = from.removeFromParent,
    );

    await to.add(
      OpacityEffect.to(
        1,
        RepeatedEffectController(
          CurvedEffectController(
            1,
            Curves.easeInQuad,
          ),
          4,
        ),
      )..onComplete = () {
          removeFromParent();

          _target.add(
            ConfettiComponent(
              confettiSize: to.size.y / 10,
            )..anchor = Anchor.center,
          );
        },
    );
  }
}
