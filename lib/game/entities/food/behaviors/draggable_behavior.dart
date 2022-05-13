import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';

// TODO(wolfen): discuss if we should have a generic one on `flame_behaviors`.
class DraggableBehavior extends Behavior<Food> with Draggable {
  @override
  bool onDragUpdate(DragUpdateInfo info) {
    parent.position.add(info.delta.game);
    return false;
  }

  @override
  bool containsPoint(Vector2 point) {
    return parent.containsPoint(point);
  }
}
