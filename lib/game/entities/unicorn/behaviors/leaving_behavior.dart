import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/widgets.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class LeavingBehavior extends Behavior<Unicorn> {
  static const double happinessThresholdToLeave = 0.1;
  static const double leavingAnimationDuration = 1;
  static const Curve leavingAnimationCurve = Curves.easeIn;

  EffectController? _effectController;

  @override
  void update(double dt) {
    if (parent.happinessFactor <= happinessThresholdToLeave &&
        _effectController == null) {
      _startLeaveAnimation();
    }

    if (_effectController?.completed == true) {
      parent.removeFromParent();
    }
  }

  void _startLeaveAnimation() {
    final effectController = _effectController = CurvedEffectController(
      leavingAnimationDuration,
      leavingAnimationCurve,
    );

    parent.unicornComponent
      ..add(OpacityEffect.fadeOut(effectController))
      ..add(MoveByEffect(Vector2(0, -100), effectController));
  }
}
