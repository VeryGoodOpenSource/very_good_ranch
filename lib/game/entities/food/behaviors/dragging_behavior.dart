import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';

class DraggingBehavior extends DraggableBehavior<Food> {
  @override
  bool onDragStart(DragStartInfo info) {
    parent
      ..wasDragged = false
      ..beingDragged = true;
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
    parent.beingDragged = false;
    return false;
  }

  @override
  bool onDragCancel() {
    parent.beingDragged = false;
    return false;
  }

  void _wasDraggedBefore() {
    firstChild<TimerComponent>()?.removeFromParent();

    parent.wasDragged = true;
    add(
      TimerComponent(
        period: 5,
        onTick: () => parent.wasDragged = false,
        removeOnFinish: true,
      ),
    );
  }
}
