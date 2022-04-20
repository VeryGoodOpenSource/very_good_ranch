import 'package:flame/components.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

class MovementBehavior extends TimerComponent
    with HasGameRef<VeryGoodRanchGame>, HasParent<Unicorn> {
  MovementBehavior() : super(period: 10, repeat: true);

  final speed = 10;

  Vector2 direction = Vector2.zero();

  @override
  void update(double dt) {
    if (parent.state == UnicornState.roaming) {
      parent.position += direction * (speed * dt);
      parent.position.clamp(parent.size, gameRef.size - parent.size);

      if (parent.position.x == 0 ||
          parent.position.x == gameRef.size.x ||
          parent.position.y == 0 ||
          parent.position.y == gameRef.size.y) {
        parent.state = UnicornState.idle;
        direction.setZero();
      }
    }
    super.update(dt);
  }

  @override
  void onTick() {
    if (gameRef.seed.nextDouble() < 0.5) {
      parent.state = UnicornState.roaming;
      direction =
          Vector2.random(gameRef.seed) * (gameRef.seed.nextBool() ? 1 : -1);

      final isFlipped = parent.transform.scale.x < 0;
      if (direction.x < 0) {
        // If it isn't flipped, flip it.
        if (!isFlipped) {
          parent.flipHorizontallyAroundCenter();
        }
      } else {
        // If it was flipped, un-flip it.
        if (isFlipped) {
          parent.flipHorizontallyAroundCenter();
        }
      }
    } else {
      parent.state = UnicornState.idle;
      direction.setZero();
    }
  }
}
