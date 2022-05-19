import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ranch_components/ranch_components.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(InventoryState()) {
    on<FoodItemAdded>(_onFoodItemAdded);
    on<FoodItemRemoved>(_onFoodItemRemoved);
  }

  void _onFoodItemAdded(FoodItemAdded event, Emitter<InventoryState> emit) {
    emit(state.copyWith(foodItems: [...state.foodItems, event.type]));
  }

  void _onFoodItemRemoved(FoodItemRemoved event, Emitter<InventoryState> emit) {
    emit(state.copyWith(foodItems: [...state.foodItems]..remove(event.type)));
  }
}
