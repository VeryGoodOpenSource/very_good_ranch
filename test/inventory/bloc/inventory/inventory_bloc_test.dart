import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

void main() {
  group('InventoryBloc', () {
    test('initial state has an empty set of food items', () {
      final inventoryBloc = InventoryBloc();
      expect(inventoryBloc.state.foodItems, isEmpty);
    });

    group('AddFoodItem', () {
      blocTest<InventoryBloc, InventoryState>(
        'add food item to set',
        build: InventoryBloc.new,
        act: (bloc) {
          bloc.add(const AddFoodItem(FoodItem(type: FoodType.candy)));
        },
        expect: () {
          return [
            InventoryState(foodItems: {const FoodItem(type: FoodType.candy)})
          ];
        },
      );
    });

    group('RemoveFoodItem', () {
      blocTest<InventoryBloc, InventoryState>(
        'remove food item from set',
        build: InventoryBloc.new,
        seed: () => InventoryState(
          foodItems: {const FoodItem(type: FoodType.candy)},
        ),
        act: (bloc) {
          bloc.add(const RemoveFoodItem(FoodItem(type: FoodType.candy)));
        },
        expect: () {
          return [InventoryState(foodItems: const {})];
        },
      );
    });
  });
}
