import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class DraggingBehavior extends DraggableBehavior<Unicorn> with HasGameRef {
  DraggingBehavior();

  @override
  bool onDragStart(DragStartInfo info) {
    parent
      ..isGaugeVisible = false
      ..angle = 15 * degrees2Radians;

    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    parent.position.add(info.delta.game);
    return false;
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    onDragCancel();
    return false;
  }

  @override
  bool onDragCancel() {
    parent
      ..isGaugeVisible = true
      ..angle = 0;
    return false;
  }
}
