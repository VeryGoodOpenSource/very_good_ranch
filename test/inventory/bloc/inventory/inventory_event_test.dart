// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

void main() {
  group('InventoryEvent', () {
    group('AddFoodItem', () {
      test('can be instantiated', () {
        expect(AddFoodItem(FoodType.candy), isNotNull);
      });

      test('supports value equality', () {
        expect(
          AddFoodItem(FoodType.candy),
          equals(AddFoodItem(FoodType.candy)),
        );
      });
    });

    group('RemoveFoodItem', () {
      test('can be instantiated', () {
        expect(RemoveFoodItem(FoodType.candy), isNotNull);
      });

      test('supports value equality', () {
        expect(
          RemoveFoodItem(FoodType.candy),
          equals(RemoveFoodItem(FoodType.candy)),
        );
      });
    });
  });
}
