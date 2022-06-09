import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/game.dart';

class MovementBehavior extends Behavior<Unicorn>
    with HasGameRef<VeryGoodRanchGame> {
  final speed = 10;

  Vector2 direction = Vector2.zero();

  @override
  Future<void>? onLoad() {
    add(TimerComponent(period: 10, repeat: true, onTick: _onTick));
    return null;
  }

  void _onTick() {
    if (gameRef.seed.nextDouble() < 0.5) {
      parent.state = UnicornState.roaming;
      direction =
          Vector2.random(gameRef.seed) * (gameRef.seed.nextBool() ? 1 : -1);

      final isFlipped = parent.unicornComponent.transform.scale.x < 0;
      if (direction.x < 0) {
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
    } else {
      parent.state = UnicornState.idle;
      direction.setZero();
    }
  }

  @override
  void update(double dt) {
    if (parent.state == UnicornState.roaming) {
      parent.position += direction * (speed * dt);

      final origin = gameRef.background.pastureArea.topLeft.toVector2();
      final limit =
          gameRef.background.pastureArea.bottomRight.toVector2() - parent.size;

      parent.position.clamp(origin, limit);

      final goingRight = direction.x > 0;
      final goingBottom = direction.y > 0;

      if ((goingRight && parent.position.x == limit.x) ||
          (!goingRight && parent.position.x == 0) ||
          (goingBottom && parent.position.y == limit.y) ||
          (!goingBottom && parent.position.y == 0)) {
        parent.state = UnicornState.idle;
        direction.setZero();
      }
    }

    super.update(dt);
  }
}
