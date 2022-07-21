import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class DraggingBehavior extends DraggableBehavior<Food> with HasGameRef {
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
    // Check if we are colliding with something, if we aren't then we are
    // gonna check if we are being within the bounds of a unicorn.
    if (!(parent.firstChild<RectangleHitbox>()?.isColliding ?? false)) {
      final unicorns =
          gameRef.componentsAtPoint(parent.center).whereType<Unicorn>();

      final unicorn = unicorns.isNotEmpty ? unicorns.first : null;
      if (unicorn != null && !parent.isRemoving) {
        unicorn.feed(parent);
      }
    }

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
