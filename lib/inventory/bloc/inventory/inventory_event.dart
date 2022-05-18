part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();
}

class AddFoodItem extends InventoryEvent {
  const AddFoodItem(this.type);

  final FoodType type;

  @override
  List<Object> get props => [type];
}

class RemoveFoodItem extends InventoryEvent {
  const RemoveFoodItem(this.type);

  final FoodType type;

  @override
  List<Object> get props => [type];
}
