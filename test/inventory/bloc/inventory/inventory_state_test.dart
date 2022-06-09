// ignore_for_file: prefer_const_constructors,
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

void main() {
  group('InventoryState', () {
    test('supports value equality', () {
      expect(
        InventoryState(foodItems: [FoodType.cake]),
        equals(InventoryState(foodItems: [FoodType.cake])),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(InventoryState(), isNotNull);
      });
    });

    group('copyWith', () {
      test('returns a new instance with the given food items', () {
        final state = InventoryState(foodItems: [FoodType.cake]);
        expect(
          state.copyWith(foodItems: [FoodType.pancake]),
          equals(
            InventoryState(foodItems: [FoodType.pancake]),
          ),
        );
      });

      test('returns a new instance with the old food items', () {
        final state = InventoryState(foodItems: [FoodType.cake]);
        expect(
          state.copyWith(),
          equals(
            InventoryState(foodItems: [FoodType.cake]),
          ),
        );
      });
    });
  });
}
