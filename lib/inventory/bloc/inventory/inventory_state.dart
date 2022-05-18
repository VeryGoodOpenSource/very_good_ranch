part of 'inventory_bloc.dart';

class InventoryState extends Equatable {
  InventoryState({
    Set<FoodItem>? foodItems,
  }) : foodItems = foodItems ?? {};

  final Set<FoodItem> foodItems;

  InventoryState copyWith({
    Set<FoodItem>? foodItems,
  }) {
    return InventoryState(
      foodItems: foodItems ?? this.foodItems,
    );
  }

  @override
  List<Object> get props => [foodItems];
}

class FoodItem extends Equatable {
  const FoodItem({required this.type});

  final FoodType type;

  @override
  List<Object> get props => [type];
}
