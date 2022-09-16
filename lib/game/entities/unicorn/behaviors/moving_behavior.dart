import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/game.dart';

class MovingBehavior extends Behavior<Unicorn>
    with HasGameRef<VeryGoodRanchGame> {
  @override
  Future<void> onLoad() async {
    await add(TimerComponent(period: 10, repeat: true, onTick: _onTick));
  }

  void _onTick() {
    if (parent.beingDragged) {
      return;
    }
    if (gameRef.seed.nextDouble() < 0.5) {
      parent.startWalking();
    } else {
      parent.stopWalking();
    }
  }

  @override
  void update(double dt) {
    final isFlipped = parent.unicornComponent.transform.scale.x < 0;
    if (parent.velocity.x > 0) {
      // If it isn't flipped, flip it.
      if (!isFlipped) {
        parent.unicornComponent.flipHorizontallyAroundCenter();
      }
    } else {
      // If it was flipped, un-flip it.
      if (isFlipped) {
        parent.unicornComponent.flipHorizontallyAroundCenter();
      }
    }

    if (parent.state == UnicornState.walking) {
      final origin = gameRef.background.pastureField.topLeft.toVector2();
      final limit =
          gameRef.background.pastureField.bottomRight.toVector2() - parent.size;

      parent.position.clamp(origin, limit);

      final goingRight = parent.velocity.x > 0;
      final goingBottom = parent.velocity.y > 0;

      final parentPosition = parent.position.clone();

      if ((goingRight && parentPosition.x == limit.x) ||
          (!goingRight && parentPosition.x == origin.x) ||
          (goingBottom && parentPosition.y == limit.y) ||
          (!goingBottom && parentPosition.y == origin.y)) {
        parent.stopWalking();
      }
    }

    super.update(dt);
  }

  @visibleForTesting
  void simulateTick() {
    _onTick();
  }
}
