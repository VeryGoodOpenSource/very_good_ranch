import 'package:flame/components.dart';
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

      final isFlipped = parent.transform.scale.x < 0;
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
      parent.position.clamp(parent.size, gameRef.size - parent.size);

      if (parent.position.x == parent.size.x ||
          parent.position.x == gameRef.size.x - parent.size.x ||
          parent.position.y == parent.size.y ||
          parent.position.y == gameRef.size.y - parent.size.y) {
        parent.state = UnicornState.idle;
        direction.setZero();
      }
    }
    super.update(dt);
  }
}
