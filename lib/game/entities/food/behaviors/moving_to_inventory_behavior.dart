import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:very_good_ranch/game/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

class MovingToInventoryBehavior extends DoubleTapBehavior<Food>
    with FlameBlocReader<InventoryBloc, InventoryState> {
  @override
  bool onDoubleTapDown(TapDownInfo info) {
    parent.removeFromParent();
    bloc.add(FoodItemAdded(parent.type));
    return false;
  }
}
