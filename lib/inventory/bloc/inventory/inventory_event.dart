part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();
}

class FoodItemAdded extends InventoryEvent {
  const FoodItemAdded(this.type);

  final FoodType type;

  @override
  List<Object> get props => [type];
}

class FoodItemRemoved extends InventoryEvent {
  const FoodItemRemoved(this.type);

  final FoodType type;

  @override
  List<Object> get props => [type];
}
