import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';

class FoodCollisionBehavior extends CollisionBehavior<Food, Unicorn> {
  @override
  void onCollision(Set<Vector2> intersectionPoints, Food other) {
    other.removeFromParent();
  }
}
