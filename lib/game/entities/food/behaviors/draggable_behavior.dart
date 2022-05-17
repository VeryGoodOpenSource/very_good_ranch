import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';

class DraggableBehavior extends Behavior<Food> with Draggable {
  bool beingDragged = false;

  @override
  bool onDragStart(DragStartInfo info) {
    beingDragged = true;
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    parent.position.add(info.delta.game);
    return false;
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    beingDragged = false;
    return false;
  }

  @override
  bool onDragCancel() {
    beingDragged = false;
    return false;
  }

  @override
  bool containsPoint(Vector2 point) {
    return parent.containsPoint(point);
  }
}
