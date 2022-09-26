import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';

/// {@template evolution}
/// A [Component] that "evolves" a component into another component,
/// the component on [from] must be an in game component, meaning that
/// it should already have a parent.
/// {@endtemplate}
class Evolution extends Component with ParentIsA<PositionComponent> {
  /// {@macro evolution}
  Evolution({
    required this.from,
    required this.to,
    this.onFinish,
  }) : assert(
          from is HasPaint && to is HasPaint,
          'Evolution can only evolve components that is a HasPaint',
        );

  /// The source component.
  final PositionComponent from;

  /// The component that will be evolved into.
  final PositionComponent to;

  /// Called when the evolution is finished.
  final VoidCallback? onFinish;

  late final PositionComponent _target;

  @override
  Future<void> onLoad() async {
    (to as HasPaint).setOpacity(0);

    assert(
      from.parent != null,
      'Evolution can only evolve components that has a parent',
    );
    _target = parent;

    await _target.add(to);

    to.position = from.size - to.size;
    final originalPosition = to.position.clone();
    final isFlipped = from.transform.scale.x < 0;
    if (isFlipped) {
      to.flipHorizontallyAroundCenter();
    }

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
          _target.position += originalPosition;
          to.position = isFlipped ? Vector2(to.size.x, 0) : Vector2.all(0);
          _target.size = to.size.clone();
          onFinish?.call();

          removeFromParent();

          _target.add(
            ConfettiComponent(
              confettiSize: to.size.y / 10,
            )..position = Vector2(
                _target.size.x / 2,
                _target.size.y,
              ),
          );
        },
    );
  }
}
