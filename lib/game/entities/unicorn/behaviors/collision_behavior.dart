import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';

class CollisionBehavior extends SyncedSizeToParentComponent<Unicorn>
    with CollisionCallbacks {
  CollisionBehavior() : super(children: [RectangleHitbox()]);

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Food) {
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
