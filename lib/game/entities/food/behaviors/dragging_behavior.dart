import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';

class DraggingBehavior extends DraggableBehavior<Food> {
  bool beingDragged = false;

  bool wasDragged = false;

  @override
  bool onDragStart(DragStartInfo info) {
    wasDragged = false;
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
    _wasDraggedBefore();
    beingDragged = false;
    return false;
  }

  @override
  bool onDragCancel() {
    beingDragged = false;
    return false;
  }

  void _wasDraggedBefore() {
    firstChild<TimerComponent>()?.removeFromParent();

    wasDragged = true;
    add(
      TimerComponent(
        period: 5,
        onTick: () => wasDragged = false,
        removeOnFinish: true,
      ),
    );
  }
}
