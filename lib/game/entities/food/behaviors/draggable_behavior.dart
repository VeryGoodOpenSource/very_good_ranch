import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';

class DraggableBehavior extends SyncedSizeToParentComponent<Food>
    with Draggable {
  @override
  bool onDragUpdate(DragUpdateInfo info) {
    parent.position.add(info.delta.game);
    return false;
  }
}