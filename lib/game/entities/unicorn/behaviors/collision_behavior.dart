import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class CollisionBehavior extends PositionComponent
    with HasParent<Unicorn>, SyncSizeWithParent, CollisionCallbacks {
  CollisionBehavior() : super(children: [RectangleHitbox()]);
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is FoodComponent) {
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
