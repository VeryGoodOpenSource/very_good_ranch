import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class CollisionBehavior extends PositionComponent
    with HasParent<Unicorn>, CollisionCallbacks {
  CollisionBehavior() : super(children: [RectangleHitbox()]);

  void _onParentResize() {
    size = parent.size;
  }

  @override
  Future<void>? onMount() {
    super.onMount();
    size = parent.size;
    parent.size.addListener(_onParentResize);
    return null;
  }

  @override
  void onRemove() {
    parent.size.removeListener(_onParentResize);
    super.onRemove();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is FoodComponent) {
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
