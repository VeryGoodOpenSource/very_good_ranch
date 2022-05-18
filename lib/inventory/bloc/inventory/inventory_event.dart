part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();
}

class AddFoodItem extends InventoryEvent {
  const AddFoodItem(this.item);

  final FoodItem item;

  @override
  List<Object> get props => [item];
}

class RemoveFoodItem extends InventoryEvent {
  const RemoveFoodItem(this.item);

  final FoodItem item;

  @override
  List<Object> get props => [item];
}
