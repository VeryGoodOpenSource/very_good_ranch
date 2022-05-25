part of 'inventory_bloc.dart';

class InventoryState extends Equatable {
  InventoryState({
    List<FoodType>? foodItems,
  }) : foodItems = foodItems ?? [];

  final List<FoodType> foodItems;

  InventoryState copyWith({
    List<FoodType>? foodItems,
  }) {
    return InventoryState(
      foodItems: foodItems ?? this.foodItems,
    );
  }

  @override
  List<Object> get props => [foodItems];
}
