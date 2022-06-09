// ignore_for_file: prefer_const_constructors,
// ignore_for_file: prefer_const_literals_to_create_immutables

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

    group('FoodItemAdded', () {
      blocTest<InventoryBloc, InventoryState>(
        'add food item to set',
        build: InventoryBloc.new,
        act: (bloc) {
          bloc.add(FoodItemAdded(FoodType.cake));
        },
        expect: () {
          return [
            InventoryState(foodItems: [FoodType.cake])
          ];
        },
      );
    });

    group('FoodItemRemoved', () {
      blocTest<InventoryBloc, InventoryState>(
        'remove food item from set',
        build: InventoryBloc.new,
        seed: () => InventoryState(
          foodItems: [FoodType.cake],
        ),
        act: (bloc) {
          bloc.add(const FoodItemRemoved(FoodType.cake));
        },
        expect: () {
          return [InventoryState(foodItems: [])];
        },
      );
    });
  });
}
