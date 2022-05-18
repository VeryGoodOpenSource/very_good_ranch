// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

void main() {
  group('InventoryState', () {
    test('supports value equality', () {
      expect(
        InventoryState(foodItems: {FoodItem(type: FoodType.candy)}),
        equals(InventoryState(foodItems: {FoodItem(type: FoodType.candy)})),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(InventoryState(), isNotNull);
      });
    });

    group('copyWith', () {
      test('returns a new instance with the given food items', () {
        final state = InventoryState(
          foodItems: {FoodItem(type: FoodType.candy)},
        );
        expect(
          state.copyWith(foodItems: {FoodItem(type: FoodType.pancake)}),
          equals(InventoryState(foodItems: {FoodItem(type: FoodType.pancake)})),
        );
      });

      test('returns a new instance with the old food items', () {
        final state = InventoryState(
          foodItems: {FoodItem(type: FoodType.candy)},
        );
        expect(
          state.copyWith(),
          equals(InventoryState(foodItems: {FoodItem(type: FoodType.candy)})),
        );
      });
    });
  });
}
