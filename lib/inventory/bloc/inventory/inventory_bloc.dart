import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ranch_components/ranch_components.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(InventoryState()) {
    on<AddFoodItem>(_onAddFoodItem);
    on<RemoveFoodItem>(_onRemoveFoodItem);
  }

  void _onAddFoodItem(AddFoodItem event, Emitter<InventoryState> emit) {
    emit(state.copyWith(foodItems: {...state.foodItems, event.item}));
  }

  void _onRemoveFoodItem(RemoveFoodItem event, Emitter<InventoryState> emit) {
    emit(state.copyWith(foodItems: {...state.foodItems}..remove(event.item)));
  }
}
