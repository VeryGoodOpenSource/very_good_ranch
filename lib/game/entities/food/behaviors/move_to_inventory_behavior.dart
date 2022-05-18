import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

class MoveToInventoryBehavior extends Behavior<Food>
    with
        Tappable,
        FlameBlocListenable<InventoryBloc, InventoryState>,
        FlameBlocReader<InventoryBloc, InventoryState> {
  @override
  bool onLongTapDown(TapDownInfo info) {
    bloc.add(AddFoodItem(FoodItem(type: parent.type)));
    parent.shouldRemove = true;
    return false;
  }

  @override
  bool containsPoint(Vector2 point) {
    return parent.containsPoint(point);
  }
}
