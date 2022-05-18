// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

void main() {
  group('InventoryEvent', () {
    group('AddFoodItem', () {
      test('can be instantiated', () {
        expect(AddFoodItem(FoodItem(type: FoodType.candy)), isNotNull);
      });

      test('supports value equality', () {
        expect(
          AddFoodItem(FoodItem(type: FoodType.candy)),
          equals(AddFoodItem(FoodItem(type: FoodType.candy))),
        );
      });
    });

    group('RemoveFoodItem', () {
      test('can be instantiated', () {
        expect(RemoveFoodItem(FoodItem(type: FoodType.candy)), isNotNull);
      });

      test('supports value equality', () {
        expect(
          RemoveFoodItem(FoodItem(type: FoodType.candy)),
          equals(RemoveFoodItem(FoodItem(type: FoodType.candy))),
        );
      });
    });
  });
}
